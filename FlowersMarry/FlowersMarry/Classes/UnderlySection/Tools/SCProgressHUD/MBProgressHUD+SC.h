//
//  MBProgressHUD+SC.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/25.
//  Copyright © 2018年 宁小陌. All rights reserved.
//


#import "MBProgressHUD.h"
@interface MBProgressHUD (SC)

+ (void)showSuccess:(NSString *)success toView:(UIView *)view;
+ (void)showError:(NSString *)error toView:(UIView *)view;

+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;


+ (void)showSuccess:(NSString *)success;
+ (void)showError:(NSString *)error;

+ (MBProgressHUD *)showMessage:(NSString *)message;

+ (void)hideHUDForView:(UIView *)view;
+ (void)hideHUD;

@end
