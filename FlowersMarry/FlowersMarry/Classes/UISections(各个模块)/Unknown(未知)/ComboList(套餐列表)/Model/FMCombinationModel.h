//
//  FMCombinationModel.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/26.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CombinationDataModel,CombinationListModel;
@interface FMCombinationModel : NSObject

/// 状态 success/failed
@property (nonatomic, copy) NSString *status;
/// 错误码
@property (nonatomic, assign) NSInteger errcode;
///     "sid": "got8at6g7t6v2o0mlbsq1lvp71"
@property (nonatomic, copy) NSString *sid;
/// 文字提示
@property (nonatomic, copy) NSString *message;
/// 套餐列表数据
@property (nonatomic, strong) CombinationDataModel *data;

@end

@interface CombinationDataModel : NSObject
/// 数据总数值
@property (nonatomic, assign) NSInteger count;
/// 列表数据
@property (nonatomic, strong) NSMutableArray<CombinationListModel *> *list;
@end

@interface CombinationListModel : NSObject
/// 套餐ID
@property (nonatomic, assign) NSInteger tx_id;
/// 套餐标题
@property (nonatomic, copy) NSString *tx_title;
/// 套餐副标题
@property (nonatomic, copy) NSString *tx_subtitle;
/// 套餐点击量
@property (nonatomic, copy) NSString *tx_hits;
/// 套餐封面图
@property (nonatomic, copy) NSString *tx_thumb;
/// 套餐现价格
@property (nonatomic, copy) NSString *tx_price;
/// 套餐旧价格
@property (nonatomic, copy) NSString *tx_first_price;
/// 文件数量
@property (nonatomic, assign) NSInteger tx_filenum;
/// 商家ID
@property (nonatomic, assign) NSInteger cp_id;
/// 大分类编号
@property (nonatomic, assign) NSInteger channel_id;
/// 小分类编号
@property (nonatomic, assign) NSInteger class_id;
/// 拍摄地点名称
@property (nonatomic, copy) NSString *place_name;
/// 添加时间
@property (nonatomic, copy) NSString *tx_add_time;
@property (nonatomic, copy) NSString *place_id;
@property (nonatomic, copy) NSString *create_at;

@end
