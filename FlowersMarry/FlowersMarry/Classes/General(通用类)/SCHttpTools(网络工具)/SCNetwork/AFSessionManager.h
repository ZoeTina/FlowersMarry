//
//  AFSessionManager.h
//  AFNetworkingDemo
//
//  Created by 宁小陌 on 2017/10/9.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "AFHTTPSessionManager.h"

typedef NS_ENUM(NSInteger, ResposeStyle) {
    Json,
    Xml,
    Data
};

typedef NS_ENUM(NSInteger, RequestStyle) {
    RequestJson,
    RequestString,
    RequestDefault
};

@interface AFSessionManager : AFHTTPSessionManager

+ (AFSessionManager *)shareInstance;

@end
