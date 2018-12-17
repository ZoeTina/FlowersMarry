//
//  FMChooseMusicModel.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/11/7.
//  Copyright © 2018 宁小陌. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class MusicModel;
@interface FMChooseMusicModel : NSObject
/// 状态 success/failed
@property (nonatomic, copy) NSString *status;
/// 错误码
@property (nonatomic, assign) NSInteger errcode;
///     "sid": "got8at6g7t6v2o0mlbsq1lvp71"
@property (nonatomic, copy) NSString *sid;
/// 文字提示
@property (nonatomic, copy) NSString *message;

@property (nonatomic, strong) NSMutableArray<MusicModel *> *data;
@end

@interface MusicModel : NSObject
//// 音乐id
@property (nonatomic, copy) NSString *kid;
/// 音乐名称
@property (nonatomic, copy) NSString *musicName;
/// 音乐URL
@property (nonatomic, copy) NSString *musicURL;
/// 音乐z后缀
@property (nonatomic, copy) NSString *musicExt;
@end

NS_ASSUME_NONNULL_END
