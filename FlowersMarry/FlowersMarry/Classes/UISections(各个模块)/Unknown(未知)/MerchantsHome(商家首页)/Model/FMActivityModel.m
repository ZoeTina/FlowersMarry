//
//  FMActivityModel.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/8/13.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMActivityModel.h"

@implementation FMActivityModel
+ (NSDictionary *)objectClassInArray{
    return @{@"data" : [ActivityModel class]};
}
@end


@implementation ActivityModel
+ (NSDictionary *)objectClassInArray{
    return @{@"list" : [ActivityListModel class]};
}
@end


@implementation ActivityListModel

@end
