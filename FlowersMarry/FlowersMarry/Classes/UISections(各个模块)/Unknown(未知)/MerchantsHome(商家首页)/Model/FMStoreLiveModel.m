//
//  FMStoreLiveModel.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/26.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMStoreLiveModel.h"

@implementation FMStoreLiveModel
+ (NSDictionary *)objectClassInArray{
    return @{@"data" : [StoreLiveModel class]};
}
@end

@implementation StoreLiveModel
+ (NSDictionary *)objectClassInArray{
    return @{@"list" : [StoreLiveListModel class]};
}
@end

@implementation StoreLiveListModel

@end

