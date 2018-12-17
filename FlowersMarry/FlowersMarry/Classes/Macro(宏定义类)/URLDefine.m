//
//  URLDefine.m
//  MerchantVersion
//
//  Created by 寜小陌 on 2018/1/19.
//  Copyright © 2018年 寜小陌. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "URLDefine.h"


/// 支付是8081，其他是8082
//NSString *const DynamicUrl = @"http://beta.api2.wed114.cn/?s=";
NSString *const DynamicUrl = @"http://api2.wed114.co/?s=";
NSString *const InvitationDomain = @"http://qingtie.wed114.co/";

NSString *const imageBaseUrl = @"//pic11.wed114.cn/";

NSString *const businessBooking = @"appointment/save";

/// 0:测试环境 1:生产环境
NSString *const environment = @"1";

NSString *const indexSetting = @"";
/// 更改头像
NSString *const updateAvatar = @"user/changeavator";
/// 修改昵称
NSString *const updateNickname = @"/updateNickname";
/// 手机登陆
NSString *const login = @"index/mobilelogin";
/// 第三方账号登陆
NSString *const thirdAccountLogin = @"/thirdAccountLogin";
/// 绑定手机号
NSString *const bindAccount = @"/bindAccount";
/// 获取验证码
NSString *const getVerifyCode = @"/getVerifyCode";
/// token登陆
NSString *const tokenLogin = @"/tokenLogin";
/// 上传文件接口
NSString *const uploadFile = @"file/upload";
/// 版本信息
NSString *const versionManage = @"http://pandafile.sctv.com:42086/System/VersionManage/VersionManage.json";
/// 引导页
NSString *const startPage = @"http://pandafile.sctv.com:42086/System/StartPage/StartPage.json";

/// 获取熊猫钱包余额
NSString *const getPandaBalance = @"/getPandaBalance";
/// 帮助
NSString *const helpJson = @"http://pandafile.sctv.com:42086/System/FAQ/FAQ.json";
/// 登录协议
NSString *const loginProtocol = @"http://app.sctv.com/tv/info/201711/t20171128_3683480.shtml";





