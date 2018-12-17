//
//  UIScreen+Extension.h
//  LZExtension
//
//  Created by 寕小陌 on 2016/12/12.
//  Copyright © 2016年 寕小陌. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  此分类增加了一些关于UIScreen的有用方法
 */
@interface UIScreen (Extension)

+ (CGSize)lz_screenSize;
+ (BOOL)lz_isRetina;
+ (CGFloat)lz_scale;

/**
 *  检查当前设备是否是视网膜显示屏
 *
 *  @return YES视网膜显示屏，NO非视网膜显示屏
 */
+ (BOOL)lzs_isRetina;

/**
 *  检查当前设备是否是视网膜高清显示屏
 *
 *  @return YES视网膜高清显示屏，NO非视网膜高清显示屏
 */
+ (BOOL)lz_isRetinaHD;


/**
 *  获取当前设备的亮度
 *
 *  @return 返回当前设备的亮度
 */
+ (CGFloat)lz_brightness;

/**
 *  设置当前设备的亮度
 *
 *  @param brightness 新的亮度值
 */
+ (void)lz_setBrightness:(CGFloat)brightness;
@end
