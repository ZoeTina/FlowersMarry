//
//  UIView+SCValidation.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/23.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (SCValidation)
@property (nonatomic) IBInspectable CGFloat cornerRadius;

/** 头像圆角 */
@property (nonatomic) IBInspectable BOOL avatarCorner;

/** 边框 */
@property (nonatomic) IBInspectable CGFloat borderWidth;

/** 边框颜色*/
@property (nonatomic, strong) IBInspectable UIColor *borderColor;

+ (__kindof UIView *)SCLoadNibView;
- (void)SCSetViewCircleWithBorderWidth:(CGFloat) width andColor:(UIColor *)borColor;
- (void)SCViewSetCornerRadius:(CGFloat)radius;
@end
