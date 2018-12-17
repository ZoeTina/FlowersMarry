//
//  MVTagButton.m
//  MerchantVersion
//
//  Created by 寜小陌 on 2018/2/28.
//  Copyright © 2018年 寜小陌. All rights reserved.
//

#import "MVTagButton.h"
extern CGFloat const imageViewWH;
@implementation MVTagButton

- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (self.imageView.frame.size.width <= 0) return;
    
    CGFloat btnW = self.bounds.size.width;
    CGFloat btnH = self.bounds.size.height;
    
    self.titleLabel.frame = CGRectMake(_margin, self.titleLabel.frame.origin.y, self.titleLabel.frame.size.width, self.titleLabel.frame.size.height);
    
    CGFloat imageX = btnW - self.imageView.frame.size.width -  _margin;
    self.imageView.frame = CGRectMake(imageX, (btnH - imageViewWH) * 0.5, imageViewWH, imageViewWH);
    //    TTLog(@"%@",NSStringFromCGRect(self.frame));
    //    TTLog(@"%@",NSStringFromCGRect(self.imageView.frame));
}

- (void)setHighlighted:(BOOL)highlighted {}


@end
