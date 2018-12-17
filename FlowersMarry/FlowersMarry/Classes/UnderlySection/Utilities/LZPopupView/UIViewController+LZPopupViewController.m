//
//  UIViewController+LZPopupViewController.m
//  SEZB
//
//  Created by 寕小陌 on 2017/1/5.
//  Copyright © 2017年 寜小陌. All rights reserved.
//

#import "UIViewController+LZPopupViewController.h"
#import "LZPopupBackgroundView.h"
#import <QuartzCore/QuartzCore.h>
#import <objc/runtime.h>

#define kPopupModalAnimationDuration 0.35
#define kLZPopupViewController @"kLZPopupViewController"
#define kLZPopupBackgroundView @"kLZPopupBackgroundView"
#define kLZSourceViewTag 23941
#define kLZPopupViewTag 23942
#define kLZOverlayViewTag 23945

@interface UIViewController (LZPopupViewControllerPrivate)
- (UIView*)topView;
- (void)presentPopupView:(UIView*)popupView;
@end

static NSString *LZPopupViewDismissedKey = @"LZPopupViewDismissed";

////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Public

@implementation UIViewController (LZPopupViewController)

static void * const keypath = (void*)&keypath;

- (UIViewController*)lz_popupViewController {
    return objc_getAssociatedObject(self, kLZPopupViewController);
}

- (void)setLz_popupViewController:(UIViewController *)lz_popupViewController {
    objc_setAssociatedObject(self, kLZPopupViewController, lz_popupViewController, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

- (LZPopupBackgroundView*)lz_popupBackgroundView {
    return objc_getAssociatedObject(self, kLZPopupBackgroundView);
}

- (void)setLz_popupBackgroundView:(LZPopupBackgroundView *)lz_popupBackgroundView {
    objc_setAssociatedObject(self, kLZPopupBackgroundView, lz_popupBackgroundView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}

- (void)presentPopupViewController:(UIViewController*)popupViewController animationType:(LZPopupViewAnimation)animationType dismissed:(void(^)(void))dismissed
{
    self.lz_popupViewController = popupViewController;
    [self presentPopupView:popupViewController.view animationType:animationType dismissed:dismissed];
}

- (void)presentPopupViewController:(UIViewController*)popupViewController animationType:(LZPopupViewAnimation)animationType
{
    [self presentPopupViewController:popupViewController animationType:animationType dismissed:nil];
}

- (void)dismissPopupViewControllerWithanimationType:(LZPopupViewAnimation)animationType
{
    UIView *sourceView = [self topView];
    UIView *popupView = [sourceView viewWithTag:kLZPopupViewTag];
    UIView *overlayView = [sourceView viewWithTag:kLZOverlayViewTag];
    
    switch (animationType) {
        case LZPopupViewAnimationSlideBottomTop:
        case LZPopupViewAnimationSlideBottomBottom:
        case LZPopupViewAnimationSlideTopTop:
        case LZPopupViewAnimationSlideTopBottom:
        case LZPopupViewAnimationSlideLeftLeft:
        case LZPopupViewAnimationSlideLeftRight:
        case LZPopupViewAnimationSlideRightLeft:
        case LZPopupViewAnimationSlideRightRight:
            [self slideViewOut:popupView sourceView:sourceView overlayView:overlayView withAnimationType:animationType];
            break;
            
        default:
            [self fadeViewOut:popupView sourceView:sourceView overlayView:overlayView];
            break;
    }
}



////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark View Handling

- (void)presentPopupView:(UIView*)popupView animationType:(LZPopupViewAnimation)animationType
{
    [self presentPopupView:popupView animationType:animationType dismissed:nil];
}

- (void)presentPopupView:(UIView*)popupView animationType:(LZPopupViewAnimation)animationType dismissed:(void(^)(void))dismissed
{
    UIView *sourceView = [self topView];
    sourceView.tag = kLZSourceViewTag;
    popupView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin;
    popupView.tag = kLZPopupViewTag;
    
    // 检查源视图控制器是否位于目标位置
    if ([sourceView.subviews containsObject:popupView]) return;
    
    // 定制 popupView
    popupView.layer.shadowPath = [UIBezierPath bezierPathWithRect:popupView.bounds].CGPath;
    popupView.layer.masksToBounds = NO;
    popupView.layer.shadowOffset = CGSizeMake(5, 5);
    popupView.layer.shadowRadius = 5;
    popupView.layer.shadowOpacity = 0.5;
    popupView.layer.shouldRasterize = YES;
    popupView.layer.rasterizationScale = [[UIScreen mainScreen] scale];
    
    // 添加透明背景
    UIView *overlayView = [[UIView alloc] initWithFrame:sourceView.bounds];
    overlayView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    overlayView.tag = kLZOverlayViewTag;
    overlayView.backgroundColor = [UIColor clearColor];
    
    // BackgroundView
    self.lz_popupBackgroundView = [[LZPopupBackgroundView alloc] initWithFrame:sourceView.bounds];
    self.lz_popupBackgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.lz_popupBackgroundView.backgroundColor = [UIColor blackColor];
    self.lz_popupBackgroundView.alpha = 0.5f;
    [overlayView addSubview:self.lz_popupBackgroundView];
    
    // 弹出框点击背景消失
    UIButton * dismissButton = [UIButton buttonWithType:UIButtonTypeCustom];
    dismissButton.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    dismissButton.backgroundColor = [UIColor clearColor];
    dismissButton.frame = sourceView.bounds;
    [overlayView addSubview:dismissButton];
    
    popupView.alpha = 0.0f;
    [overlayView addSubview:popupView];
    [sourceView addSubview:overlayView];
    
//    [dismissButton addTarget:self action:@selector(dismissPopupViewControllerWithanimation:) forControlEvents:UIControlEventTouchUpInside];
    switch (animationType) {
        case LZPopupViewAnimationSlideBottomTop:
        case LZPopupViewAnimationSlideBottomBottom:
        case LZPopupViewAnimationSlideTopTop:
        case LZPopupViewAnimationSlideTopBottom:
        case LZPopupViewAnimationSlideLeftLeft:
        case LZPopupViewAnimationSlideLeftRight:
        case LZPopupViewAnimationSlideRightLeft:
        case LZPopupViewAnimationSlideRightRight:
            dismissButton.tag = animationType;
            [self slideViewIn:popupView sourceView:sourceView overlayView:overlayView withAnimationType:animationType];
            break;
        default:
            dismissButton.tag = LZPopupViewAnimationFade;
            [self fadeViewIn:popupView sourceView:sourceView overlayView:overlayView];
            break;
    }
    
    [self setDismissedCallback:dismissed];
}

-(UIView*)topView {
    UIViewController *recentView = self;
    
    while (recentView.parentViewController != nil) {
        recentView = recentView.parentViewController;
    }
    return recentView.view;
}

- (void)dismissPopupViewControllerWithanimation:(id)sender
{
    if ([sender isKindOfClass:[UIButton class]]) {
        UIButton* dismissButton = sender;
        switch (dismissButton.tag) {
            case LZPopupViewAnimationSlideBottomTop:
            case LZPopupViewAnimationSlideBottomBottom:
            case LZPopupViewAnimationSlideTopTop:
            case LZPopupViewAnimationSlideTopBottom:
            case LZPopupViewAnimationSlideLeftLeft:
            case LZPopupViewAnimationSlideLeftRight:
            case LZPopupViewAnimationSlideRightLeft:
            case LZPopupViewAnimationSlideRightRight:
                [self dismissPopupViewControllerWithanimationType:(LZPopupViewAnimation)dismissButton.tag];
                break;
            default:
                [self dismissPopupViewControllerWithanimationType:LZPopupViewAnimationFade];
                break;
        }
    } else {
        [self dismissPopupViewControllerWithanimationType:LZPopupViewAnimationFade];
    }
}

//////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Animations

#pragma mark --- Slide

- (void)slideViewIn:(UIView*)popupView sourceView:(UIView*)sourceView overlayView:(UIView*)overlayView withAnimationType:(LZPopupViewAnimation)animationType
{
    // Generating Start and Stop Positions
    CGSize sourceSize = sourceView.bounds.size;
    CGSize popupSize = popupView.bounds.size;
    CGRect popupStartRect;
    switch (animationType) {
        case LZPopupViewAnimationSlideBottomTop:
        case LZPopupViewAnimationSlideBottomBottom:
            popupStartRect = CGRectMake((sourceSize.width - popupSize.width) / 2,
                                        sourceSize.height,
                                        popupSize.width,
                                        popupSize.height);
            
            break;
        case LZPopupViewAnimationSlideLeftLeft:
        case LZPopupViewAnimationSlideLeftRight:
            popupStartRect = CGRectMake(-sourceSize.width,
                                        (sourceSize.height - popupSize.height) / 2,
                                        popupSize.width,
                                        popupSize.height);
            break;
            
        case LZPopupViewAnimationSlideTopTop:
        case LZPopupViewAnimationSlideTopBottom:
            popupStartRect = CGRectMake((sourceSize.width - popupSize.width) / 2,
                                        -popupSize.height,
                                        popupSize.width,
                                        popupSize.height);
            break;
            
        default:
            popupStartRect = CGRectMake(sourceSize.width,
                                        (sourceSize.height - popupSize.height) / 2,
                                        popupSize.width,
                                        popupSize.height);
            break;
    }
    CGRect popupEndRect = CGRectMake((sourceSize.width - popupSize.width) / 2,
                                     (sourceSize.height - popupSize.height) / 2,
                                     popupSize.width,
                                     popupSize.height);
    
    // 设置初始属性
    popupView.frame = popupStartRect;
    popupView.alpha = 1.0f;
    [UIView animateWithDuration:kPopupModalAnimationDuration delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
        [self.lz_popupViewController viewWillAppear:NO];
        self.lz_popupBackgroundView.alpha = 0.5f;
        popupView.frame = popupEndRect;
    } completion:^(BOOL finished) {
        [self.lz_popupViewController viewDidAppear:NO];
    }];
}

- (void)slideViewOut:(UIView*)popupView sourceView:(UIView*)sourceView overlayView:(UIView*)overlayView withAnimationType:(LZPopupViewAnimation)animationType
{
    // 生成开始位置和结束位置
    CGSize sourceSize = sourceView.bounds.size;
    CGSize popupSize = popupView.bounds.size;
    CGRect popupEndRect;
    switch (animationType) {
        case LZPopupViewAnimationSlideBottomTop:
        case LZPopupViewAnimationSlideTopTop:
            popupEndRect = CGRectMake((sourceSize.width - popupSize.width) / 2,
                                      -popupSize.height,
                                      popupSize.width,
                                      popupSize.height);
            break;
        case LZPopupViewAnimationSlideBottomBottom:
        case LZPopupViewAnimationSlideTopBottom:
            popupEndRect = CGRectMake((sourceSize.width - popupSize.width) / 2,
                                      sourceSize.height,
                                      popupSize.width,
                                      popupSize.height);
            break;
        case LZPopupViewAnimationSlideLeftRight:
        case LZPopupViewAnimationSlideRightRight:
            popupEndRect = CGRectMake(sourceSize.width,
                                      popupView.frame.origin.y,
                                      popupSize.width,
                                      popupSize.height);
            break;
        default:
            popupEndRect = CGRectMake(-popupSize.width,
                                      popupView.frame.origin.y,
                                      popupSize.width,
                                      popupSize.height);
            break;
    }
    
    [UIView animateWithDuration:kPopupModalAnimationDuration delay:0.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
        [self.lz_popupViewController viewWillDisappear:NO];
        popupView.frame = popupEndRect;
        self.lz_popupBackgroundView.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [popupView removeFromSuperview];
        [overlayView removeFromSuperview];
        [self.lz_popupViewController viewDidDisappear:NO];
        self.lz_popupViewController = nil;
        
        id dismissed = [self dismissedCallback];
        if (dismissed != nil)
        {
            ((void(^)(void))dismissed)();
            [self setDismissedCallback:nil];
        }
    }];
}

#pragma mark --- Fade

- (void)fadeViewIn:(UIView*)popupView sourceView:(UIView*)sourceView overlayView:(UIView*)overlayView
{
    // Generating Start and Stop Positions
    CGSize sourceSize = sourceView.bounds.size;
    CGSize popupSize = popupView.bounds.size;
    CGRect popupEndRect = CGRectMake((sourceSize.width - popupSize.width) / 2,
                                     (sourceSize.height - popupSize.height) / 2,
                                     popupSize.width,
                                     popupSize.height);
    
    // Set starting properties
    popupView.frame = popupEndRect;
    popupView.alpha = 0.0f;
    
    [UIView animateWithDuration:kPopupModalAnimationDuration animations:^{
        [self.lz_popupViewController viewWillAppear:NO];
        self.lz_popupBackgroundView.alpha = 0.5f;
        popupView.alpha = 1.0f;
    } completion:^(BOOL finished) {
        [self.lz_popupViewController viewDidAppear:NO];
    }];
}

- (void)fadeViewOut:(UIView*)popupView sourceView:(UIView*)sourceView overlayView:(UIView*)overlayView
{
    [UIView animateWithDuration:kPopupModalAnimationDuration animations:^{
        [self.lz_popupViewController viewWillDisappear:NO];
        self.lz_popupBackgroundView.alpha = 0.0f;
        popupView.alpha = 0.0f;
    } completion:^(BOOL finished) {
        [popupView removeFromSuperview];
        [overlayView removeFromSuperview];
        [self.lz_popupViewController viewDidDisappear:NO];
        self.lz_popupViewController = nil;
        
        id dismissed = [self dismissedCallback];
        if (dismissed != nil)
        {
            ((void(^)(void))dismissed)();
            [self setDismissedCallback:nil];
        }
    }];
}

#pragma mark -
#pragma mark Category Accessors

#pragma mark --- Dismissed
- (void)setDismissedCallback:(void(^)(void))dismissed
{
    objc_setAssociatedObject(self, &LZPopupViewDismissedKey, dismissed, OBJC_ASSOCIATION_RETAIN);
}

- (void(^)(void))dismissedCallback
{
    return objc_getAssociatedObject(self, &LZPopupViewDismissedKey);
}

@end
