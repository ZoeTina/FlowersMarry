//
//  UILabel+SCExtension.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/9.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "UILabel+SCExtension.h"
#import <objc/runtime.h>
/// 获取UIEdgeInsets在水平方向上的值
CG_INLINE CGFloat
UIEdgeInsetsGetHorizontalValue(UIEdgeInsets insets) {
    return insets.left + insets.right;
}

/// 获取UIEdgeInsets在垂直方向上的值
CG_INLINE CGFloat
UIEdgeInsetsGetVerticalValue(UIEdgeInsets insets) {
    return insets.top + insets.bottom;
}

CG_INLINE void
ReplaceMethod(Class _class, SEL _originSelector, SEL _newSelector) {
    Method oriMethod = class_getInstanceMethod(_class, _originSelector);
    Method newMethod = class_getInstanceMethod(_class, _newSelector);
    BOOL isAddedMethod = class_addMethod(_class, _originSelector, method_getImplementation(newMethod), method_getTypeEncoding(newMethod));
    if (isAddedMethod) {
        class_replaceMethod(_class, _newSelector, method_getImplementation(oriMethod), method_getTypeEncoding(oriMethod));
    } else {
        method_exchangeImplementations(oriMethod, newMethod);
    }
}
@implementation UILabel (SCExtension)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ReplaceMethod([self class], @selector(drawTextInRect:), @selector(sc_drawTextInRect:));
        ReplaceMethod([self class], @selector(sizeThatFits:), @selector(sc_sizeThatFits:));
    });
}

- (void)sc_drawTextInRect:(CGRect)rect {
    UIEdgeInsets insets = self.sc_contentInsets;
    [self sc_drawTextInRect:UIEdgeInsetsInsetRect(rect, insets)];
}

- (CGSize)sc_sizeThatFits:(CGSize)size {
    UIEdgeInsets insets = self.sc_contentInsets;
    size = [self sc_sizeThatFits:CGSizeMake(size.width - UIEdgeInsetsGetHorizontalValue(insets), size.height-UIEdgeInsetsGetVerticalValue(insets))];
    size.width += UIEdgeInsetsGetHorizontalValue(insets);
    size.height += UIEdgeInsetsGetVerticalValue(insets);
    return size;
}

const void *kAssociatedSc_contentInsets;
- (void)setSc_contentInsets:(UIEdgeInsets)sc_contentInsets {
    objc_setAssociatedObject(self, &kAssociatedSc_contentInsets, [NSValue valueWithUIEdgeInsets:sc_contentInsets] , OBJC_ASSOCIATION_RETAIN);
}

- (UIEdgeInsets)sc_contentInsets {
    return [objc_getAssociatedObject(self, &kAssociatedSc_contentInsets) UIEdgeInsetsValue];
}

@end
