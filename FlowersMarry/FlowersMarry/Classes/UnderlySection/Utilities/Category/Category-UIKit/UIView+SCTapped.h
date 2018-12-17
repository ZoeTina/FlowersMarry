//
//  UIView+SCTapped.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/21.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^WhenTappedBlock)(void);
@interface UIView (SCTapped)<UIGestureRecognizerDelegate>

/*!
 @method
 @abstract 单击
 @param block 代码块
 */
- (void)whenTapped:(WhenTappedBlock)block;

@end
