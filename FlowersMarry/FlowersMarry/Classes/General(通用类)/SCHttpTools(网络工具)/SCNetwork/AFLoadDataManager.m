//
//  AFLoadDataManager.m
//  AFNetworkingDemo
//
//  Created by xiangjf on 2017/6/13.
//  Copyright © 2017年 Zcy. All rights reserved.
//

#import "AFLoadDataManager.h"
#import "AFNetworking.h"
#import "AFSessionManager.h"
#import "UrlConfig.h"
#import "HttpModel.h"

static NSMutableArray *_allSessionTask;
@interface AFLoadDataManager ()

@property (nonatomic, strong) AFHTTPSessionManager *manager;

@end

@implementation AFLoadDataManager

+ (void)cancleAllRequest {
    @synchronized (self) {
        [[self allSessionTask] enumerateObjectsUsingBlock:^(NSURLSessionTask  *_Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
            [task cancel];
        }];
        [[self allSessionTask] removeAllObjects];
    }
}


/**
 取消指定接口的网络请求

 @param url 接口，@"getAdInfo"
 */
+ (void)cancleRequestWithUrl:(NSString *)url {
    if (!url) return;
    @synchronized (self) {
        [[self allSessionTask] enumerateObjectsUsingBlock:^(NSURLSessionTask  *_Nonnull task, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([task.currentRequest.URL.absoluteString hasPrefix:url]) {
                [task cancel];
                [[self allSessionTask] removeObject:task];
                *stop = YES;
            }
        }];
    }
}

+ (NSMutableArray *)allSessionTask {
    if (!_allSessionTask) {
        _allSessionTask = [[NSMutableArray alloc] init];
    }
    return _allSessionTask;
}

- (NSString *)getCompleteUrlWithParaUrl:(NSString *)url {
    NSString *complateUrl = [NSString stringWithFormat:@"%@%@",BaseUrl, url];
    return complateUrl;
}

+ (void)requestDataWithUrl:(NSString *)url Params:(NSDictionary *)params requestType:(RequestType)requestType SuccessBlock:(SuccessBlock)success FailureBlock:(FailureBlock)failure {
    
  //  AFSessionManager *manager = [AFSessionManager shareInstance];
    AFLoadDataManager *loadManager = [[AFLoadDataManager alloc] init];
    if (loadManager) {
        
        if (requestType == RequestPOST) {
            [loadManager PostDataWithWithUrl:url Params:params SuccessBlock:success FailureBlock:failure];
        }else {
            [loadManager GetDataWithWithUrl:url Params:params SuccessBlock:success FailureBlock:failure];
        }
    }
    
}

- (void)PostDataWithWithUrl:(NSString *)url Params:(NSDictionary *)params SuccessBlock:(SuccessBlock)successBlock FailureBlock:(FailureBlock)failureBlock {
    
    AFSessionManager *manager = [AFSessionManager shareInstance];
    [manager POST:[self getCompleteUrlWithParaUrl:url] parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        successBlock([responseObject objectForKey:@"data"], [responseObject objectForKey:@"error"]);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
        
    }];
    
    
}

- (void)GetDataWithWithUrl:(NSString *)url Params:(NSDictionary *)params SuccessBlock:(SuccessBlock)successBlock FailureBlock:(FailureBlock)failureBlock {
    AFSessionManager *manager = [AFSessionManager shareInstance];
    [manager GET:[self getCompleteUrlWithParaUrl:url] parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"已发出");
        successBlock([responseObject objectForKey:@"data"], [responseObject objectForKey:@"error"]);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failureBlock(error);
        NSLog(@"%@",error);
    }];
}



+ (void)asyncPostOrGetDataWithPostOrGet:(BOOL)isGet Params:(NSArray *)params success:(void (^)(id result))success failure:(void (^)(NSArray *errors))failure{
    
    AFSessionManager *manager = [AFSessionManager manager];
    
    
    ///返回的json数组
    NSMutableArray * resultArr = [NSMutableArray arrayWithCapacity:params.count];
    ///返回的error
    NSMutableArray* errorArr = [NSMutableArray array];
    
    dispatch_group_t group = dispatch_group_create();
    
    //根据params进行开辟线程请求，遍历数组params
    [params enumerateObjectsUsingBlock:^(HttpModel* paramsModel, NSUInteger index, BOOL *stop) {
        
        // 将当前的下载操作添加到组中
        dispatch_group_enter(group);
        
        //把索引转成对象
        NSString * indexNumber = [[NSString alloc] initWithFormat:@"%ld",(unsigned long)index];
        
        NSString* url = [paramsModel.url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        if (isGet){//GET请求
            //执行网络请求
            [manager GET:url parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
                
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
            
        }else{//POST请求
            
            
            [manager POST:url parameters:paramsModel.postParams progress:^(NSProgress * _Nonnull downloadProgress) {
                
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
        }
    }];
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        //回调主线程，返回数据
        if (errorArr.count) {
            failure(errorArr);
        }else{
            //用于成功回调json数据
            NSMutableDictionary *resutJsonDict = [NSMutableDictionary dictionaryWithCapacity:resultArr.count];
            for (int i=0; i<resultArr.count; i++){
                NSString * indexStr = [NSString stringWithFormat:@"%d",i];
                for (NSDictionary * jsonDict in resultArr) {
                    if ([jsonDict.allKeys.firstObject isEqualToString:indexStr] ) {
                        [resutJsonDict setObject:jsonDict[indexStr] forKey:indexStr];
                        continue;
                    }
                }
                
            }
            success(resutJsonDict);
        }
    });
}



@end
