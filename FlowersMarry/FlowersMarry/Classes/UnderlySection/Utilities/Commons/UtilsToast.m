//
//  UtilsToast.h
//  LZKit
//
//  Created by 宁小陌 on 15/6/16.
//  Copyright (c) 2015年 宁小陌. All rights reserved.
//
//  活动指示器

#import "UtilsToast.h"

// 背景视图的宽度/高度
#define BGVIEW_WIDTH 100.0f
// 文字大小
#define TEXT_SIZE 15.0f

@implementation UtilsToast

+ (instancetype)sharedHUD {
    
    static UtilsToast *hud;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        hud = [[UtilsToast alloc] initWithWindow:[UIApplication sharedApplication].keyWindow];
    });
    return hud;
}

+ (void)showStatus:(UtilsToastStatus)status text:(NSString *)text {
    
    UtilsToast *hud = [UtilsToast sharedHUD];
    [hud show:YES];
    [hud setLabelText:text];
    [hud setRemoveFromSuperViewOnHide:YES];
    [hud setLabelFont:[UIFont systemFontOfSize:TEXT_SIZE]];
    [hud setMinSize:CGSizeMake(BGVIEW_WIDTH, BGVIEW_WIDTH)];
    [[UIApplication sharedApplication].keyWindow addSubview:hud];
    
    switch (status) {
            
        case UtilsToastStatusSuccess: {
            
            hud.mode = MBProgressHUDModeCustomView;
            UIImageView *sucView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hud_success"]];
            hud.customView = sucView;
            [hud hide:YES afterDelay:2.0f];
        }
            break;
            
        case UtilsToastStatusError: {
            
            hud.mode = MBProgressHUDModeCustomView;
            UIImageView *errView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hud_error"]];
            hud.customView = errView;
            [hud hide:YES afterDelay:2.0f];
        }
            break;
            
        case UtilsToastStatusWaitting: {
            
            hud.mode = MBProgressHUDModeIndeterminate;
        }
            break;
            
        case UtilsToastStatusInfo: {
            
            hud.mode = MBProgressHUDModeCustomView;
            UIImageView *errView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hud_info"]];
            hud.customView = errView;
            [hud hide:YES afterDelay:2.0f];
        }
            break;
            
        default:
            break;
    }
}

+ (void)showText:(NSString *)text {
    
    UtilsToast *hud = [UtilsToast sharedHUD];
    [hud show:YES];
    [hud setLabelText:text];
    [hud setMinSize:CGSizeZero];
    [hud setMode:MBProgressHUDModeText];
    [hud setRemoveFromSuperViewOnHide:YES];
    [hud setMinSize:CGSizeMake(150, 20)];
    [hud setLabelFont:[UIFont systemFontOfSize:TEXT_SIZE]];
    [hud hide:YES afterDelay:2.2f];
    [[UIApplication sharedApplication].keyWindow addSubview:hud];
}

+ (void)showInfoText:(NSString *)text {
    
    [self showStatus:UtilsToastStatusInfo text:text];
}

+ (void)showFailureText:(NSString *)text {
    
    [self showStatus:UtilsToastStatusError text:text];
}

+ (void)showSuccessText:(NSString *)text {
    
    [self showStatus:UtilsToastStatusSuccess text:text];
}

+ (void)showLoadingText:(NSString *)text {
    
    [self showStatus:UtilsToastStatusWaitting text:text];
}

+ (void)hide {
    
    [[UtilsToast sharedHUD] hide:YES];
}

@end
