//
//  FMEvaluationModel.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/8/18.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMEvaluationModel.h"

@implementation FMEvaluationModel
+ (NSDictionary *)objectClassInArray{
    return @{@"data" : [EvaluationDataModel class]};
}
@end

@implementation EvaluationDataModel
+ (NSDictionary *)objectClassInArray{
    return @{@"list" : [EvaluationModel class]};
}
@end

@implementation EvaluationModel
+ (NSDictionary *)objectClassInArray{
    return @{@"photo" : [EvaluationPhotoModel class]};
}
@end

@implementation EvaluationPhotoModel
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{@"kid" : @"id"};
}
@end
