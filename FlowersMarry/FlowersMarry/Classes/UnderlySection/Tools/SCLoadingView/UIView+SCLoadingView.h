//
//  UIView+SCLoadingView.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/8/6.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (SCLoadingView)
/**
 *  显示加载视图
 *
 *  @param text 加载文字
 */
-(void)showLoadingViewWithText:(NSString *)text;

/**
 *  加载视图消失
 */
-(void)dismissLoadingView;

@end
