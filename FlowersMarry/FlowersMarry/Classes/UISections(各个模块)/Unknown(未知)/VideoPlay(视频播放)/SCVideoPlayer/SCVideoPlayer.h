//
//  SCVideoPlayer.h
//  SCVideoPlayer
//
//  Created by 宁小陌 on 2018/9/1.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SCPlayerConfiguration;
@interface SCVideoPlayer : UIView

/**
 初始化播放器
 @param configuration 播放器配置信息
 */
- (instancetype)initWithFrame:(CGRect)frame configuration:(SCPlayerConfiguration *)configuration;

/** 播放视频 */
- (void)startPlayVideo;
/** 暂停播放 */
- (void)pausePlayVideo;
/** 释放播放器 */
- (void)deallocPlayer;

@end
