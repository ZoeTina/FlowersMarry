//
//  SCMonitorKeyboard.m
//  监听键盘弹出消失
//  FlowersMarry
//
//  Created by 宁小陌 on 2017/2/17.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "SCMonitorKeyboard.h"

static SCBlock showBlock;
static SCBlock dismissBlock;
static id YYobject;

@implementation SCMonitorKeyboard

+(void)sc_RemoveMonitor {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

+(void)sc_AddMonitorWithShowBack:(SCBlock)showBackBlock andDismissBlock:(SCBlock)dismissBackBlock {
    showBlock = showBackBlock;
    dismissBlock = dismissBackBlock;
    
    //注册监控键盘弹出的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:)name:UIKeyboardWillShowNotification object:nil];
    
    //注册监控键盘隐藏的通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHidden:)name:UIKeyboardWillHideNotification object:nil];
}

+(void) keyBoardWillShow:(NSNotification*) notification {
    //获取键盘的高度
    NSDictionary *userInfo = [notification userInfo];
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    //获取键盘弹出的时间
    CGFloat interval = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey]floatValue];
    CGRect keyboardEndFrame = [aValue CGRectValue];
    CGFloat keyboardHeight = keyboardEndFrame.size.height;
    
    [UIView animateWithDuration:interval animations:^{
        if (showBlock) {
            showBlock(keyboardHeight);
        }
    }];
}

+(void)keyBoardWillHidden:(NSNotification*) notification {
    NSDictionary *userInfo = [notification userInfo];
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGFloat interval = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey]floatValue];
    
    CGRect keyboardEndFrame = [aValue CGRectValue];
    CGFloat keyboardHeight = keyboardEndFrame.size.height;
    
    [UIView animateWithDuration:interval animations:^{
        if (dismissBlock) {
            dismissBlock(keyboardHeight);
        }
    }];
}

@end
