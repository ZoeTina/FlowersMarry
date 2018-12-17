//
//  FMCombinationModel.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/26.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMCombinationModel.h"

@implementation FMCombinationModel

+ (NSDictionary *)objectClassInArray{
    return @{@"data" : [CombinationDataModel class]};
}
@end

@implementation CombinationDataModel

+ (NSDictionary *)objectClassInArray{
    return @{@"list" : [CombinationListModel class]};
}

@end

@implementation CombinationListModel


@end
