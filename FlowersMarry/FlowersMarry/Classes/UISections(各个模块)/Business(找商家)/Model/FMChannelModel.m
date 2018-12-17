//
//  FMChannelModel.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/8/13.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMChannelModel.h"

@implementation FMChannelModel

+ (NSDictionary *)objectClassInArray{
    return @{@"data" : [ChannelModel class]};
}

@end

@implementation ChannelModel

// 实现这个方法的目的：告诉MJExtension框架模型中的属性名对应着字典的哪个key
+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{@"channel_id" : @"id"};
}

+ (NSDictionary *)objectClassInArray{
    return @{@"child" : [ChannelChild class]};
}

@end

@implementation ChannelChild


@end
