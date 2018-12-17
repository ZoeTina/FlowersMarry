//
//  FMSelectedCityModel.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/8/1.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMSelectedCityModel.h"

@implementation FMSelectedCityModel
+ (NSDictionary *)objectClassInArray{
    return @{@"data" : [CityDataModel class]};
}
@end

@implementation CityDataModel
+ (NSDictionary *)objectClassInArray{
    return @{@"current" : [CityModel class],
             @"hots" : [CityModel class],
             @"groups" : [CityGroupsModel class]};
}
@end

@implementation CityGroupsModel
+ (NSDictionary *)objectClassInArray{
    return @{@"list" : [CityModel class]};
}
@end

@implementation CityModel

@end
