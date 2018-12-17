//
//  FMCombinationDetailsModel.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/27.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CombinationDetailsModel,CombinationDetailsMetaModel,CombinationDetailsMetaChildrenModel,
CombinationDetailsPhotoInfoGroupModel,CombinationDetailsPhotoInfoModel,
CombinationDetailsPhotoModel,CombinationDetailsContentModel;
@interface FMCombinationDetailsModel : NSObject

/// 状态 success/failed
@property (nonatomic, copy) NSString *status;
/// 错误码
@property (nonatomic, assign) NSInteger errcode;
///     "sid": "got8at6g7t6v2o0mlbsq1lvp71"
@property (nonatomic, copy) NSString *sid;
/// 文字提示
@property (nonatomic, copy) NSString *message;
/// 实景列表数据
@property (nonatomic, strong) CombinationDetailsModel *data;

@end


@interface CombinationDetailsModel : NSObject
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
/// 1:婚纱 2:婚庆 3:婚宴
@property (nonatomic, assign) NSInteger channel_id;
/// 小分类ID
@property (nonatomic, assign) NSInteger class_id;
/// 拍摄地点编号
@property (nonatomic, assign) NSInteger place_id;
///
@property (nonatomic, copy) NSString *tx_add_time;
/// 拍摄地点名称
@property (nonatomic, copy) NSString *place_name;
///
@property (nonatomic, copy) NSString *add_time_tips;
/// 是否关注了当前商家
@property (nonatomic, assign) BOOL is_follow;

/// 属性   婚纱影楼 摄影工作室 儿童摄影 婚礼策划 婚纱礼服 有属性
@property (nonatomic, strong) NSMutableArray<CombinationDetailsMetaModel *> *meta;
///
@property (nonatomic, strong) CombinationDetailsPhotoInfoModel *photo_info;
///
@property (nonatomic, strong) NSMutableArray<CombinationDetailsPhotoModel *> *photo;
@property (nonatomic, strong) NSMutableArray<CombinationDetailsContentModel *> *tx_content;

@end

@interface CombinationDetailsPhotoInfoModel : NSObject

@property (nonatomic, strong) CombinationDetailsPhotoInfoGroupModel *zx_num;
@property (nonatomic, strong) CombinationDetailsPhotoInfoGroupModel *ps_pszs;
@property (nonatomic, strong) CombinationDetailsPhotoInfoGroupModel *ps_jxzs;
@property (nonatomic, strong) CombinationDetailsPhotoInfoGroupModel *cp_xcnum;

@end


@interface CombinationDetailsPhotoInfoGroupModel : NSObject

/// 标题
@property (nonatomic, strong) NSString *name;
/// 值
@property (nonatomic, strong) NSString *value;

@end

@interface CombinationDetailsContentModel : NSObject

/// 标题
@property (nonatomic, strong) NSString *type;
/// 值
@property (nonatomic, strong) NSString *src;

@end


@interface CombinationDetailsPhotoModel : NSObject
//// id
@property (nonatomic, assign) NSInteger kid;
/// 套餐id
@property (nonatomic, assign) NSInteger tx_id;
/// 图片url
@property (nonatomic, copy) NSString *p_filename;
/// 图片标题
@property (nonatomic, copy) NSString *p_filetitle;
/// 排序
@property (nonatomic, assign) NSInteger p_sort;
@end

@interface CombinationDetailsMetaModel : NSObject
/// 标题
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSMutableArray<CombinationDetailsMetaChildrenModel *> *children;

@end

@interface CombinationDetailsMetaChildrenModel : NSObject
/// 标题
@property (nonatomic, copy) NSString *title;
/// 副标题
@property (nonatomic, copy) NSString *value;
/// 单位
@property (nonatomic, copy) NSString *unit;
@end

