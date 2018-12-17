//
//  UIImage+SCExtension.h
//  LZExtension
//
//  Created by 寕小陌 on 2016/12/9.
//  Copyright © 2016年 寕小陌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (SCExtension)


/// 生成指定颜色的一个`点`的图像
///
/// @param color 颜色
///
/// @return 1 * 1 图像
+ (nonnull UIImage *)sc_singleDotImageWithColor:(nonnull UIColor *)color;

/**
 * 裁切圆形图片
 * PNG 图片支持透明
 * JPG 图片不支持透明
 */
- (UIImage *_Nonnull)sc_avatarImage:(CGSize)size
                          backColor:(UIColor *_Nullable)backColor
                        borderColor:(UIColor *_Nullable)borderColor;

/**
 * 取thumb
 */
+ (UIImage*)getThumbImage:(UIImage *)image  size:(CGSize)size;

/**
 * 校正thumb的方向问题
 */
+ (UIImage *)fixOrientation:(UIImage *)aImage;

/// 图片压缩到指定大小
- (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize;



@end
