//
//  MVPanGestureRecognizer.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/10/12.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "MVPanGestureRecognizer.h"

@interface MVPanGestureRecognizer () <UIGestureRecognizerDelegate>

@end

@implementation MVPanGestureRecognizer

- (instancetype)initWithTarget:(id)target action:(SEL)action {
    if (self = [super initWithTarget:target action:action]) {
        self.delegate = self;
    }
    return self;
}

#pragma mark - Gesture Delegate
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if ([otherGestureRecognizer.view isKindOfClass:NSClassFromString(@"MVScrollView")]) {
        return NO;
    }
    return YES;
}
@end
