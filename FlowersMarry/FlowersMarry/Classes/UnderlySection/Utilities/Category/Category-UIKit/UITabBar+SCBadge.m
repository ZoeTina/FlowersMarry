//
//  UITabBar+SCBadge.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/6/27.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "UITabBar+SCBadge.h"
#define TabbarItemNums 5.0    //tabbar的数量 如果是5个设置为5.0

@implementation UITabBar (SCBadge)

- (void)showBadgeOnItemIndex:(NSInteger)index {
    [self removeBadgeOnItemIndex:index];
    
    UIView *badgeView = [[UIView alloc] init];
    badgeView.tag = 100 + index;
    badgeView.layer.cornerRadius = 5;
    badgeView.backgroundColor = [UIColor redColor];
    
    CGRect tabbarFrame = self.frame;
    CGFloat percentX = (index + 0.6) / TabbarItemNums;
    CGFloat x = ceilf(percentX * tabbarFrame.size.width);
    CGFloat y = ceilf(0.1 * tabbarFrame.size.height);
    badgeView.frame = CGRectMake(x, y, 10, 10);
    [self addSubview:badgeView];
}


- (void)hideBadgeOnItemIndex:(NSInteger)index {
    [self removeBadgeOnItemIndex:index];
}

- (void)removeBadgeOnItemIndex:(NSInteger)index {
    for (UIView *subView in self.subviews) {
        if (subView.tag == 100 + index) {
            [subView removeFromSuperview];
        }
    }
}

@end
