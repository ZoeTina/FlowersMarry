//
//  FMVideoPlayModel.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/8/30.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMVideoPlayModel.h"

@implementation FMVideoPlayModel
+ (NSDictionary *)objectClassInArray{
    return @{@"data" : [VideoPlayDataModel class]};
}
@end

@implementation VideoPlayDataModel
+ (NSDictionary *)objectClassInArray{
    return @{@"video_list" : [VideoPlayModel class]};
}
@end

@implementation VideoPlayModel
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{@"kid" : @"id",@"videoUrl":@"playurl"};
}
@end

