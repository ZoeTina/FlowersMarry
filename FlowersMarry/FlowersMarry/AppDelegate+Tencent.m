//
//  AppDelegate+Tencent.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/11/27.
//  Copyright © 2018 宁小陌. All rights reserved.
//

#import "AppDelegate+Tencent.h"
#import "FMSelectedCityModel.h"

@implementation AppDelegate (Tencent)

- (void)configLocationManager {
    self.locationManager = [[TencentLBSLocationManager alloc] init];
    [self.locationManager setDelegate:self];
    [self.locationManager setPausesLocationUpdatesAutomatically:NO];
    [self.locationManager setAllowsBackgroundLocationUpdates:YES];
    [self.locationManager setApiKey:kTencentAppKey];
    [self.locationManager setRequestLevel:TencentLBSRequestLevelName];
    
    CLAuthorizationStatus authorizationStatus= [CLLocationManager authorizationStatus];
    if (authorizationStatus == kCLAuthorizationStatusNotDetermined) {
        [self.locationManager requestWhenInUseAuthorization];
    }
}

- (void) requestLocationWithCompletionBlock{
    [self.locationManager requestLocationWithCompletionBlock:^(TencentLBSLocation * _Nullable location, NSError * _Nullable error) {
        NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
        fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        fmt.dateFormat = @"yyyy-MM-dd hh:mm:ss";
        CGFloat latitude = location.location.coordinate.latitude;
        CGFloat longitude = location.location.coordinate.longitude;
        
        TTLog(@" error -- %@",error);
        if (latitude == 0.0 || longitude == 0.0) {
            TTLog(@"定位失败");
        }else{
            NSString *dateString = [fmt stringFromDate:location.location.timestamp];
            NSString *displayLabel = [NSString stringWithFormat:@"%@\n %@\n latitude:%f, longitude:%f\n horizontalAccuracy:%f \n verticalAccuracy:%f\n speed:%f\n course:%f\n altitude:%f\n timestamp:%@\n",
                                      location.name,
                                      location.address,
                                      location.location.coordinate.latitude,
                                      location.location.coordinate.longitude,
                                      location.location.horizontalAccuracy,
                                      location.location.verticalAccuracy,
                                      location.location.speed,
                                      location.location.course,
                                      location.location.altitude,
                                      dateString];
            
            kUserInfo.longitude = location.location.coordinate.longitude;
            kUserInfo.latitude = location.location.coordinate.latitude;
            kUserInfo.country = location.nation;
            kUserInfo.province = location.province;
            kUserInfo.cityName = location.city;
            kUserInfo.district = location.district;
            kUserInfo.name = location.name;
            kUserInfo.address = location.address;
            kUserInfo.street = location.street;
            [kUserInfo dump];
            TTLog(@"displayLabel -- %@",displayLabel);
            NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
            [parameter setObject:location.province forKey:@"province_name"];
            [parameter setObject:location.city forKey:@"city_name"];
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
                        NSDictionary *dataDic = [NSDictionary dictionaryWithObject:kUserInfo.cityName forKey:@"info"];
                        [kNotificationCenter postNotificationName:@"NoticeCityHasUpdate" object:nil userInfo:dataDic];
//                        [ postNotificationName:@"" object:nil];
//                        [kNotificationCenter postNotificationName:@"ReloadNoticeCityHasUpdate" object:nil];
                        TTLog(@"等到当前城市站点名称 - --%@",cityModel.site_name);
                        NSUserDefaults *cityInfo = [NSUserDefaults standardUserDefaults];
                        [cityInfo setObject:cityModel.site_id forKey:@"site_id"];
                        [cityInfo setObject:cityModel.city_id forKey:@"city_id"];
                        [cityInfo setObject:cityModel.province_id forKey:@"province_id"];
                        [cityInfo synchronize];
                        [kNotificationCenter postNotificationName:@"PositioningSuccess" object:nil];
                    }else{
                        Toast(genralModel.message);
                    }
                }
            } failure:^(NSError *error) {
                TTLog(@" -- error -- %@",error);
                [MBProgressHUD hideHUD];
            }];
        }
    }];
}

- (void)startUpdatingLocation {
    [self.locationManager startUpdatingLocation];
}

#pragma mark - TencentLBSLocationManagerDelegate

- (void)tencentLBSLocationManager:(TencentLBSLocationManager *)manager didFailWithError:(NSError *)error {
    CLAuthorizationStatus authorizationStatus = [CLLocationManager authorizationStatus];
    if (authorizationStatus == kCLAuthorizationStatusDenied || authorizationStatus == kCLAuthorizationStatusRestricted) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"定位权限未开启，是否开启？" preferredStyle:  UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if( [[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]] ) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
            }
        }]];
        
        [alert addAction:[UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        }]];
//        [self presentViewController:alert animated:true completion:nil];
        
    } else {
        NSString *displayLabel=[NSString stringWithFormat:@"%@", error];
        TTLog(@"displayLabel -- %@",displayLabel);
    }
}

- (void)tencentLBSLocationManager:(TencentLBSLocationManager *)manager didUpdateLocation:(TencentLBSLocation *)location {
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    fmt.dateFormat = @"yyyy-MM-dd hh:mm:ss";
    NSString *dateString = [fmt stringFromDate:location.location.timestamp];
    NSString *displayLabel = [NSString stringWithFormat:@"%@\n %@\n latitude:%f, longitude:%f\n horizontalAccuracy:%f \n verticalAccuracy:%f\n speed:%f\n course:%f\n altitude:%f\n timestamp:%@\n",
                              location.name,
                              location.address,
                              location.location.coordinate.latitude,
                              location.location.coordinate.longitude,
                              location.location.horizontalAccuracy,
                              location.location.verticalAccuracy,
                              location.location.speed,
                              location.location.course,
                              location.location.altitude,
                              dateString];
    
    kUserInfo.longitude = location.location.coordinate.longitude;
    kUserInfo.latitude = location.location.coordinate.latitude;
    kUserInfo.country = location.nation;
    kUserInfo.province = location.province;
    kUserInfo.cityName = location.city;
    kUserInfo.district = location.district;
    kUserInfo.name = location.name;
    kUserInfo.address = location.address;
    kUserInfo.street = location.street;
    TTLog(@"displayLabel -- %@",displayLabel);
}

#pragma mark - Initialization
- (void)returnAction {
    [self.locationManager stopUpdatingLocation];
}

#pragma mark - Life Cycle

- (void)initTencentMapLocation {
    [self configLocationManager];
//    [self startUpdatingLocation];
    [self requestLocationWithCompletionBlock];
}

@end
