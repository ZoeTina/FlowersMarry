//
//  FMRegionModel.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/23.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMRegionModel.h"

@implementation FMRegionModel

+ (NSDictionary *)objectClassInArray{
    return @{@"data" : [RegionModel class]};
}

@end

@implementation RegionModel

// 实现这个方法的目的：告诉MJExtension框架模型中的属性名对应着字典的哪个key
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{@"cid" : @"id"};
}

@end
