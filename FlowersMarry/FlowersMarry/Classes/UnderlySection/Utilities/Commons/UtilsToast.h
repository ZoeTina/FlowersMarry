//
//  UtilsToast.h
//  LZKit
//
//  Created by 宁小陌 on 15/6/16.
//  Copyright (c) 2015年 宁小陌. All rights reserved.
//

#pragma mark --  使用方式
/*
 
 [UtilsToast showText:@"心有林夕"];
 [UtilsToast showInfoText:@"请输入账号"];
 [UtilsToast showErrorText:@"加载失败"];
 [UtilsToast showSuccessText:@"加载成功"];
 [UtilsToast showWaittingText:@"正在加载"];
 
 
 */




typedef NS_ENUM(NSInteger, UtilsToastStatus) {
    
    /** 成功 */
    UtilsToastStatusSuccess,
    
    /** 失败 */
    UtilsToastStatusError,
    
    /** 信息 */
    UtilsToastStatusInfo,
    
    /** 加载中 */
    UtilsToastStatusWaitting
};

@interface UtilsToast : MBProgressHUD

/** 返回一个HUD的单例 */
+ (instancetype) sharedHUD;

/** 在window上添加一个HUD */
+ (void) showStatus:(UtilsToastStatus)status text:(NSString *)text;



#pragma mark - 建议使用的方法

/** 在window上添加一个只显示文字的HUD */
+ (void) showText:(NSString *)text;

/** 在window上添加一个提示`信息`的HUD */
+ (void) showInfoText:(NSString *)text;

/** 在window上添加一个提示`失败`的HUD */
+ (void) showFailureText:(NSString *)text;

/** 在window上添加一个提示`成功`的HUD */
+ (void) showSuccessText:(NSString *)text;

/** 在window上添加一个提示`加载中`的HUD, 需要手动关闭 */
+ (void) showLoadingText:(NSString *)text;

/** 手动隐藏HUD */
+ (void) hide;

@end
