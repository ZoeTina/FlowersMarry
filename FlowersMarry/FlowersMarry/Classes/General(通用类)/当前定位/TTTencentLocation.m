//
//  TTTencentLocation.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/11/27.
//  Copyright © 2018 宁小陌. All rights reserved.
//

#import "TTTencentLocation.h"
#import <TencentLBS/TencentLBS.h>

@interface TTTencentLocation() <TencentLBSLocationManagerDelegate>

@property (nonatomic, strong) TencentLBSLocationManager* locationManager;
@property (nonatomic, strong) CLGeocoder* geocoder;
@property (nonatomic, assign) CLAuthorizationStatus authorizationStatus;

@end

@implementation TTTencentLocation

- (instancetype)init{
    self = [super init];
    if (self) {
        [self initLocation];
        [self startLocation];
    }
    return self;
}

- (void) initLocation{
    self.authorizationStatus = [CLLocationManager authorizationStatus];
    [self mapViewAuthorization];
}

/// 开始定位
- (void)startLocation{
    //开始定位，不断调用其代理方法
    [self.locationManager startUpdatingLocation];
}

/// 停止定位
- (void)stopUpdatingLocation {
    [self.locationManager stopUpdatingLocation];
}

#pragma mark - TencentLBSLocationManagerDelegate
- (void)tencentLBSLocationManager:(TencentLBSLocationManager *)manager didFailWithError:(NSError *)error {
    [self mapViewAuthorization];
}

- (void)tencentLBSLocationManager:(TencentLBSLocationManager *)manager didUpdateLocation:(TencentLBSLocation *)location {
    CLLocation *currentLocation = location.location;
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    fmt.dateFormat = @"yyyy-MM-dd hh:mm:ss";
    NSString *dateString = [fmt stringFromDate:currentLocation.timestamp];
    NSString *displayLabel = [NSString stringWithFormat:@" latitude:%f, longitude:%f\n horizontalAccuracy:%f \n verticalAccuracy:%f\n speed:%f\n course:%f\n altitude:%f\n timestamp:%@",currentLocation.coordinate.latitude, currentLocation.coordinate.longitude, currentLocation.horizontalAccuracy, currentLocation.verticalAccuracy, currentLocation.speed, currentLocation.course, currentLocation.altitude, dateString];
    Toast(location.address);
//    NSString *addrs = [NSString stringWithFormat:@"%@%@%@%@",
//                       location.nation,
//                       location.address,
//                       location.province,
//                       location.city,
//                       location.longitude];
//    uid;       //!< 当前POI的uid
//    @property (nonatomic, copy) NSString *name;      //!< 当前POI的名称
//    @property (nonatomic, copy) NSString *address;   //!< 当前POI的地址
//    @property (nonatomic, copy) NSString *catalog;   //!< 当前POI的类别
//    @property (nonatomic, assign) double longitude;  //!< 当前POI的经度
//    @property (nonatomic, assign) double latitude;   //!< 当前POI的纬度
//    @property (nonatomic, assign) double distance;   //!< 当前POI与当前位置的距离
    TTLog(@"displayLabel  ---- %@",displayLabel);
//    self.userCoordinate2D = currentLocation.coordinate;
    // lastCoordinate2D 第一次出现事应该是用户的定位数据，且此数据只在此处获取一次，后面会在其他位置被其他数据覆盖
//    if (self.lastCoordinate2D.latitude == 0 && self.lastCoordinate2D.longitude == 0) {
//        self.lastCoordinate2D = currentLocation.coordinate;
        [self stopUpdatingLocation]; //停止定位
//    }
    //    //初始化设置地图中心点坐标需要异步加入到主队列
    MV(weakSelf)
    dispatch_async(dispatch_get_main_queue(), ^{
        //        CLLocationCoordinate2D currentCoordinate2D = CLLocationCoordinate2DMake(30.546962,104.059443);
//        [weakSelf.mapView setCenterCoordinate:self.lastCoordinate2D zoomLevel:20.01 animated:YES];
    });
}

- (void) mapViewAuthorization{
    switch (self.authorizationStatus) {
        case kCLAuthorizationStatusNotDetermined:
        {
            TTLog(@"用户尚未进行选择");
            [self.locationManager requestAlwaysAuthorization];        // NSLocationAlwaysUsageDescription
            [self.locationManager requestWhenInUseAuthorization];     // NSLocationWhenInUseDescription
        }
            break;
        case kCLAuthorizationStatusDenied:
        {
            TTLog(@"用户不允许定位");
        }
        case kCLAuthorizationStatusRestricted:
        {
            TTLog(@"定位权限被限制");
            [self showLocationAlert];
        }
            break;
        case kCLAuthorizationStatusAuthorizedWhenInUse:
        case kCLAuthorizationStatusAuthorizedAlways:
        {
            TTLog(@"用户允许定位");
//            [self initTMapView];
        }
            break;
        default:
            break;
    }
}

/// 弹窗提示
- (void)showLocationAlert {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"定位权限未开启，是否开启？" preferredStyle:  UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if( [[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]] ) {
#if  __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
            if (@available(iOS 10.0, *)) {
                [[UIApplication sharedApplication]openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{}completionHandler:^(BOOL success) {
                }];
            } else {
                // Fallback on earlier versions
            }
#elif __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
#endif
        }
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }]];
    
//    [self presentViewController:alert animated:true completion:nil];
    
}

#pragma mark ---- 腾讯地图定位以及授权 --- ---
- (TencentLBSLocationManager *)locationManager {
    if (!_locationManager) {
        _locationManager = [[TencentLBSLocationManager alloc] init];
        _locationManager.delegate = self;
        /// 指定定位是否会被系统自动暂停。默认为 YES 。
        _locationManager.pausesLocationUpdatesAutomatically = NO;
        /// 是否允许后台定位。默认为 NO。
        _locationManager.allowsBackgroundLocationUpdates = YES;
        _locationManager.apiKey = kTencentAppKey;
    }
    return _locationManager;
}

@end
