//
//  UIFont+Extension.h
//  LZExtension
//
//  Created by 寕小陌 on 2016/12/9.
//  Copyright © 2016年 寕小陌. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  此分类增加了一些关于UIFont的有用方法
 */
@interface UIFont (Extension)

/**
 * 根据屏幕适配文字大小 规则: 以6为基础, 设备小一号减一号字体，设备大一号加一号字体
 */
+ (UIFont*)lz_systemFontOfSizeAdapter:(CGFloat)fontSize;

+ (UIFont *)lz_fontWithName:(NSString *)fontName sizeAdapter:(CGFloat)fontSize;

@end
