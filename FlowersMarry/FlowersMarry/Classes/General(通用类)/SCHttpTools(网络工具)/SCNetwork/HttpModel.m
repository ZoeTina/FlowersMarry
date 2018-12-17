//
//  HttpModel.m
//  NetToolTest
//
//  Created by 宁小陌 on 2017/10/9.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "HttpModel.h"
#import "UrlConfig.h"

@implementation HttpModel

-(void)setUrl:(NSString *)url{

    _url = [NSString stringWithFormat:@"%@%@",BaseUrl,url];
}

-(void)fillGetParameterWithUrl:(NSString *)url andParameter:(NSDictionary *)dic{

    NSString *param = [self parameters_Url:dic];
    _url = [NSString stringWithFormat:@"%@%@%@version=%@",BaseUrl,url,param,@"1"];
}

-(void)fillPostParameterWithUrl:(NSString *)url andParameter:(NSDictionary *)dic{
    
}

-(void)fillGetParameterWithNewUrl:(NSString *)url andParameter:(NSDictionary *)dic{
    
}
-(void)fillPostParameterWithNewUrl:(NSString *)url andParameter:(NSDictionary *)dic{
    
}

//参数转换
-(NSString*)parameters_Url:(NSDictionary*)data{
    NSArray* keys = [data allKeys];
    NSString* parameters_Url = @"";
    for (int i=0; i<data.count; i++) {
        NSString* data_key = keys[i];
        NSString* data_value = [data objectForKey:data_key];
        NSString* parameter = [NSString stringWithFormat:@"%@=%@&",data_key,data_value];
        parameters_Url = [parameters_Url stringByAppendingString:parameter];
    }
    parameters_Url = [NSString stringWithFormat:@"?%@",parameters_Url];
    return parameters_Url;
}

@end
