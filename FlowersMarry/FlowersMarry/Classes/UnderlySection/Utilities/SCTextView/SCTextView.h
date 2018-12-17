//
//  SCTextView.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/9.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <UIKit/UIKit.h>



/*
 
 SCTextView *tv = [[SCTextView alloc] initWithFrame:CGRectMake(16, 10, self.view.frame.size.width-2*16, 200)];
 tv.textFont = [UIFont systemFontOfSize:20];
 [self.view addSubview:tv];
 tv.textViewListening = ^(NSString *textViewStr) {
 TTLog(@"tv监听输入的内容：%@",textViewStr);
 };
 
 SCTextView *tv2 = [[SCTextView alloc] initWithFrame:CGRectMake(16, CGRectGetMaxY(tv.frame)+20, self.view.frame.size.width-2*16, 200)];
 tv2.placeholder = @"自定义placeholder";
 tv2.placeholderColor = [UIColor blueColor];
 tv2.borderLineColor = [UIColor redColor];
 tv2.textColor = [UIColor greenColor];
 tv2.textFont = [UIFont systemFontOfSize:18];
 tv2.textMaxNum = 1000;
 tv2.maxNumState = XMMaxNumStateDiminishing;
 [self.view addSubview:tv2];
 tv2.textViewListening = ^(NSString *textViewStr) {
 NSLog(@"tv2监听输入的内容：%@",textViewStr);
 };
 
 UITextView *tv3 = [[UITextView alloc] init];
 tv3.frame = CGRectMake(16, CGRectGetMaxY(tv2.frame)+20, self.view.frame.size.width-2*16, 200);
 tv3.placeholder = @"UITextView可以直接使用placeholder和placeholderColor属性";
 tv3.placeholderColor = [UIColor purpleColor];
 tv3.textColor = [UIColor redColor];
 tv3.font = [UIFont systemFontOfSize:20];
 [self.view addSubview:tv3];
 
 */

/** 文字最多字符数量显示类型 **/
typedef enum {
    SCMaxNumStateNormal = 0,  // 默认模式（0/200）
    SCMaxNumStateDiminishing = 1,  // 递减模式（200）
} SCMaxNumState;

/** 返回输入监听内容 */
typedef void(^SCBackText)(NSString *textViewStr);

@interface SCTextView : UIView

/** 是否设置边框 （默认 Yes） */
@property (nonatomic, assign) BOOL isSetBorder;

/** 上边距 (默认8)*/
@property (nonatomic, assign) CGFloat topSpace;

/** 左 右 边距 (默认8)*/
@property (nonatomic, assign) CGFloat leftAndRightSpace;

/** 边框线颜色 */
@property (nonatomic, strong) UIColor *borderLineColor;

/** 边宽线宽度 */
@property (nonatomic, assign) CGFloat borderLineWidth;

/** textView的内容 */
@property (nonatomic, copy) NSString *text;

/** textView 文字颜色 (默认黑色) */
@property (nonatomic, strong) UIColor *textColor;

/** textView 字体大小 (默认14) */
@property (nonatomic, strong) UIFont *textFont;

/** 占位文字 (默认：请输入内容) */
@property (nonatomic, copy) NSString *placeholder;

/** placeholder 文字颜色 (默认[UIColor grayColor]) */
@property (nonatomic, strong) UIColor *placeholderColor;

/** 文字最多数量 (默认200个字符)*/
@property (nonatomic, assign) int textMaxNum;

/** Num 文字颜色 (默认黑色) */
@property (nonatomic, strong) UIColor *maxNumColor;

/** Num 字体大小 (默认12) */
@property (nonatomic, strong) UIFont *maxNumFont;

/** Num 样式 （默认 0/200） */
@property (nonatomic, assign) SCMaxNumState maxNumState;

/** 返回输入监听内容 */
@property (nonatomic, copy) SCBackText textViewListening;


@end
