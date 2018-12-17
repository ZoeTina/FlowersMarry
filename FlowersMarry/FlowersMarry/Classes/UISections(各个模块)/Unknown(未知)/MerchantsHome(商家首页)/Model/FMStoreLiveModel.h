//
//  FMStoreLiveModel.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/26.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <Foundation/Foundation.h>

@class StoreLiveModel,StoreLiveListModel;
@interface FMStoreLiveModel : NSObject
/// 状态 success/failed
@property (nonatomic, copy) NSString *status;
/// 错误码
@property (nonatomic, assign) NSInteger errcode;
///     "sid": "got8at6g7t6v2o0mlbsq1lvp71"
@property (nonatomic, copy) NSString *sid;
/// 文字提示
@property (nonatomic, copy) NSString *message;
/// 实景列表数据
@property (nonatomic, strong) StoreLiveModel *data;
@end

@interface StoreLiveModel : NSObject

/// 数据总数值
@property (nonatomic, assign) NSInteger count;
/// 实景列表数据
@property (nonatomic, strong) NSMutableArray<StoreLiveListModel *> *list;
@end

@interface StoreLiveListModel : NSObject

/// 实景_ID
@property (nonatomic, copy) NSString *sj_id;
/// 实景_标题
@property (nonatomic, copy) NSString *sj_title;
/// 实景_图片
@property (nonatomic, copy) NSString *sj_thumb;
/// 实景_描述
@property (nonatomic, copy) NSString *sj_description;
/// 实景_图片数量
@property (nonatomic, copy) NSString *sj_filenum;
/// 实景_商家编号
@property (nonatomic, copy) NSString *cp_id;
/// 实景_点击量
@property (nonatomic, copy) NSString *sj_hits;
/// 实景_
@property (nonatomic, copy) NSString *channel_id;
/// 实景_
@property (nonatomic, copy) NSString *class_id;
/// 实景_站点ID
@property (nonatomic, copy) NSString *site_id;
/// 实景_创建时间
@property (nonatomic, copy) NSString *sj_create_time;
/// 实景_类型名称
@property (nonatomic, copy) NSString *type_name;
/// 实景_时间提示
@property (nonatomic, copy) NSString *create_time_tips;



@end
