//
//  UINavigationBar+SCExtension.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/10/12.
//  Copyright © 2018年 宁小陌. All rights reserved.
//


#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface UINavigationBar (SCExtension)

- (void)sc_setBackgroundColor:(UIColor *)backgroundColor;
- (void)sc_setElementsAlpha:(CGFloat)alpha;
- (void)sc_setTranslationY:(CGFloat)translationY;
- (void)sc_reset;

@end

NS_ASSUME_NONNULL_END
