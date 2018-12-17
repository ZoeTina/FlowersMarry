//
//  FMBasicInformationViewController+TencentMap.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/11/15.
//  Copyright © 2018 宁小陌. All rights reserved.
//

#import "FMBasicInformationViewController+TencentMap.h"

@implementation FMBasicInformationViewController (TencentMap)
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
        self.mapModel.longitude = location.location.coordinate.longitude;
        self.mapModel.latitude = location.location.coordinate.latitude;
        self.mapModel.country = location.nation;
        self.mapModel.province = location.province;
        self.mapModel.cityName = location.city;
        self.mapModel.district = location.district;
        self.mapModel.name = location.name;
        self.mapModel.address = location.address;
        self.mapModel.street = location.street;
        self.informationModel.map = [NSString stringWithFormat:@"%f,%f",self.mapModel.longitude,self.mapModel.latitude];
        self.informationModel.address = location.address;
        TTLog(@"displayLabel -- %@",displayLabel);
        CLLocationCoordinate2D currentCoordinate2D = CLLocationCoordinate2DMake(self.mapModel.latitude,self.mapModel.longitude);

        self.userCoordinate2D = currentCoordinate2D;
        [self setMapCoordinate2D:currentCoordinate2D];
        [self.tableView reloadData];
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
        NSLog(@"displayLabel -- %@",displayLabel);
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
    NSLog(@"displayLabel -- %@",displayLabel);
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
