//
//  SCLoginTools.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/25.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "SCLoginTools.h"

@implementation SCLoginTools

+ (void)loginWithPlatform:(SSDKPlatformType)platform successBlock:(ThridLoginSuccessBlock)success failureBlock:(ThridLoginFailureBlock)failure {
    if (platform == SSDKPlatformTypeSinaWeibo) {
        [self weiboLoginWithSuccessBlock:success failureBlock:failure];
    }else {
        [self wechatAndQQLoginWithPlatform:platform SuccessBlock:success failureBlock:failure];
    }
}

//微博不需要判断是否安装客户端，直接登陆
+ (void)weiboLoginWithSuccessBlock:(ThridLoginSuccessBlock)success failureBlock:(ThridLoginFailureBlock)failure {
    [ShareSDK getUserInfo:SSDKPlatformTypeSinaWeibo onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
        if (state == SSDKResponseStateSuccess) {
            success(user);
        }else {
            failure(@"", error);
        }
    }];
}

//微信和QQ登陆，如果没有安装，直接返回提示信息，
+ (void)wechatAndQQLoginWithPlatform:(SSDKPlatformType)platform SuccessBlock:(ThridLoginSuccessBlock)success failureBlock:(ThridLoginFailureBlock)failure {
    
    if (platform == SSDKPlatformTypeQQ) {
        if ([ShareSDK isClientInstalled:SSDKPlatformTypeQQ]) {
            [ShareSDK getUserInfo:SSDKPlatformTypeQQ onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
                if (state == SSDKResponseStateSuccess) {
                    success(user);
                } else {
                    failure(@"", error);
                }
            }];
        }else {
            failure(@"请下载QQ应用程序进行登录", nil);
        }
        
    }else {
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]){
            
            [ShareSDK getUserInfo:SSDKPlatformTypeWechat onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
                if (state == SSDKResponseStateSuccess) {
                    success(user);
                } else {
                    failure(@"", error);
                }
            }];
        }else {
            failure(@"请下载微信应用程序进行登录", nil);
        }
    }
    
    
    
    //    if ([ShareSDK isClientInstalled:platform]) {
    //        [ShareSDK getUserInfo:platform onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
    //            if (state == SSDKResponseStateSuccess) {
    //                success(user);
    //            } else {
    //                failure(@"", error);
    //            }
    //        }];
    //    }else {
    //        if (platform == SSDKPlatformTypeQQ) {
    //            failure(@"请下载QQ应用程序进行登录", nil);
    //        }else {
    //            failure(@"请下载微信应用程序进行登录", nil);
    //        }
    //
    //    }
    
}

@end
