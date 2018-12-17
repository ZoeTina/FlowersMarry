//
//  FMChooseMusicModel.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/11/7.
//  Copyright © 2018 宁小陌. All rights reserved.
//

#import "FMChooseMusicModel.h"

@implementation FMChooseMusicModel
+ (NSDictionary *)objectClassInArray{
    return @{@"data" : [MusicModel class]};
}
@end

@implementation MusicModel

+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{@"kid" : @"id",
             @"musicName" : @"name",
             @"musicURL" : @"url",
             @"musicExt" : @"ext"};
}

@end
