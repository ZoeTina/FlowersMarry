//
//  SCProgressView.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/10/12.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SCProgressView : UIView
/// 进度值
@property (nonatomic,assign) CGFloat progressValue;

/// 进度条的颜色
@property (nonatomic,strong) UIColor *progressColor;

/// 进度条的背景色
@property (nonatomic,strong) UIColor *bottomColor;

/// 进度条的速度
@property (nonatomic,assign) float time;
@end

NS_ASSUME_NONNULL_END
