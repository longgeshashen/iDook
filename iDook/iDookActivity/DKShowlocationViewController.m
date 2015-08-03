//
//  DKShowlocationViewController.m
//  iDook
//
//  Created by sunshilong on 15/7/24.
//  Copyright (c) 2015年 sunshilong. All rights reserved.
//

#import "DKShowlocationViewController.h"
#import <BaiduMapAPI/BMapKit.h>
@interface DKShowlocationViewController ()
{
    BMKMapView         * _mapView;         //地图
    BMKLocationService * _locService;      //服务
//    BMKPointAnnotation * pointAnnotation;//
    BMKGeoCodeSearch   * _geocodesearch;   //反编码地址
    BMKUserLocation    *_myLocation;       //位置
    NSString           *myLocationString;  //我的具体位置位置，返回上级
}
@end

@implementation DKShowlocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"位置";
    //适配ios7
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
    {
        self.navigationController.navigationBar.translucent = NO;
    }
    [self loadMyViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated {
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _locService.delegate = self;
    _geocodesearch.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}

-(void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _locService.delegate = nil;
    _geocodesearch.delegate = nil; // 不用时，置nil
}
#pragma mark --------
//返回
//- (void)backButtonClick:(UIButton *)btn {
////    [_locService stopUserLocationService];
//    if (self.delegate&&[self.delegate respondsToSelector:@selector(getMylocation:)]) {
//        [self.delegate getMylocation:myLocationString];
//    }
//    [self dismissViewControllerAnimated:YES completion:^{
//    }];
//}
#pragma mark---
- (void)loadMyViews{
    
    _locService = [[BMKLocationService alloc]init];
    
    _mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
    self.view = _mapView;
    
    [_locService startUserLocationService];
    
    _mapView.showsUserLocation = NO;//先关闭显示的定位图层
    _mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
    _mapView.showsUserLocation = YES;//显示定位图层
    
    _geocodesearch = [[BMKGeoCodeSearch alloc]init];
    
    //搜索按钮
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 40, 35);
    [rightBtn addTarget:self action:@selector(locationSure) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setTitle:@"确定" forState:UIControlStateNormal];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;

}
- (void)locationSure{

    if (self.delegate&&[self.delegate respondsToSelector:@selector(getMylocation:)]) {
        [self.delegate getMylocation:myLocationString];
    }
    [self.navigationController popViewControllerAnimated:YES];
}
/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    
    [_mapView updateLocationData:userLocation];
    
    if ((userLocation.location.coordinate.latitude != 0.0) && (userLocation.location.coordinate.longitude != 0.0)) {
        //反编码，添加大头针
        [self addAnimationLat:userLocation.location.coordinate.latitude andLong:userLocation.location.coordinate.longitude];
        [_locService stopUserLocationService];
    }
    
}
- (void)addAnimationLat:(CGFloat)latitude andLong:(CGFloat)longitude{
    //
    CLLocationCoordinate2D pt = (CLLocationCoordinate2D){0, 0};
    if ((latitude != 0.0) && (longitude != 0.0)) {
        pt = (CLLocationCoordinate2D){latitude, longitude};
    }
    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    reverseGeocodeSearchOption.reverseGeoPoint = pt;
    BOOL flag = [_geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
    if(flag)
    {
        NSLog(@"反geo检索发送成功");
    }
    else
    {
        NSLog(@"反geo检索发送失败");
    }
    
}
/**
 *在地图View停止定位后，会调用此函数
 *@param mapView 地图View
 */
- (void)didStopLocatingUser
{
    NSLog(@"stop locate");
}
//地理反编码
-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    [_mapView removeAnnotations:array];
    array = [NSArray arrayWithArray:_mapView.overlays];
    [_mapView removeOverlays:array];
    if (error == 0) {
        BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
        
        item.coordinate = result.location;
        item.title = result.address;
        [_mapView addAnnotation:item];
        _mapView.centerCoordinate = result.location;
        NSString* titleStr;
        NSString* showmeg;
        titleStr = @"反向地理编码";
        showmeg = [NSString stringWithFormat:@"%@",item.title];
        debugLog(@"省份是%@",result.addressDetail.province);
        debugLog(@"市是%@",result.addressDetail.city);
        debugLog(@"区是%@",result.addressDetail.district);
        debugLog(@"街道是%@",result.addressDetail.streetName);
        myLocationString  = [NSString stringWithString:result.address];
    }
}@end
