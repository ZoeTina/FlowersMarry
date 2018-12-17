//
//  AppDefine.h
//  MerchantVersion
//
//  Created by 寜小陌 on 2018/1/19.
//  Copyright © 2018年 寜小陌. All rights reserved.
//

#ifndef AppDefine_h
#define AppDefine_h


/// 内购
#ifdef DEBUG
static NSString * const PurchaseURL=@"https://sandbox.itunes.apple.com/verifyReceipt"; //debug
#else
static NSString * const PurchaseURL=@"https://buy.itunes.apple.com/verifyReceipt";  //其他
#endif


////////// 百度地图 /////////////EajhH8NSUg96kUYjxPhKz8eq
#define kBaiDuAppKey @"EajhH8NSUg96kUYjxPhKz8eq"//百度地图的key
#define kTencentAppKey @"UBSBZ-4ENCU-CSUVT-BYK5N-DAWRK-GYFX5"//腾讯地图的key


////////// QQ分享功能Key /////////////
#define kQQAppId  @"1105999352"
#define kQQAppKey @"eqb84UMcbFWN4JIZ"

////////// 微信分享/支付Key //////////
#define kWechatAppId   @"wx5b82aaeaa773d563"
#define kWechatAppSecret @"a5aecff64f3fd006cf1377f12819fc39"
////////// 微信请帖小程序 //////////
#define kWechatInvitationId  @"wx9100746b25db0e25"

///////// 新浪微博分享Key ///////////
#define kSinaAppKey @"1842787284"
#define kSinaRedirectURI    @"http://www.sina.com"

//////// 讯飞语音

#define kBuglyAppId @"d3a94d98f4"


///////// 极光推送 ///////////
#define kJGAppKey   @"8d6d370d13e362563130a273"
#define kJGAppSecret @"475bc9e9ce20ce6f9e174d5e"


//沙盒测试环境验证
#define SANDBOX @"https://sandbox.itunes.apple.com/verifyReceipt"
//正式环境验证
#define AppStore @"https://buy.itunes.apple.com/verifyReceipt"

#endif /* AppDefine_h */
