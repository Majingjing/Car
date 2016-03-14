//
//  SearchViewController.m
//  Car
//
//  Created by 史燕红 on 16/3/14.
//  Copyright © 2016年 麻静. All rights reserved.
//

#import "SearchViewController.h"

#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import "MapDetailViewController.h"


#define SYHKey @"82b0fbd838fc138555e9ed9e697d1132"

@interface SearchViewController ()<UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate, AMapSearchDelegate, MAMapViewDelegate>

{
    AMapSearchAPI *_search;
    MACoordinateRegion region;
    MAUserLocation *_userLocation;
}

@property (nonatomic, weak)MAMapView *mapView;
@property (nonatomic, strong)CLLocationManager *manager;


@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 200, 28)];
    searchBar.delegate = self;
    searchBar.placeholder = @"";
    self.navigationItem.titleView = searchBar;
    
    self.table = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:self.table];
    
    self.table.dataSource = self;
    self.table.delegate = self;
    
    [self.table registerClass:[UITableViewCell class] forCellReuseIdentifier:@"search_cell"];
    self.suggestionArray = [NSMutableArray array];
    
    [self initMapView];
    //配置用户Key
    [AMapSearchServices sharedServices].apiKey = SYHKey;
    
    [_mapView setUserTrackingMode:MAUserTrackingModeFollow animated:YES];
    [self.manager requestAlwaysAuthorization];
    
    self.mapView.showsUserLocation = YES;
    
    // 添加轻拍手势回收键盘
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapDidClicked:)];
    [self.view addGestureRecognizer:tap];
    
}

-(void)tapDidClicked:(UIGestureRecognizer *)sender {
    [self.view endEditing:YES];
}


- (void)initMapView {
    
    [_mapView setFrame:CGRectMake(0, 100, self.view.bounds.size.width, self.view.bounds.size.height -100)];
    [_mapView setDelegate: self];
    
    
}


#pragma mark - 搜索的事件
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    if ([searchBar.text isEqualToString:@""]) {
        return;
    }
    
    //初始化检索对象
    _search = [[AMapSearchAPI alloc] init];
    _search.delegate = self;
    
    AMapGeocodeSearchRequest *request = [[AMapGeocodeSearchRequest alloc] init];
    request.address = searchBar.text;
    
    [_search AMapGeocodeSearch:request];
    
    [self searchAction:searchBar];
    
    [self.table reloadData];
    
    
    
}

- (void)searchAction:(UISearchBar *)sender{
    AMapPOIAroundSearchRequest *request = [[AMapPOIAroundSearchRequest alloc] init];
    
    if (_userLocation)
    {
        request.location = [AMapGeoPoint locationWithLatitude:_userLocation.location.coordinate.latitude
                                                    longitude:_userLocation.location.coordinate.longitude];
    }
    else
    {
        request.location = [AMapGeoPoint   locationWithLatitude:region.center.latitude longitude:region.center.longitude];
    }
    request.keywords = sender.text;
    request.sortrule            = 1;
    request.requireExtension    = NO;
    
    [_search AMapPOIAroundSearch:request];
}




- (void)onGeocodeSearchDone:(AMapGeocodeSearchRequest *)request response:(AMapGeocodeSearchResponse *)response {
    if (response.geocodes.count == 0) {
        return;
    }
    
    NSString *strCount = [NSString stringWithFormat:@"count:%ld", response.count];
    NSString *strGeocodes = @"";
    for (AMapPOI *p in response.geocodes) {
        strGeocodes = [NSString stringWithFormat:@"%@\ngeocode: %@", strGeocodes, p.description];
        region.center = CLLocationCoordinate2DMake(p.location.latitude, p.location.longitude);
        MACoordinateSpan span = MACoordinateSpanMake(0.01, 0.01);
        region.span = span;
        
        [_mapView setRegion:region animated:YES];
        
        MapDetailViewController *mdvc = [[MapDetailViewController alloc] init];
        mdvc.region = region;
        [self presentViewController:mdvc animated:YES completion:nil];
        
        // 查找到位置后插入大头针
        MAPointAnnotation *annotation = [[MAPointAnnotation alloc]init];
        annotation.title = p.district.description;
        annotation.subtitle = p.city;
        annotation.coordinate = CLLocationCoordinate2DMake(p.location.latitude, p.location.longitude);
        
        
        //最后把大头针添加到地图上
        [_mapView addAnnotation: annotation];
        
    }
    NSString *result = [NSString stringWithFormat:@"%@ \n %@", strCount, strGeocodes];
    NSLog(@"Geocode:------ %@", result);
}

- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation {
    if (updatingLocation) {
        _userLocation = userLocation;
    }
}


//实现POI搜索对应的回调函数
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    if(response.pois.count == 0)
    {
        return;
    }
    
    //通过 AMapPOISearchResponse 对象处理搜索结果
    NSString *strCount = [NSString stringWithFormat:@"count: %ld",(long)response.count];
    NSString *strSuggestion = [NSString stringWithFormat:@"Suggestion: %@", response.suggestion];
    NSString *strPoi = @"";
    
    self.suggestionArray = response.pois.mutableCopy;
    
    for (AMapPOI *p in response.pois) {
        strPoi = [NSString stringWithFormat:@"%@\nPOI: %@", strPoi, p.description];
    }
    NSString *result = [NSString stringWithFormat:@"%@ \n %@ \n %@", strCount, strSuggestion, strPoi];
    NSLog(@"Place: %@", result);
}

#pragma mark - tableView 的数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.suggestionArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"search_cell" forIndexPath:indexPath];
    AMapPOI *poi = self.suggestionArray[indexPath.row];
    NSString *str = [NSString stringWithFormat:@"POI: %@", poi.address];
    cell.textLabel.text = str;
    return cell;
}








@end
