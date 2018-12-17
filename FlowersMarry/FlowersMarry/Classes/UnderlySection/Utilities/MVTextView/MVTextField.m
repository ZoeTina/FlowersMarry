//
//  MVTextField.m
//  MerchantVersion
//
//  Created by 寜小陌 on 2018/2/6.
//  Copyright © 2018年 寜小陌. All rights reserved.
//

#import "MVTextField.h"

@implementation MVTextField


- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextFillRect(context, CGRectMake(0, CGRectGetHeight(self.frame) - 0.5, CGRectGetWidth(self.frame), 0.5));
}


@end
