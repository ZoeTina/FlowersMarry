//
//  SCHttpToolsModel.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/23.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SCHttpToolsModel : NSObject

/// 是Get还是Post
@property(nonatomic, assign)    BOOL                isGetOrPost;
/// 请求链接
@property(nonatomic, copy)      NSString            *url;
/// Post请求参数
@property(nonatomic, strong)    NSMutableDictionary *param;
/// Post请求Body体
@property (nonatomic, copy)     NSString            *postData;
/// 请求结果参数
@property(nonatomic, assign)    NSInteger           requestType;

-(instancetype)initIsGetOrPost:(BOOL)isGet  Url:(NSString*)url  param:(NSDictionary*)param;

@end
