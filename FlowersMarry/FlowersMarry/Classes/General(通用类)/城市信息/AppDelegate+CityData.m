//
//  AppDelegate+CityData.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/9/3.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "AppDelegate+CityData.h"

@implementation AppDelegate (CityData)

- (void)requestCityData{
    AppDelegate* delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    delegate.cityDataModel = [[FMSelectedCityModel alloc] init];
    [SCHttpTools getWithURLString:@"site/groups" parameter:nil success:^(id responseObject) {
        NSDictionary *result = responseObject;
        if ([result isKindOfClass:[NSDictionary class]]) {
            FMSelectedCityModel *cityModel = [FMSelectedCityModel mj_objectWithKeyValues:result];
            delegate.cityDataModel = cityModel;
            if (cityModel.errcode != 0) {
                NSString *st = [NSString stringWithFormat:@"%@ ---- site/groups",cityModel.message];
                Toast(st);
            }else{
                kUserInfo.cityName = cityModel.data.current.site_name;
            }
        }else{
            Toast(@"获取城市数据失败");
            kUserInfo.cityName = @"定位失败";
        }
        CityModel *model = delegate.cityDataModel.data.current;
        kUserInfo.site_id = model.site_id;
        kUserInfo.city_id = model.city_id;
        kUserInfo.province_id = model.province_id;
        [kUserInfo dump];
        [kNotificationCenter postNotificationName:@"NoticeCityHasUpdate" object:nil];
    } failure:^(NSError *error) {
        TTLog(@" -- error -- %@",error);
        kUserInfo.cityName = @"定位失败";
        [kUserInfo dump];
        [kNotificationCenter postNotificationName:@"NoticeCityHasUpdate" object:nil];
    }];

}
@end
