//
//  FMMineCommentsModel.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/16.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMMineCommentsModel.h"

@implementation FMMineCommentsModel
+ (NSDictionary *)objectClassInArray{
    return @{@"data" : [MineCommentsModel class]};
}
@end

@implementation MineCommentsModel
+ (NSDictionary *)objectClassInArray{
    return @{@"list" : [MineCommentsListModel class]};
}

@end

@implementation MineCommentsListModel
+ (NSDictionary *)objectClassInArray{
    return @{@"feed" : [MineCommentsFeedModel class],
             @"reply" : [MineCommentsReplyModel class],
             @"reply" : [MineLikeBusinessAuth class]
             };
}
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{@"kid" : @"id"};
}
@end

@implementation MineCommentsFeedModel
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{@"kid" : @"id"};
}
@end

@implementation MineCommentsReplyModel

@end

@implementation MineLikeBusinessAuth

@end
