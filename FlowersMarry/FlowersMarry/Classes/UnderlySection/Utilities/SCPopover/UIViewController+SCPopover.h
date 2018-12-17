//
//  UIViewController+SCPopover.h
//  SCPopover
//
//  Created by 宁小陌 on 2018/7/3.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCPopoverMacro.h"
#import "SCPopoverAnimator.h"

@interface UIViewController (SCPopover)

@property(nonatomic,strong)SCPopoverAnimator        *popoverAnimator;

- (void)sc_bottomPresentController:(UIViewController *)vc presentedHeight:(CGFloat)height completeHandle:(SCCompleteHandle)completion;

- (void)sc_centerPresentController:(UIViewController *)vc presentedSize:(CGSize)size completeHandle:(SCCompleteHandle)completion;

@end
