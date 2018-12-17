//
//  HttpModel.h
//  NetToolTest
//
//  Created by 宁小陌 on 2017/10/9.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpModel : NSObject

///请求中的参数设置
@property(nonatomic, strong) NSDictionary * getParams;

///发送请求的url
@property(nonatomic,copy) NSString * url;

///请求中的参数设置
@property(nonatomic, strong) NSDictionary * postParams;

@property(nonatomic, assign)BOOL isGet;

-(void)fillGetParameterWithUrl:(NSString *)url andParameter:(NSDictionary *)dic;

-(void)fillPostParameterWithUrl:(NSString *)url andParameter:(NSDictionary *)dic;
//
-(void)fillGetParameterWithNewUrl:(NSString *)url andParameter:(NSDictionary *)dic;
-(void)fillPostParameterWithNewUrl:(NSString *)url andParameter:(NSDictionary *)dic;
@end
