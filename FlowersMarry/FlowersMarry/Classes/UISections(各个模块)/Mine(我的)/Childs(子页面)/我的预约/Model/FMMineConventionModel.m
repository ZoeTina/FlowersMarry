//
//  FMMineConventionModel.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/13.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMMineConventionModel.h"
@implementation FMMineConventionModel

+ (NSDictionary *)objectClassInArray{
    return @{@"data" : [ConventionData class]};
}


@end

@implementation ConventionData
+ (NSDictionary *)objectClassInArray{
    return @{@"list" : [ConventionListData class]};
}
@end

@implementation ConventionListData

@end
