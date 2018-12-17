//
//  SCPlayerConfiguration.m
//  SCVideoPlayer
//
//  Created by 宁小陌 on 2018/9/1.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "SCPlayerConfiguration.h"

@implementation SCPlayerConfiguration


/**
 初始化 设置缺省值
 */
- (instancetype)init
{
    self = [super init];
    if (self) {
        _hideControlsInterval = 5.0f;
    }
    return self;
}

@end
