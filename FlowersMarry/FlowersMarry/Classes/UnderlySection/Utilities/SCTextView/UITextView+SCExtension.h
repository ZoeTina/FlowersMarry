//
//  UITextView+SCExtension.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/9.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (SCExtension)

/// placeholder lable
@property(nonatomic,readonly)  UILabel *placeholdLabel;

/// placeholder 文字
@property(nonatomic,strong) IBInspectable NSString *placeholder;

/// placeholder 文字颜色
@property(nonatomic,strong) IBInspectable UIColor *placeholderColor;

/// 富文本
@property(nonnull,strong) NSAttributedString *attributePlaceholder;

/// 位置
@property(nonatomic,assign) CGPoint location;

/// 默认颜色
+ (UIColor *)defaultColor;

@end
