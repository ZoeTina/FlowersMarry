//
//  FMThridLoginView.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/10.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol FMThridLoginViewButtonClickDelegate <NSObject>
- (void)weixinClick;
- (void)QQClick;
- (void)weiboClick;
@end
@interface FMThridLoginView : UIView
@property (nonatomic, weak) id<FMThridLoginViewButtonClickDelegate> thridLoginViewDelegate;

- (instancetype)initWithFrame:(CGRect)frame;

@end
