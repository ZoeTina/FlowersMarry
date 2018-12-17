//
//  UITabBar+SCBadge.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/6/27.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBar (SCBadge)

/**
 显示小红点
 
 @param index item
 */
- (void)showBadgeOnItemIndex:(NSInteger)index;


/**
 隐藏小红点
 
 @param index item
 */
- (void)hideBadgeOnItemIndex:(NSInteger)index;

@end
