//
//  UIButton+Gradient.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/9/3.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImage+Gradient.h"

@interface UIButton (Gradient)


//[self.button3 gradientButtonWithSize:CGSizeMake(300, 44) colorArray:@[(id)RGB(253, 175, 55),(id)RGB(91, 7, 7)] percentageArray:@[@(0.3),@(1)] gradientType:GradientFromTopToBottom];
/**
 *  根据给定的颜色，设置按钮的颜色
 *  @param btnSize  这里要求手动设置下生成图片的大小，防止coder使用第三方layout,没有设置大小
 *  @param clrs     渐变颜色的数组
 *  @param percent  渐变颜色的占比数组
 *  @param type     渐变色的类型
 */
- (UIButton *)gradientButtonWithSize:(CGSize)btnSize colorArray:(NSArray *)clrs percentageArray:(NSArray *)percent gradientType:(GradientType)type;

@end
