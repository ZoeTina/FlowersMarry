//
//  SCUploadImageModel.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/8/1.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UploadImageModel;
@interface SCUploadImageModel : NSObject
/// 状态 success/failed
@property (nonatomic, copy) NSString *status;
/// 错误码
@property (nonatomic, assign) NSInteger errcode;
///     "sid": "209cu7q89fqh8t0eqmrfpoumn5"
@property (nonatomic, copy) NSString *sid;
/// 文字提示
@property (nonatomic, copy) NSString *message;
@property (nonatomic, strong) UploadImageModel *data;
@end

@interface UploadImageModel : NSObject

/// config
@property (nonatomic, copy) NSString *config;
/// title
@property (nonatomic, copy) NSString *title;
/// full_url
@property (nonatomic, copy) NSString *full_url;
/// URL
@property (nonatomic, copy) NSString *url;

@end

