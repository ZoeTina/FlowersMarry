//
//  FMElectronicInvitationModel.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/11/2.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMElectronicInvitationModel.h"

@implementation FMElectronicInvitationModel
+ (NSDictionary *)objectClassInArray{
    return @{@"data" : [InvitationListModel class]};
}
@end

@implementation InvitationListModel
+ (NSDictionary *)objectClassInArray{
    return @{@"lists" : [InvitationModel class]};
}
@end

@implementation InvitationModel
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{@"kid" : @"id"};
}

@end

@implementation InvitationTemplateModel

+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{@"lists" : @"data"};
}

+ (NSDictionary *)objectClassInArray{
    return @{@"lists" : [InvitationModel class]};
}

@end
