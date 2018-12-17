//
//  FMBusinessModel.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/6/27.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMBusinessModel.h"

@implementation FMBusinessModel

+ (NSDictionary *)objectClassInArray{
    return @{@"data" : [BusinessDataModel class]};
}
@end

@implementation BusinessDataModel
+ (NSDictionary *)objectClassInArray{
    return @{@"list" : [BusinessModel class],
             @"recommend" : [BusinessModel class]};
}
@end

@implementation BusinessModel
+ (NSDictionary *)objectClassInArray{
    return @{@"auth" : [BusinessAuthModel class],
             @"youhui" : [BusinessYouHuiModel class],
             @"huodong" : [BusinessHuodongModel class],
             @"cases" : [BusinessCasesModel class],
             @"comments" : [BusinessComment class],
             @"huodongs" : [BusinessHuodongModel class],
             @"taoxis" : [BusinessTaoxiModel class],
             @"shijing" : [BusinessCasesPhotoModel class]};
}
@end

@implementation BusinessAuthModel
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{@"kid" : @"id"};
}
@end

@implementation BusinessYouHuiModel
+ (NSDictionary *)objectClassInArray{
    return @{@"gift" : [BusinessAuthModel class],
             @"coupon" : [BusinessYouHuiModel class]};
}
@end

@implementation BusinessCasesModel
+ (NSDictionary *)objectClassInArray{
    return @{@"photo" : [BusinessCasesPhotoModel class],
             @"case_fg" : [BusinessCasesStyleModel class],
             @"taoxi" : [BusinessTaoxiModel class],
             @"youhui" : [BusinessYouHuiModel class],
             @"auth" : [BusinessAuthModel class],
             @"caselist" : [BusinessCasesModel class],
             @"case_sys" : [BusinessStaffInfoModel class],
             @"case_zxs" : [BusinessStaffInfoModel class],
             @"case_hq" : [BusinessStaffInfoModel class]};
}
@end

@implementation BusinessCasesPhotoModel
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{@"kid" : @"id"};
}
@end

@implementation BusinessYouHuiGiftModel
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{@"kid" : @"id"};
}
@end

@implementation BusinessYouHuiCouponModel

@end


@implementation BusinessComment
+ (NSDictionary *)objectClassInArray{
    return @{@"photo" : [BusinessCasesPhotoModel class]};
}
@end

@implementation BusinessHuodongModel
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{@"kid" : @"id"};
}
+ (NSDictionary *)objectClassInArray{
    return @{@"auth" : [BusinessAuthModel class]};
}
@end

@implementation BusinessTaoxiModel
+ (NSDictionary *)objectClassInArray{
    return @{@"photo" : [BusinessCasesPhotoModel class],
             @"meta" : [BusinessTaoxiMetaModel class],
             @"auth" : [BusinessAuthModel class],
             @"txlist" : [BusinessTaoxiModel class],
             @"meta_nav" : [BusinessMetaNavModel class],
             @"youhui" : [BusinessYouHuiModel class]};
}
@end

@implementation BusinessCasesStyleModel


@end

@implementation BusinessStaffInfoModel
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{@"kid" : @"id"};
}
@end


@implementation BusinessTaoxiDataModel
+ (NSDictionary *)objectClassInArray{
    return @{@"list" : [BusinessTaoxiModel class]};
}
@end

@implementation BusinessCaseDataModel
+ (NSDictionary *)objectClassInArray{
    return @{@"list" : [BusinessCasesModel class]};
}
@end


@implementation BusinessTaoxiMetaModel
+ (NSDictionary *)objectClassInArray{
    return @{@"child" : [BusinessTaoxiMetaChildrenModel class]};
}
@end

@implementation BusinessTaoxiMetaChildrenModel

@end


@implementation BusinessCasesListDataModel
+ (NSDictionary *)objectClassInArray{
    return @{@"list" : [BusinessCasesModel class]};
}
@end


@implementation BusinessMetaNavModel

@end
