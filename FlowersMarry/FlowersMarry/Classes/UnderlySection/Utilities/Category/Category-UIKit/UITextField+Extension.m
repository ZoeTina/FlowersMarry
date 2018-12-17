//
//  UITextField+Extension.m
//  LZExtension
//
//  Created by 寕小陌 on 2016/12/12.
//  Copyright © 2016年 寕小陌. All rights reserved.
//

#import "UITextField+Extension.h"

@implementation UITextField (Extension)

+ (instancetype)lz_textFieldWithPlaceHolder:(NSString *)placeHolder {
    
    UITextField *textField = [[self alloc] init];
    
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.placeholder = placeHolder;
    
    return textField;
}

/**
 *  设置UITextField左边距
 *
 *  @param leftWidth 边距
 */
- (void)lz_setTextFieldLeftPadding:(CGFloat)leftWidth
{
    CGRect frame = self.frame;
    frame.size.width = leftWidth;
    UIView *leftview = [[UIView alloc] initWithFrame:frame];
    self.leftViewMode = UITextFieldViewModeAlways;
    self.leftView = leftview;
    
}

/**
 设置UITextField 右侧清除按钮图片
 
 @param normalButtonName      常规图片名
 @param highlightedButtonName 高亮图片名
 */
- (void)lz_setTextFieldClearButtonNormal:(NSString *)normalButtonName Highlighted:(NSString *)highlightedButtonName
{
    UIButton *clearButton = [self valueForKey:@"_clearButton"];
    [clearButton setImage:[UIImage imageNamed:normalButtonName] forState:UIControlStateNormal];
    [clearButton setImage:[UIImage imageNamed:highlightedButtonName] forState:UIControlStateHighlighted];
    self.clearButtonMode = UITextFieldViewModeAlways;
    
}

/**
 *  设置UITextField Placeholder颜色
 *
 *  @param color 颜色值
 */
- (void)lz_setTextFieldPlaceholderColor:(UIColor *)color
{
    [self setValue:color forKeyPath:@"_placeholderLabel.textColor"];
    
}

/**
 *  设置全局共用UITextField对象的指定格式
 */
+ (void)lz_setTextFieldSpecifiedformat
{
    //设置全局共用UITextField对象的指定格式（在实际开发中自定义）
    [[self alloc] lz_setTextFieldLeftPadding:10];
    
    // TODO:需要设置具体的图片
    [[self alloc] lz_setTextFieldClearButtonNormal:@"" Highlighted:@""];
    
    [[self alloc] lz_setTextFieldPlaceholderColor:[UIColor grayColor]];
    
}

@end
