//
//  PositionViewController.m
//  Car
//
//  Created by lanou3g on 16/3/8.
//  Copyright © 2016年 麻静. All rights reserved.
//

#import "PositionViewController.h"

#import <MAMapKit/MAMapKit.h>

#import <AMapSearchKit/AMapSearchKit.h>

#define SYHKey @"82b0fbd838fc138555e9ed9e697d1132"

#import "SearchViewController.h"

@interface PositionViewController ()<MAMapViewDelegate,AMapSearchDelegate>

{
    AMapSearchAPI *_search;
}

@property (nonatomic,strong)MAMapView *mapView;

@end


/*
 地图的目的:
 搜索出所有的汽车店
 */

@implementation PositionViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    [MAMapServices  sharedServices].apiKey = SYHKey;
    
    [AMapSearchServices sharedServices].apiKey = SYHKey;
    
    
    [self initMapView];
    
    // 开启定位的开关
    
    _mapView.showsUserLocation = YES;
    
    _mapView.customizeUserLocationAccuracyCircleRepresentation = YES;

    _mapView.userTrackingMode = MAUserTrackingModeFollow;
    
    [_mapView setDelegate:self];
    
        
    self.title = @"定位";
    self.view.backgroundColor = [UIColor orangeColor];
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(leftAction)];
    self.navigationItem.leftBarButtonItem = leftBtn;
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@" 开始搜索" style:UIBarButtonItemStyleDone target:self action:@selector(searchAction)];
    self.navigationItem.rightBarButtonItem = right;
    

    

}
-(void)initMapView{
    if (!_mapView) {
        
        _mapView = [[MAMapView     alloc] initWithFrame:[UIScreen mainScreen].bounds];
        
        [self.view addSubview:_mapView];
    }
    
}

- (void)searchAction {
    
    SearchViewController *svc = [[SearchViewController alloc] init];
    [self.navigationController pushViewController:svc animated:YES];
    
}


#pragma mark -- 当位置进行更新的时候 通过回调函数 能获取定位的经纬度的坐标

-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation{
    
    if (updatingLocation) {
        
        [_mapView setUserTrackingMode:MAUserTrackingModeFollow animated:YES];
    
    }
    
}



/*
-(void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response{
    if(response.pois.count == 0)
    {
        return;
    }
    
    //通过 AMapPOISearchResponse 对象处理搜索结果
    NSString *strCount = [NSString stringWithFormat:@"count: %ld",(long)response.count];
    NSString *strSuggestion = [NSString stringWithFormat:@"Suggestion: %@", response.suggestion];
    NSString *strPoi = @"";
    for (AMapPOI *p in response.pois) {
        strPoi = [NSString stringWithFormat:@"%@\nPOI: %@", strPoi, p.description];
    }
    NSString *result = [NSString stringWithFormat:@"%@ \n %@ \n %@", strCount, strSuggestion, strPoi];
    NSLog(@"Place: %@", result);
}

 */

-(void)leftAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}








@end
