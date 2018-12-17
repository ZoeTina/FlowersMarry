//
//  FMCombinationDetailsModel.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/27.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMCombinationDetailsModel.h"

@implementation FMCombinationDetailsModel
+ (NSDictionary *)objectClassInArray{
    return @{@"data" : [CombinationDetailsModel class]};
}
@end

@implementation CombinationDetailsModel

+ (NSDictionary *)objectClassInArray{
    return @{@"meta" : [CombinationDetailsMetaModel class],
             @"photo_info" : [CombinationDetailsPhotoInfoModel class],
             @"photo" : [CombinationDetailsPhotoModel class],
             @"tx_content" : [CombinationDetailsContentModel class]};
}

@end


@implementation CombinationDetailsContentModel

@end

@implementation CombinationDetailsPhotoInfoGroupModel

+ (NSDictionary *)objectClassInArray{
    return @{@"zx_num" : [CombinationDetailsPhotoInfoModel class],
             @"ps_pszs" : [CombinationDetailsPhotoInfoModel class],
             @"ps_jxzs" : [CombinationDetailsPhotoInfoModel class],
             @"cp_xcnum" : [CombinationDetailsPhotoInfoModel class]};
}
@end

@implementation CombinationDetailsPhotoInfoModel

@end

@implementation CombinationDetailsPhotoModel

@end

@implementation CombinationDetailsMetaModel
+ (NSDictionary *)objectClassInArray{
    return @{@"children" : [CombinationDetailsMetaChildrenModel class]};
}
@end

@implementation CombinationDetailsMetaChildrenModel

@end

