//
//  UIBarButtonItem+Extension.h
//  LZExtension
//
//  Created by 寕小陌 on 2016/12/9.
//  Copyright © 2016年 寕小陌. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  此分类增加了一些关于UIBarButtonItem的有用方法
 */
@interface UIBarButtonItem (Extension)
/**
 *  返回没有调整图片
 */
+ (UIBarButtonItem *)lz_itemWithImageName:(NSString *)imageName highImageName:(NSString *)highImageName target:target action:(SEL)action;

/**
 *  没有文字调整的按钮
 */
+ (UIBarButtonItem *)lz_itemWithName:(NSString *)Name font:(CGFloat)font target:target action:(SEL)action;

/**
 *  返回调整文字
 */
+ (NSArray *)lz_itemsWithName:(NSString *)Name font:(CGFloat)font target:target action:(SEL)action;

/**
 *  返回调整图片
 */
+ (NSArray *)lz_itemsWithImageName:(NSString *)imageName highImageName:(NSString *)highImageName target:target action:(SEL)action;
@end
