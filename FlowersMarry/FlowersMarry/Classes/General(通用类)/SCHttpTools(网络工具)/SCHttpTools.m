//
//  SCHttpTools.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/23.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "SCHttpTools.h"
#import "SCUploadImageModel.h"
#import "AFSessionManager.h"

#define timeoutInterval 20

static AFHTTPSessionManager* manager_ = nil;
@implementation SCHttpTools

+(void)cancelCurrentRequest{
    [manager_.tasks makeObjectsPerformSelector:@selector(cancel)];
    
}
+(void)invalidateCancelingRequest{
    [manager_ invalidateSessionCancelingTasks:true];
}

+ (NSMutableDictionary *) parameterDealwith:(NSDictionary *)parameter{
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    if (parameter) {
        dictionary = [parameter mutableCopy];
    }
    /// 设置时间戳参数
    NSString *timestapStr = [Utils lz_getCurrentTimestamp];
    [dictionary setObject:timestapStr forKey:@"timestamp"];
    NSString *signStr = @"";
    /// 判断是否有sid值
    if (kUserInfo.sid.length>0){
        /// 添加sid参数
        [dictionary setObject:kUserInfo.sid forKey:@"sid"];
        /// 转换参数且排序
        signStr = [Utils sortedDictionarybyCaseConversion:dictionary];
        /// 将参数转码
        NSString *encodedString = [NSString URLEncodedString:signStr];
        /// 转码后加上sid(密钥)作为签名
        signStr = [NSString stringWithFormat:@"%@%@",encodedString,[NSString md5:kUserInfo.sid]];
    }else{
        /// 转换参数且排序
        signStr = [Utils sortedDictionarybyCaseConversion:dictionary];
        /// 将参数转码
        NSString *encodedString = [NSString URLEncodedString:signStr];
        /// 转码后加上固定格式(密钥)作为签名
        signStr = [NSString stringWithFormat:@"%@%@",encodedString,@"wed.114@&%detclkq$"];
    }
    TTLog(@"加密前 --- %@ \n 加密后 --- %@",signStr,[NSString md5:signStr]);
    /// 添加sign参数，并将sign参数进行md5加密
    [dictionary setObject:[NSString md5:signStr] forKey:@"sign"];

    return dictionary;
}


+ (NSString *) dealwithURLString:(NSString *)URLString{
    /// 根据 / 分割字符串
    NSArray *array = [URLString componentsSeparatedByString:@"/"];
    if ([array[0] isEqualToString:@"invitation"]) {
        URLString = [URLString stringByReplacingOccurrencesOfString:@"invitation/" withString:InvitationDomain];
    }else{
        URLString = [NSString stringWithFormat:@"%@%@",DynamicUrl,URLString];
    }
    URLString = [URLString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    URLString = [URLString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    return URLString;
}
#pragma mark -------- 用于单个接口进行 Get 网络请求,只能用于json格式数据请求，否则报错 --------
/**
 *  用于单个接口进行 Get 网络请求,只能用于json格式数据请求，否则报错
 *
 *  @param URLString URLString
 *  @param parameter 参数
 *  @param success   成功回调
 *  @param failure   失败回调
 */
+(void)getWithURLString:(NSString *)URLString parameter:(NSDictionary *)parameter success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    TTLog(@"get --- 1 --- 接口请求地址  --- %@ \n parameter ---%@",URLString,parameter);

    URLString = [self dealwithURLString:URLString];
    if(URLString.length == 0)return;
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    dictionary = [self parameterDealwith:parameter];
    TTLog(@"get --- 2 --- 接口请求地址  --- %@ \n parameter ---%@",URLString,dictionary);

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setTimeoutInterval:timeoutInterval];
    manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];

    [manager GET:URLString parameters:dictionary progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            NSDictionary *result = responseObject;
            if ([result isKindOfClass:[NSDictionary class]]) {
                FMGeneralModel *genralModel = [FMGeneralModel mj_objectWithKeyValues:result];
                TTLog(@"得到新的SID --- %@",genralModel.sid);
                kUserInfo.sid = genralModel.sid;
                [kUserInfo dump];
            }
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error && failure) {
            failure(error);
        }
    }];
}

#pragma mark -------- 用于单个接口进行 Post 网络请求,只能用于json格式数据请求，否则报错 --------
/**
 *  用于单个接口进行 Post 网络请求,只能用于json格式数据请求，否则报错
 *
 *  @param URLString URL
 *  @param parameter 参数
 *  @param success   成功回调
 *  @param failure   失败回调
 */
+(void)postWithURLString:(NSString *)URLString parameter:(NSDictionary *)parameter success:(void(^)(id responseObject))success failure:(void(^)(NSError *error))failure{
    
    URLString = [self dealwithURLString:URLString];
    if(URLString.length == 0)return;
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    dictionary = [self parameterDealwith:parameter];
    TTLog(@"接口请求地址  --- %@ \n parameter ---%@",URLString,dictionary);
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setTimeoutInterval:timeoutInterval];
    manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
  
    
    [manager POST:URLString parameters:dictionary progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            NSDictionary *result = responseObject;
            if ([result isKindOfClass:[NSDictionary class]]) {
                FMGeneralModel *genralModel = [FMGeneralModel mj_objectWithKeyValues:result];
                TTLog(@"得到新的SID --- %@",genralModel.sid);
                kUserInfo.sid = genralModel.sid;
                [kUserInfo dump];
            }
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error && failure) {
            failure(error);
        }
    }];
}

#pragma mark -------- 一个页面多个Get和Post请求 --------
/**
 *  对Get和Post进行多个请求
 *
 *  @param params  请求的参数
 *  @param success 请求成功回调
 *  @param failure 请求失败回调
 */

+ (void)getMoreDataWithParams:(NSArray<SCHttpToolsModel*> *)params success:(void (^)(id result))success failure:(void (^)(NSArray *errors))failure{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setTimeoutInterval:timeoutInterval];
    manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    
    ///返回的json数组
    NSMutableArray * resultArr = [NSMutableArray arrayWithCapacity:params.count];
    ///返回的error
    NSMutableArray* errorArr = [NSMutableArray array];
    
    dispatch_group_t group = dispatch_group_create();
    
    //根据params进行开辟线程请求，遍历数组params
    [params enumerateObjectsUsingBlock:^(SCHttpToolsModel* netModel, NSUInteger index, BOOL *stop) {
        
        //把索引转成对象
        NSString * indexNumber = [[NSString alloc] initWithFormat:@"%ld",(unsigned long)index];
        netModel.url = [netModel.url stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        NSString* getUrl = [netModel.url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        if(getUrl.length == 0){
            NSDictionary * jsonDict = @{indexNumber:@"NODATA"};
            [resultArr addObject:jsonDict];
        }else{
            // 将当前的下载操作添加到组中
            dispatch_group_enter(group);
            if (netModel.isGetOrPost) {//get
                //执行网络请求
                [manager GET:getUrl parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    if (success) {
                        //保存调用结果
                        NSDictionary * jsonDict = @{indexNumber:responseObject};
                        [resultArr addObject:jsonDict];
                    }
                    // 离开当前组
                    dispatch_group_leave(group);
                    
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    
                    if (error) {
                        //保存调用的error
                        NSError * errorDict = error;
                        [errorArr addObject:errorDict];
                    }
                    // 离开当前组
                    dispatch_group_leave(group);
                }];
            } else{//post
                [manager POST:getUrl parameters:netModel.param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    if (success) {
                        //保存调用结果
                        NSDictionary * jsonDict = @{indexNumber:responseObject};
                        [resultArr addObject:jsonDict];
                    }
                    // 离开当前组
                    dispatch_group_leave(group);
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    if (error) {
                        //保存调用的error
                        NSError * errorDict = error;
                        [errorArr addObject:errorDict];
                    }
                    // 离开当前组
                    dispatch_group_leave(group);
                }];
            }
        }
    }];
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        //回调主线程，返回数据
        if (resultArr.count < 1) {
            failure(errorArr);
        }else{
            //用于成功回调json数据
            NSMutableDictionary *resutJsonDict = [NSMutableDictionary dictionaryWithCapacity:resultArr.count];
            for (int i=0; i<resultArr.count; i++){
                //                NSString * indexStr = [NSString stringWithFormat:@"%d",i];
                NSDictionary * jsonDict = [resultArr lz_safeObjectAtIndex:i];
                [resutJsonDict addEntriesFromDictionary:jsonDict];
//                for (NSDictionary * jsonDict in resultArr) {
//                    if ([jsonDict.allKeys.firstObject isEqualToString:indexStr] ) {
//                        [resutJsonDict setObject:jsonDict[indexStr] forKey:indexStr];
//                        continue;
//                    }
//                }
            }
            success(resutJsonDict);
        }
    });
}

#pragma mark -------- 上传头像 --------
/**
 *  上传头像
 *
 *  @param URLString 请求URLString
 *  @param parameter 请求参数
 *  @param image 上传图片
 *  @param success 请求成功回调
 *  @param failure 请求失败回调
 */
+ (void)postImageWithURLString:(NSString *)URLString parameter:(NSDictionary *)parameter image:(UIImage *)image success:(void (^)( id result))success failure:(void (^)(NSError *error))failure{
    AFSessionManager *manager = [AFSessionManager shareInstance];
    [manager.requestSerializer setTimeoutInterval:timeoutInterval];
    manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    
    NSString *totalUrl = [NSString stringWithFormat:@"%@%@", DynamicUrl, URLString];
    
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    dictionary = [parameter mutableCopy];
    if (kUserInfo.isLogin) {
        [dictionary setObject:kUserInfo.sid forKey:@"sid"];
    }else{
//        Toast(@"当前未登录");
    }
    
    TTLog(@" --- - %@",dictionary);
    [manager POST:totalUrl parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *data = UIImageJPEGRepresentation(image,0.5);//把要上传的图片转成NSData
        
        // 可以在上传时使用当前的系统事件作为文件名
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        // 设置时间格式
        [formatter setDateFormat:@"yyyyMMddHHmmss"];
        NSString *dateString = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.jpg", dateString];
        if (data == nil) return;
        [formData appendPartWithFileData:data name:@"file" fileName:fileName mimeType:@"image/jpeg"];
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            NSDictionary *result = responseObject;
            if ([result isKindOfClass:[NSDictionary class]]) {
                
                TTLog(@" -- -%@",result[@"sid"]);
                kUserInfo.sid = result[@"sid"];
                [kUserInfo dump];
            }
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            failure(error);
        }
    }];
}

#pragma mark -------- 上传照片数组 --------
/**
 *  上传照片数组
 *
 *  @param URLString 上传照片URLString
 *  @param parameter 参数
 *  @param imagesArray 照片数组
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+ (void)postImageArrayWithURLString:(NSString *)URLString parameter:(NSDictionary *)parameter imagesArray:(NSArray *)imagesArray
                            success:(void (^)(NSArray *result))success failure:(void (^)(NSArray *errorResult))failure{
    AFSessionManager *manager = [AFSessionManager shareInstance];
    [manager.requestSerializer setTimeoutInterval:timeoutInterval];
    manager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    
    NSString *totalUrl = [NSString stringWithFormat:@"%@%@", DynamicUrl, URLString];
    
    NSMutableArray *resultArr = [NSMutableArray arrayWithCapacity:imagesArray.count];
    NSMutableArray *errorArr = [NSMutableArray array];
    dispatch_group_t group = dispatch_group_create();
    [imagesArray enumerateObjectsUsingBlock:^(UIImage *postImage, NSUInteger index, BOOL * _Nonnull stop) {
        dispatch_group_enter(group);
        //把索引转成对象
        NSString * indexNumber = [[NSString alloc] initWithFormat:@"%ld",(unsigned long)index];
        TTLog(@"indexNumber --- %@", indexNumber);
        [manager POST:totalUrl parameters:parameter constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
            NSData *data = UIImageJPEGRepresentation(postImage,0.5);//把要上传的图片转成NSData
            
            // 可以在上传时使用当前的系统事件作为文件名
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            // 设置时间格式
            [formatter setDateFormat:@"yyyyMMddHHmmss"];
            NSString *dateString = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString stringWithFormat:@"%@.jpg", dateString];
            if (data == nil) return;
            [formData appendPartWithFileData:data name:@"file" fileName:fileName mimeType:@"image/jpeg"];
            
        } progress:^(NSProgress * _Nonnull uploadProgress) {
            
        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            if (responseObject) {
                NSDictionary *result = responseObject;
                if ([result isKindOfClass:[NSDictionary class]]) {
                    kUserInfo.sid = result[@"sid"];
                    [kUserInfo dump];
                }
                if ([[result lz_objectForKey:@"errcode"] integerValue] == 0) {
                    SCUploadImageModel *model = [SCUploadImageModel mj_objectWithKeyValues:result];
                    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
                    [dictionary setValue:model.data.full_url forKey:@"p_filename"];
                    [dictionary setValue:model.data.title forKey:@"p_filetitle"];
                    [resultArr addObject:dictionary];
                }
            }
            dispatch_group_leave(group);
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (error) {
                //保存调用的error
                NSError * errorDict = error;
                [errorArr addObject:errorDict];
            }
            // 离开当前组
            dispatch_group_leave(group);
        }];
    }];
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        //回调主线程，返回数据
        success(resultArr);
        failure(errorArr);
    });
}
@end
