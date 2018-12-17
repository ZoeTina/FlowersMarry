//
//  AFLoadDataManager.h
//  AFNetworkingDemo
//
//  Created by xiangjf on 2017/6/13.
//  Copyright © 2017年 Zcy. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^SuccessBlock)(id responseObject, NSString *errorMsg);

typedef void(^FailureBlock)(id error);

//typedef void(^FailureErrorMsg)(NSString *errorMsg);

typedef NS_ENUM(NSUInteger, RequestType) {
    RequestPOST,
    RequestGET
};

@interface AFLoadDataManager : NSObject

//请求一个接口
+ (void)requestDataWithUrl:(NSString *)url Params:(NSDictionary *)params requestType:(RequestType)requestType SuccessBlock:(SuccessBlock)success FailureBlock:(FailureBlock)failure;

//请求多个接口
+ (void)asyncPostOrGetDataWithPostOrGet:(BOOL)isGet Params:(NSArray *)params success:(void (^)(id result))success failure:(void (^)(NSArray *errors))failure;

//取消所有网络请求
+ (void)cancleAllRequest;

//取消置顶URL的HTTP请求
+ (void)cancleRequestWithUrl:(NSString *)url;
@end
