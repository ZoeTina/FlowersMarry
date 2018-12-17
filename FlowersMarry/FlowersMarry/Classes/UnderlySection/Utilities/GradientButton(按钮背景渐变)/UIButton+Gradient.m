//
//  UIButton+Gradient.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/9/3.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "UIButton+Gradient.h"

@implementation UIButton (Gradient)
- (UIButton *)gradientButtonWithSize:(CGSize)btnSize colorArray:(NSArray *)clrs percentageArray:(NSArray *)percent gradientType:(GradientType)type {
    
    UIImage *backImage = [[UIImage alloc]createImageWithSize:btnSize gradientColors:clrs percentage:percent gradientType:type];
    
    [self setBackgroundImage:backImage forState:UIControlStateNormal];
    
    return self;
}
@end
