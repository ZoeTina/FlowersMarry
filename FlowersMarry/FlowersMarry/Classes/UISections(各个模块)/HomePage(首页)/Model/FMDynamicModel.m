//
//  FMDynamicModel.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/23.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMDynamicModel.h"

@implementation FMDynamicModel

+ (NSDictionary *)objectClassInArray{
    return @{@"data" : [DynamicDataModel class]};
}

@end

@implementation DynamicDataModel
+ (NSDictionary *)objectClassInArray{
    return @{@"list" : [DynamicModel class]};
}
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{@"totalCount" : @"count"};
}
@end

@implementation DynamicModel
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{@"kid" : @"id",@"videoURL":@"playurl"};
}
+ (NSDictionary *)objectClassInArray{
    return @{@"list" : [DynamicModel class],
             @"auth" : [BusinessAuthModel class],
             @"gallery" : [DynamicGalleryModel class]};
}

@end

@implementation DynamicGalleryModel

+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{@"kid" : @"id",@"k_description":@"description"};
}

@end
