//
//  FMCommentsDynamicModel.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/8/8.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMCommentsDynamicModel.h"

@implementation FMCommentsDynamicModel
+ (NSDictionary *)objectClassInArray{
    return @{@"data" : [CommentsDynamicModel class]};
}
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{@"totalCount" : @"count"};
}
@end

@implementation CommentsDynamicModel
+ (NSDictionary *)objectClassInArray{
    return @{@"info" : [CommentsDynamicListModel class]};
}
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{@"totalCount" : @"count"};
}
@end

@implementation CommentsDynamicListModel
+ (NSDictionary *)objectClassInArray{
    return @{@"reply" : [CommentsDynamicReplyModel class]};
}
@end

@implementation CommentsDynamicReplyModel

+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{@"kid" : @"id"};
}
@end
