//
//  LZNavigationController.h
//  LZKit
//
//  Created by 寕小陌 on 2017/10/12.
//  Copyright © 2017年 寕小陌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LZWrapViewController : UIViewController

@property (nonatomic, strong, readonly) UIViewController *rootViewController;

+ (LZWrapViewController *)wrapViewControllerWithViewController:(UIViewController *)viewController;

@end

@interface LZNavigationController : UINavigationController

@property (nonatomic, strong) UIPanGestureRecognizer *popPanGesture;
@property (nonatomic, strong) id popGestureDelegate;
/** 返回按钮图片 */
@property (nonatomic, strong) UIImage *backButtonImage;
/** 是否允许全屏滑动 */
@property (nonatomic, assign) BOOL isFullScreenPopGestureEnabled;
@property (nonatomic, copy, readonly) NSArray *lz_viewControllers;


@end
