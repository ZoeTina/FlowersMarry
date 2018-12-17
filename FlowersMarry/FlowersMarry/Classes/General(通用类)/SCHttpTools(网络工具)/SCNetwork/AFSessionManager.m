//
//  AFSessionManager.m
//  AFNetworkingDemo
//
//  Created by 宁小陌 on 2017/10/9.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "AFSessionManager.h"

static int const DEFAULT_REQUEST_TIMR_OUT = 15;

static AFSessionManager *manager = nil;

@implementation AFSessionManager
+ (AFSessionManager *)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        self.requestSerializer = [AFHTTPRequestSerializer serializer];
        self.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalAndRemoteCacheData;
        [[NSURLCache sharedURLCache] removeAllCachedResponses];
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",@"text/plain",@"application/json", nil];
        [[self requestSerializer] setTimeoutInterval:DEFAULT_REQUEST_TIMR_OUT];
    }
    return self;
}
@end
