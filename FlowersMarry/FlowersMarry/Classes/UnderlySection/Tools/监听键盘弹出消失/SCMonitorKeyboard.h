//
//  SCMonitorKeyboard.h
//  监听键盘弹出消失
//  FlowersMarry
//
//  Created by 宁小陌 on2017/2/17.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SCBlock)(NSInteger height);

@interface SCMonitorKeyboard : NSObject

/**
 *  @author 寜小陌, 16-02-20 17:02:02
 *
 *  移除监察者,控制器跳转的时候调用一下就行,也可不用调用
 */
+(void)sc_RemoveMonitor;


/**
 *  @author 寜小陌, 16-02-20 17:02:47
 *
 *  添加监听键盘弹出或消失方法,
 *
 *  @param showBackBlock 键盘 弹出的回调block,可带动画效果
 *  @param dismissBackBlock 键盘 消失的回调block,带动画效果
 */
+(void)sc_AddMonitorWithShowBack:(SCBlock)showBackBlock andDismissBlock:(SCBlock)dismissBackBlock;


@end
