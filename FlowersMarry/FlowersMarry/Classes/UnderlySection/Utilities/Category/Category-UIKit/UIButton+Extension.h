//
//  UIButton+Extension.h
//  LZExtension
//
//  Created by 寕小陌 on 2016/12/12.
//  Copyright © 2016年 寕小陌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

typedef void (^LZActionBlock)(void);

/**
 *  此分类增加了一些关于UIButton的有用方法
 */
@interface UIButton (Extension)


/**
 *  创建按钮有文字,有颜色,有字体,有图片,没有有背景
 *
 *  @param title         标题
 *  @param titleColor    字体颜色
 *  @param font          字号
 *  @param imageName     图像
 *
 *  @return UIButton
 */
+ (instancetype)lz_buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font imageName:(NSString *)imageName target:(id)target action:(SEL)action;

/**
 *  创建按钮有文字,有颜色,有字体,有图片,有背景
 *
 *  @param title         标题
 *  @param titleColor    字体颜色
 *  @param font          字号
 *  @param imageName     图像
 *  @param backImageName 背景图像
 *
 *  @return UIButton
 */
+ (instancetype)lz_buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font imageName:(NSString *)imageName target:(id)target action:(SEL)action backImageName:(NSString *)backImageName;


/**
 *  创建按钮有文字,有颜色，有字体，没有图片，没有背景
 *
 *  @param title         标题
 *  @param titleColor    标题颜色
 *  @param font          背景图像名称
 *
 *  @return UIButton
 */
+ (instancetype)lz_buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font target:(id)target action:(SEL)action;

/**
 *  创建按钮有文字,有颜色，有字体，没有图片，有背景
 *
 *  @param title         标题
 *  @param titleColor    标题颜色
 *  @param backImageName 背景图像名称
 *
 *  @return UIButton
 */
+ (instancetype)lz_buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font target:(id)target action:(SEL)action backImageName:(NSString *)backImageName;

@property (readonly) NSMutableDictionary *event;

- (void) lz_handleControlEvent:(UIControlEvents)controlEvent withBlock:(LZActionBlock)action;

@end
