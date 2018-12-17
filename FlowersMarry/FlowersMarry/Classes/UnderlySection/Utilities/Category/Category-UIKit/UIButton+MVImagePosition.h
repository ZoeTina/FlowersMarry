//
//  UIButton+MVImagePosition.h
//  MerchantVersion
//
//  Created by 寜小陌 on 2018/2/8.
//  Copyright © 2018年 寜小陌. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, MVImagePosition) {
    kMVImagePositionLeft = 0,              // 图片在左，文字在右，默认
    kMVImagePositionRight = 1,             // 图片在右，文字在左
    kMVImagePositionTop = 2,               // 图片在上，文字在下
    kMVImagePositionBottom = 3,            // 图片在下，文字在上
};

@interface UIButton (MVImagePosition)

/**
 *  利用UIButton的titleEdgeInsets和imageEdgeInsets来实现文字和图片的自由排列
 *  注意：这个方法需要在设置图片和文字之后才可以调用，且button的大小要大于 图片大小+文字大小+spacing
 *
 *  @param spacing 图片和文字的间隔
 */
- (void)setImagePosition:(MVImagePosition)postion spacing:(CGFloat)spacing;

@end
