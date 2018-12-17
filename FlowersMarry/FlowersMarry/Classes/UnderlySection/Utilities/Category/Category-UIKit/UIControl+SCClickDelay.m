//
//  UIControl+SCClickDelay.m
//  LZExtension
//
//  Created by 宁小陌 on 2018/7/25.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "UIControl+SCClickDelay.h"
#import <objc/runtime.h>

@interface UIControl ()

/** 是否忽略点击 */
@property(nonatomic)BOOL sc_ignoreEvent;

@end

@implementation UIButton (SCClickDelay)


+(void)load{
    Method sys_Method = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
    Method add_Method = class_getInstanceMethod(self, @selector(sc_sendAction:to:forEvent:));
    method_exchangeImplementations(sys_Method, add_Method);
}

-(void)sc_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event{
    
    if (self.sc_ignoreEvent) return;
    
    if (self.sc_delayClickInterval > 0) {
        self.sc_ignoreEvent = YES;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.sc_delayClickInterval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.sc_ignoreEvent = NO;
        });
    }
    [self sc_sendAction:action to:target forEvent:event];
}

-(void)setSc_ignoreEvent:(BOOL)sc_ignoreEvent{
    objc_setAssociatedObject(self, @selector(sc_ignoreEvent), @(sc_ignoreEvent), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(BOOL)sc_ignoreEvent{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setSc_delayClickInterval:(NSTimeInterval)sc_delayClickInterval{
    objc_setAssociatedObject(self, @selector(sc_delayClickInterval), @(sc_delayClickInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSTimeInterval)sc_delayClickInterval{
    return [objc_getAssociatedObject(self, _cmd) doubleValue];
}

@end
