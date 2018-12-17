//
//  FMActivityModel.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/8/13.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ActivityModel,ActivityListModel;
@interface FMActivityModel : NSObject
/// 状态 success/failed
@property (nonatomic, copy) NSString *status;
/// 错误码
@property (nonatomic, assign) NSInteger errcode;
///     "sid": "got8at6g7t6v2o0mlbsq1lvp71"
@property (nonatomic, copy) NSString *sid;
/// 文字提示
@property (nonatomic, copy) NSString *message;
/// 实景列表数据
@property (nonatomic, strong) ActivityModel*data;
@end

@interface ActivityModel : NSObject

/// 数据总数值
@property (nonatomic, assign) NSInteger count;
/// 实景列表数据
@property (nonatomic, strong) NSMutableArray<ActivityListModel *> *list;
@end

@interface ActivityListModel : NSObject
/// 活动ID
@property (nonatomic, copy) NSString *hd_id;
/// 活动缩略图
@property (nonatomic, copy) NSString *hd_thumb;
/// 活动描述
@property (nonatomic, copy) NSString *hd_description;

@end
