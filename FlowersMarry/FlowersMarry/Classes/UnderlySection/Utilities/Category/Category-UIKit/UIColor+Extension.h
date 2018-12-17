//
//  UIColor+Extension.h
//  LZExtension
//
//  Created by 寕小陌 on 2016/12/12.
//  Copyright © 2016年 寕小陌. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  此分类增加了一些关于UIColor的有用方法
 */
@interface UIColor (Extension)
//
/**
 *  使用十六进制数字生成颜色
 *  @param hexColor (格式:0x2d3f4a)
 *
 *  @return UIColor
 */
+ (nonnull UIColor *)lz_colorWithHex:(long)hexColor;
/**
 *  使用十六进制数字生成颜色
 *  @param opacity 透明度(0.0~1.0)
 *
 *  @return UIColor
 */
+ (nonnull UIColor *)lz_colorWithHex:(long)hexColor opacity:(float)opacity;

/**
 *  根据指定的HexString字符串创建一种颜色
 *  HexString支持下面的格式:
 *  - #RGB
 *  - #ARGB
 *  - #RRGGBB
 *  - #AARRGGBB
 *
 *  @param hexString Hex字符串
 *  @return UIColor
 */
+ (nonnull UIColor *)lz_colorWithHexString:(nonnull NSString *)hexString;
/**
 *  十六进制颜色代码
 *  @param opacity 透明度(0.0~1.0)
 *
 *  @return UIColor
 */
+ (nonnull UIColor *)lz_colorWithHexString:(nonnull NSString *)str opacity:(float)opacity;

/**
 *  使用指定的 r / g / b 数值生成颜色
 *
 *  @param red   r
 *  @param green g
 *  @param blue  b
 *
 *  @return UIColor
 */
+ (nonnull instancetype)lz_colorWithRed:(u_int8_t)red green:(u_int8_t)green blue:(u_int8_t)blue;

/**
 *  使用指定的 r / g / b / opacity(透明度) 生成颜色
 *
 *  @param red      r
 *  @param green    g
 *  @param blue     b
 *  @param opacity  透明度(0.0~1.0)
 *
 *  @return UIColor
 */
+ (nonnull instancetype)lz_colorWithRed:(u_int8_t)red green:(u_int8_t)green blue:(u_int8_t)blue opacity:(float)opacity;

/**
 *  生成随机颜色
 *
 *  @return UIColor
 */
+ (nonnull instancetype)lz_randomColor;

#pragma mark - 颜色值
/**
 *  生成随机颜色
 *
 *  @return 返回当前颜色的 red 的 0～255 值
 */
- (u_int8_t)lz_redValue;
/**
 *  生成随机颜色
 *
 *  @return 返回当前颜色的 green 的 0～255 值
 */
- (u_int8_t)lz_greenValue;

/**
 *  生成随机颜色
 *
 *  @return 返回当前颜色的 blue 的 0～255 值
 */
- (u_int8_t)lz_blueValue;

/**
 *  生成随机颜色
 *
 *  @return 返回当前颜色的 alpha 值
 */
- (CGFloat)lz_alphaValue;

@end
