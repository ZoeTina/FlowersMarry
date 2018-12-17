//
//  NetWorkAnalysisTool.m
//  PandaVideo
//
//  Created by 宁小陌 on 2017/10/9.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "NetWorkAnalysisTool.h"


@implementation NetWorkAnalysisTool

+ (NSString *)analysisNetworkDataWithDict:(NSDictionary *)dict url:(NSString *)url{
    
    
    
    if ([[dict lz_objectForKey:@"data"] isKindOfClass:[NSDictionary class]]) {
        NSDictionary *data = [dict lz_objectForKey:@"data"];
        if ([[data lz_objectForKey:@"code"] integerValue] == 703) {
            return [data lz_objectForKey:@"comment"];
        }
    }else {
        NSString *data = [dict lz_objectForKey:@"data"];
        if (data.length > 0) {
            return data;
        }
    }
    
    
    NSString *errorMsg = [dict lz_objectForKey:@"errorMsg"];
    if (errorMsg.length > 0) {
        return errorMsg;
    }
    return @"";
}

@end
