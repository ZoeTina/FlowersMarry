//
//  UIView+SCTapped.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/21.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "UIView+SCTapped.h"
#import <objc/runtime.h>

@implementation UIView (SCTapped)
static char kWhenTappedBlockKey;

#pragma mark - Set blocks
- (void)setBlock:(WhenTappedBlock)block forKey:(void *)blockKey {
    self.userInteractionEnabled = YES;
    objc_setAssociatedObject(self, blockKey, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)runBlockForKey:(void *)blockKey {
    WhenTappedBlock block = objc_getAssociatedObject(self, blockKey);
    if (block) block();
}

#pragma mark - When Tapped
- (void)whenTapped:(WhenTappedBlock)block {
    //添加点击手势
    UITapGestureRecognizer* gesture = [self addTapGestureRecognizerWithTaps:1 touches:1 selector:@selector(viewWasTapped)];
    [self addGestureRecognizer:gesture];
    [self setBlock:block forKey:&kWhenTappedBlockKey];
    
}

/*手势点击响应事件*/
- (void)viewWasTapped {
    [self runBlockForKey:&kWhenTappedBlockKey];
}

#pragma mark - addTapGesture
- (UITapGestureRecognizer*)addTapGestureRecognizerWithTaps:(NSUInteger)taps touches:(NSUInteger)touches selector:(SEL)selector {
    
    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:selector];
    tapGesture.delegate = self;
    tapGesture.numberOfTapsRequired = taps;
    tapGesture.numberOfTouchesRequired = touches;
    
    return tapGesture;
}

@end
