//
//  FMBasicInformationModel.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/11/8.
//  Copyright © 2018 宁小陌. All rights reserved.
//

#import "FMBasicInformationModel.h"

@implementation FMBasicInformationModel
+ (NSDictionary *)objectClassInArray{
    return @{@"data" : [BasicInformationModel class]};
}
@end


@implementation BasicInformationModel
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{@"kid" : @"id"};
}
@end


@implementation TencentMapModel

@end
