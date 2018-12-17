//
//  UIViewController+LZNavigationController.m
//  MerchantVersion
//
//  Created by 寜小陌 on 2018/1/18.
//  Copyright © 2018年 寜小陌. All rights reserved.
//

#import "UIViewController+LZNavigationController.h"
#import <objc/runtime.h>

@implementation UIViewController (LZNavigationController)

- (BOOL)lz_fullScreenPopGestureEnabled{
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setLz_fullScreenPopGestureEnabled:(BOOL)fullScreenPopGestureEnabled{
    objc_setAssociatedObject(self, @selector(lz_fullScreenPopGestureEnabled), @(fullScreenPopGestureEnabled), OBJC_ASSOCIATION_RETAIN);
}

- (LZNavigationController *)lz_navigationController {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setLz_navigationController:(LZNavigationController *)navigationController {
    objc_setAssociatedObject(self, @selector(lz_navigationController), navigationController, OBJC_ASSOCIATION_ASSIGN);
}

@end
