//
//  UIViewController+SCPopover.m
//  SCPopover
//
//  Created by 宁小陌 on 2018/7/3.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "UIViewController+SCPopover.h"
#import <objc/runtime.h>

static const char popoverAnimatorKey;

@implementation UIViewController (SCPopover)

- (SCPopoverAnimator *)popoverAnimator{
    return objc_getAssociatedObject(self, &popoverAnimatorKey);
}
- (void)setPopoverAnimator:(SCPopoverAnimator *)popoverAnimator{
    objc_setAssociatedObject(self, &popoverAnimatorKey, popoverAnimator, OBJC_ASSOCIATION_RETAIN) ;
}


- (void)sc_bottomPresentController:(UIViewController *)vc presentedHeight:(CGFloat)height completeHandle:(SCCompleteHandle)completion{
    self.popoverAnimator = [SCPopoverAnimator popoverAnimatorWithStyle:SCPopoverTypeActionSheet completeHandle:completion];
    
    vc.modalPresentationStyle = UIModalPresentationCustom;
    vc.transitioningDelegate = self.popoverAnimator;
    [self.popoverAnimator setBottomViewHeight:height];
    
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)sc_centerPresentController:(UIViewController *)vc presentedSize:(CGSize)size completeHandle:(SCCompleteHandle)completion{
    self.popoverAnimator = [SCPopoverAnimator popoverAnimatorWithStyle:SCPopoverTypeAlert completeHandle:completion];
    [self.popoverAnimator setCenterViewSize:size];
    
    vc.modalPresentationStyle = UIModalPresentationCustom;
    vc.transitioningDelegate = self.popoverAnimator;
    
    [self presentViewController:vc animated:YES completion:nil];
}

@end
