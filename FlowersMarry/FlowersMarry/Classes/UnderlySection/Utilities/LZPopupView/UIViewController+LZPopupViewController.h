//
//  UIViewController+LZPopupViewController.h
//  SEZB
//
//  Created by 寕小陌 on 2017/1/5.
//  Copyright © 2017年 寜小陌. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LZPopupBackgroundView;

typedef enum {
    LZPopupViewAnimationFade = 0,           // 默认
    LZPopupViewAnimationSlideBottomTop = 1, // 下入上出
    LZPopupViewAnimationSlideBottomBottom,  // 下入下出
    LZPopupViewAnimationSlideTopTop,        // 上入上出
    LZPopupViewAnimationSlideTopBottom,     // 上入下出
    LZPopupViewAnimationSlideLeftLeft,      // 左入左出
    LZPopupViewAnimationSlideLeftRight,     // 左入右出
    LZPopupViewAnimationSlideRightLeft,     // 右入右出
    LZPopupViewAnimationSlideRightRight,    // 右入右出
} LZPopupViewAnimation;

@interface UIViewController(LZPopupViewController)

@property (nonatomic, retain) UIViewController *lz_popupViewController;
@property (nonatomic, retain) LZPopupBackgroundView *lz_popupBackgroundView;

- (void)presentPopupViewController:(UIViewController*)popupViewController animationType:(LZPopupViewAnimation)animationType;
- (void)presentPopupViewController:(UIViewController*)popupViewController animationType:(LZPopupViewAnimation)animationType dismissed:(void(^)(void))dismissed;
- (void)dismissPopupViewControllerWithanimationType:(LZPopupViewAnimation)animationType;


@end
