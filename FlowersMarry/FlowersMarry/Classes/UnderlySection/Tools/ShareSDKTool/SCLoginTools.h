//
//  SCLoginTools.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/25.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^ThridLoginSuccessBlock)(SSDKUser *userInfo);
typedef void(^ThridLoginFailureBlock)(NSString *errorStr, NSError *error);

@interface SCLoginTools : NSObject


/**
 *  第三方登陆
 *
 *  @param platform 登陆类型
 *  @param success 成功信息
 *  @param failure 失败信息
 */
+ (void)loginWithPlatform:(SSDKPlatformType)platform successBlock:(ThridLoginSuccessBlock)success failureBlock:(ThridLoginFailureBlock)failure;

@end
