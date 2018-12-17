//
//  SCPopoverAnimator.h
//  SCPopover
//
//  Created by 宁小陌 on 2018/7/3.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCPopoverMacro.h"

@interface SCPopoverAnimator : NSObject<UIViewControllerAnimatedTransitioning,UIViewControllerTransitioningDelegate>
@property(nonatomic,assign)CGRect       presentedFrame;
+ (instancetype)popoverAnimatorWithStyle:(SCPopoverType )popoverType
                          completeHandle:(SCCompleteHandle)completeHandle;

/// 设置视图大小
- (void)setCenterViewSize:(CGSize)size;
/// 设置底部视图高度
- (void)setBottomViewHeight:(CGFloat)height;

@end
