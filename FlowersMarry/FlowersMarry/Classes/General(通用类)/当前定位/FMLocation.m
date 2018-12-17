//
//  FMLocation.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/10.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMLocation.h"
#import <CoreLocation/CoreLocation.h>
#import "TTWGS84TOGCJ02.h"

@interface FMLocation() <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager* locationManager;
@property (nonatomic, strong) CLGeocoder* geocoder;
@property (nonatomic, assign) CLAuthorizationStatus authorizationStatus;

@end

@implementation FMLocation

- (instancetype)init{
    
    self = [super init];
    if (self) {
        [self initLocation];
    }
    return self;
}


/// 开始定位
- (void)startLocation{
    //开始定位，不断调用其代理方法
    [self.locationManager startUpdatingLocation];
}

/// 初始化定位组件
- (void)initLocation{
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    [self requestAuthorization];
    self.geocoder = [[CLGeocoder alloc]  init];
    
    /// 添加定时器
    NSTimer*  locationTimer = [NSTimer timerWithTimeInterval:300 target:self selector:@selector(startLocation) userInfo:nil repeats:true];
    [[NSRunLoop mainRunLoop] addTimer:locationTimer forMode:NSRunLoopCommonModes];
}

/// 请求授权
- (void)requestAuthorization{
    if ([[UIDevice currentDevice] systemVersion].floatValue >= 8.0) {
        [self.locationManager requestWhenInUseAuthorization];
        [self.locationManager requestAlwaysAuthorization];
    }
    if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
}

- (void) mapViewAuthorization{
    self.authorizationStatus = [CLLocationManager authorizationStatus];
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
//            [self showLocationAlert];
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

//// 定位成功
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    
    // 2.停止定位
    [manager stopUpdatingLocation];
    // 1.获取用户位置的对象
    CLLocation *location = [locations lastObject];
    [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if (placemarks.count == 0 || error) {
            kUserInfo.cityName = @"定位失败";
        }else{
            CLLocation *newLocations = locations[0];
            CLLocationCoordinate2D oldCoordinate = newLocations.coordinate;
            
            TTLog(@"旧的经度：%f,旧的纬度：%f",oldCoordinate.longitude,oldCoordinate.latitude);

            //得到newLocation
            CLLocation *newLocation = [locations objectAtIndex:0];
            //判断是不是属于国内范围
            if (![TTWGS84TOGCJ02 isLocationOutOfChina:[newLocation coordinate]]) {
                //转换后的coord
                CLLocationCoordinate2D coordinate = [TTWGS84TOGCJ02 transformFromWGSToGCJ:[newLocation coordinate]];
                TTLog(@"旧的经度：%f,旧的纬度：%f",coordinate.longitude,coordinate.latitude);
                
                kUserInfo.longitude = coordinate.longitude;
                kUserInfo.latitude = coordinate.latitude;
            }
            
            for (CLPlacemark *placemark in placemarks) {
                /**
                name;               // 天府三街74号
                thoroughfare;       // 天府三街
                subThoroughfare;    // 74号
                locality;           // 成都市
                subLocality;        // 武侯区
                administrativeArea; // 四川省
                ISOcountryCode;     // CN
                country;            // 中国
                 */
                
                kUserInfo.country = placemark.country;
                kUserInfo.province = placemark.administrativeArea;
                
                NSString *addrs = [NSString stringWithFormat:@"%@%@%@%@%@",
                                   placemark.country,
                                   placemark.administrativeArea,
                                   placemark.locality,
                                   placemark.subLocality,
                                   placemark.thoroughfare];
                [self lz_make:addrs];
                
                kUserInfo.country = placemark.country;
                kUserInfo.province = placemark.administrativeArea;
                kUserInfo.cityName = placemark.locality;
                kUserInfo.district = placemark.subLocality;
                kUserInfo.name = placemark.name;
                kUserInfo.address = placemark.thoroughfare;
                kUserInfo.street = placemark.subThoroughfare;
                [kUserInfo dump];
                NSString *address = [NSString stringWithFormat:@"\n-----%@\n-----%@\n-----%@\n-----%@\n-----%@\n-----%@\n-----%@\n-----%f\n-----%f\n",
                                     kUserInfo.country,
                                     kUserInfo.province,
                                     kUserInfo.cityName,
                                     kUserInfo.district,
                                     kUserInfo.name,
                                     kUserInfo.address,
                                     kUserInfo.street,
                                     kUserInfo.longitude,
                                     kUserInfo.latitude];
                TTLog(@"CLLocationManagerDelegate 当前定位城市 -- %@", address);
                
                NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
                [parameter setObject:kUserInfo.province forKey:@"province_name"];
                [parameter setObject:kUserInfo.cityName forKey:@"city_name"];
                [SCHttpTools postWithURLString:@"site/getbyaddress" parameter:parameter success:^(id responseObject) {
                    NSDictionary *result = responseObject;
                    TTLog(@"result ---- %@",[Utils lz_dataWithJSONObject:result]);
                    if ([result isKindOfClass:[NSDictionary class]]) {
                        FMGeneralModel *genralModel = [FMGeneralModel mj_objectWithKeyValues:result];
                        if (genralModel.errcode==0) {
                            CityModel *cityModel = [CityModel mj_objectWithKeyValues:result[@"data"]];
                            kUserInfo.site_id = cityModel.site_id;
                            kUserInfo.city_id = cityModel.city_id;
                            kUserInfo.province_id = cityModel.province_id;
                            [kUserInfo dump];
                            [kNotificationCenter postNotificationName:@"NoticeCityHasUpdate" object:nil];
                            [kNotificationCenter postNotificationName:@"ReloadNoticeCityHasUpdate" object:nil];
                            TTLog(@"等到当前城市站点名称 - --%@",cityModel.site_name);
                            NSUserDefaults *cityInfo = [NSUserDefaults standardUserDefaults];
                            [cityInfo setObject:cityModel.site_id forKey:@"site_id"];
                            [cityInfo setObject:cityModel.city_id forKey:@"city_id"];
                            [cityInfo setObject:cityModel.province_id forKey:@"province_id"];
                            [cityInfo synchronize];
                        }else{
                            Toast(genralModel.message);
                        }
                    }
                } failure:^(NSError *error) {
                    TTLog(@" -- error -- %@",error);
                    [MBProgressHUD hideHUD];
                }];
            }
        }
        [kNotificationCenter postNotificationName:@"NoticeCityHasUpdate" object:nil];
    }];
}

/// 定位失败
- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error{
    if (error.code == kCLErrorDenied) {
        MVLog(@"-定位失败error--%@---",error);
    }
}

@end
