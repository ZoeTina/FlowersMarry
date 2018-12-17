//
//  UILabel+Extension.h
//  LZExtension
//
//  Created by 寕小陌 on 2016/12/12.
//  Copyright © 2016年 寕小陌. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  此分类增加了一些关于UILabel的有用方法
 */
@interface UILabel (Extension)

/**
 * 创建 UILabel
 *
 *  @param title    标题
 *  @param color    标题颜色
 *  @param fontSize 字体大小
 *
 *  @return UILabel(文本水平居中)
 */
+ (instancetype)lz_labelWithTitle:(NSString *)title color:(UIColor *)color fontSize:(CGFloat)fontSize;


/**
 * 创建 UILabel
 *
 *  @param title    标题
 *  @param color    标题颜色
 *  @param font     字体
 *
 *  @return UILabel(文本水平居中)
 */
+ (instancetype)lz_labelWithTitle:(NSString *)title color:(UIColor *)color font:(UIFont *)font;


/**
 *  创建 UILabel
 *
 *  @param title     标题
 *  @param color     标题颜色
 *  @param fontSize  字体大小
 *  @param alignment 对齐方式
 *
 *  @return UILabel
 */
+ (instancetype)lz_labelWithTitle:(NSString *)title color:(UIColor *)color fontSize:(CGFloat)fontSize alignment:(NSTextAlignment)alignment;


/**
 *  创建 UILabel
 *
 *  @param title     标题
 *  @param color     标题颜色
 *  @param font      字体
 *  @param alignment 对齐方式
 *
 *  @return UILabel
 */
+ (instancetype)lz_labelWithTitle:(NSString *)title color:(UIColor *)color font:(UIFont *)font alignment:(NSTextAlignment)alignment;

/**
 *  计算UILabel的文字的大小
 *
 *  @param labelwith   最大宽度
 *  @param labelheieht 最大高度
 *
 *  @return 返回文本的大小
 */

-(CGSize)lz_messageBodyLabelwith:(float)labelwith andLabelheight:(float)labelheieht;

/**
 *  计算UILabel的细体文字的大小
 *
 *  @param text        文本
 *  @param fontsize    字体大小
 *  @param labelwith   最大宽度
 *  @param labelheieht 最大高度
 *
 *  @return 返回文本的大小
 */
+(CGSize)lz_messageBodyText:(NSString *)text andSyFontofSize:(float)fontsize andLabelwith:(float)labelwith andLabelheight:(float)labelheieht;

/**
 *  计算UILabel的粗体文字的大小
 *
 *  @param text        文本
 *  @param fontsize    字体大小
 *  @param labelwith   最大宽度
 *  @param labelheieht 最大高度
 *
 *  @return 返回文本的大小
 */
+(CGSize)lz_messageBodyText:(NSString *)text andBoldSystemFontOfSize:(float)fontsize andLabelwith:(float)labelwith andLabelheight:(float)labelheieht;


+ (NSArray *)lz_getSeparatedLinesFromText:(NSString*)labelText  font:(UIFont*)labelFont  frame:(CGRect)labelFrame;

/**
 *  计算UILabel的行间距
 *
 *  @param text        文本
 *  @param height      高度
 *
 *  @return 返回富文本
 */
+ (NSAttributedString*)lz_getLabelParagraph:(NSString*)text  height:(CGFloat)height;

/**
 *  基于Label的text、width、font计算其height
 *
 *  @return 返回计算的高
 */
- (CGFloat)lz_calculatedHeight;


/**
 *  在指定的索引范围内设置一个自定义的字体font
 *
 *  @param font      被设置的新字体格式
 *  @param fromIndex 开始索引
 *  @param toIndex   结束索引
 */
- (void)lz_setFont:(UIFont *)font
         fromIndex:(NSInteger)fromIndex
           toIndex:(NSInteger)toIndex;
@end

