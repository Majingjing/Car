//
//  MapDetailViewController.m
//  Car
//
//  Created by 史燕红 on 16/3/14.
//  Copyright © 2016年 麻静. All rights reserved.
//

#import "MapDetailViewController.h"

#import <MAMapKit/MAMapKit.h>

#import "SearchViewController.h"

#define SYHKey @"82b0fbd838fc138555e9ed9e697d1132"


@interface MapDetailViewController ()<MAMapViewDelegate>

@property (nonatomic,strong)MAMapView *mapView;

@end

@implementation MapDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [MAMapServices  sharedServices].apiKey = SYHKey;
    [self initMapView];
    
    
    //  开启定位的开关(MAMapView 的属性 showUserLocation)
    
    //_mapView.showsUserLocation = YES;// yes 为打开定位
    
    // 自定义定位经度样式 将 MAMapView 的customizeUserLocationAccuracyCircleRepresentation 属性设置为 YES
    
    _mapView.customizeUserLocationAccuracyCircleRepresentation = YES;
    
    _mapView.userTrackingMode = MAUserTrackingModeFollow;
    
    [_mapView setDelegate:self];
    
    [_mapView setRegion:self.region];
    
    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
    pointAnnotation.coordinate = CLLocationCoordinate2DMake(self.region.center.latitude, self.region.center.longitude);
    
    [_mapView addAnnotation:pointAnnotation];

    

}

-(void)initMapView{
    if (!_mapView) {
        
        
        _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0,40, self.view.bounds.size.width, self.view.bounds.size.height)];
        self.view.backgroundColor = [UIColor whiteColor];
        
        [self.view addSubview:_mapView];
        
        
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        
        btn.frame = CGRectMake(0, 0, self.view.bounds.size.width, 70);
        
        [btn setTitle:@"🐼🐼Back🍃🍀" forState:UIControlStateNormal];
        
        [btn addTarget:self action:@selector(backBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
        
    }
    
}

-(void)backBtnAction:(UIButton *)sender{
    
    SearchViewController *svc = [[SearchViewController  alloc] init];
    
    [self  dismissViewControllerAnimated:svc completion:nil];
    
    
}






@end
