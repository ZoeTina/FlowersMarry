//
//  SCVerCodeInputView.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/23.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SCTextViewBlock)(NSString *text);
@interface SCVerCodeInputView : UIView

@property (nonatomic, assign) UIKeyboardType keyBoardType;
@property (nonatomic, copy) SCTextViewBlock block;

/*验证码的最大长度*/
@property (nonatomic, assign) NSInteger maxLenght;

/*未选中下的view的borderColor*/
@property (nonatomic, strong) UIColor *viewColor;

/*选中下的view的borderColor*/
@property (nonatomic, strong) UIColor *viewColorHL;

-(void)sc_verCodeViewWithMaxLenght;


@end
