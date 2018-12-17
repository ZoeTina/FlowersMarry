//
//  SCHttpTools.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/23.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCHttpToolsModel.h"

@interface SCHttpTools : NSObject

+(void)cancelCurrentRequest;
+(void)invalidateCancelingRequest;


/**
 *  用于单个接口进行 Get 网络请求,只能用于json格式数据请求，否则报错
 *
 *  @param URLString URLString
 *  @param parameter 参数
 *  @param success   成功回调
 *  @param failure   失败回调
 */
+(void)getWithURLString:(NSString *)URLString parameter:(NSDictionary *)parameter success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;


/**
 *  用于单个接口进行 Post 网络请求,只能用于json格式数据请求，否则报错
 *
 *  @param URLString URL
 *  @param parameter 参数
 *  @param success   成功回调
 *  @param failure   失败回调
 */
+(void)postWithURLString:(NSString *)URLString parameter:(NSDictionary *)parameter success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure;

#pragma mark 一个页面多个get和post请求
/**
 *  对get和post进行多个请求
 *
 *  @param params  请求的参数
 *  @param success 请求成功回调
 *  @param failure 请求失败回调
 */

+ (void)getMoreDataWithParams:(NSArray<SCHttpToolsModel*> *)params success:(void (^)(id result))success failure:(void (^)(NSArray *errors))failure;

/**
 上传头像
 
 @param URLString 请求URLString
 @param parameter 请求参数
 @param image 上传图片
 @param success 请求成功回调
 @param failure 请求失败回调
 */
+ (void)postImageWithURLString:(NSString *)URLString parameter:(NSDictionary *)parameter image:(UIImage *)image success:(void (^)( id result))success failure:(void (^)(NSError *error))failure;


/**
 *  上传照片数组
 *
 *  @param URLString 上传照片URLString
 *  @param parameter 参数
 *  @param imagesArray 照片数组
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+ (void)postImageArrayWithURLString:(NSString *)URLString parameter:(NSDictionary *)parameter imagesArray:(NSArray *)imagesArray success:(void (^)(NSArray *result))success failure:(void (^)(NSArray *errorResult))failure;


@end
