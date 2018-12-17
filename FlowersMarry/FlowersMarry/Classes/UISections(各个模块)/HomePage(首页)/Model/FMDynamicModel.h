//
//  FMDynamicModel.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/23.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DynamicDataModel,DynamicModel,DynamicGalleryModel;
@interface FMDynamicModel : NSObject
/// 状态 success/failed
@property (nonatomic, copy) NSString *status;
/// 错误码
@property (nonatomic, assign) NSInteger errcode;
///     "sid": "got8at6g7t6v2o0mlbsq1lvp71"
@property (nonatomic, copy) NSString *sid;
/// 文字提示
@property (nonatomic, copy) NSString *message;

@property (nonatomic, strong) DynamicDataModel *data;
@end

@interface DynamicDataModel : NSObject

@property (nonatomic, strong) NSMutableArray<DynamicModel *> *list;

@property (nonatomic, assign) NSInteger totalCount;

@end

@interface DynamicModel : NSObject
/// 编号
@property (nonatomic, copy) NSString *kid;
/// 标题
@property (nonatomic, copy) NSString *title;
/// 商家编号
@property (nonatomic, copy) NSString *cp_id;
/// 站点编号
@property (nonatomic, copy) NSString *site_id;
/// 类型 (1:图文 2:图集 3:视频)
@property (nonatomic, assign) NSInteger shape;
/// 简介
@property (nonatomic, copy) NSString *intro;
/// 缩略图数量
@property (nonatomic, assign) NSInteger thumb_num;
/// 封面图1
@property (nonatomic, copy) NSString *thumb1;
/// 封面图2
@property (nonatomic, copy) NSString *thumb2;
/// 封面图3
@property (nonatomic, copy) NSString *thumb3;
/// 图集数量
@property (nonatomic, copy) NSString *gallery_num;
/// 点评数量
@property (nonatomic, copy) NSString *comment_num;
/// 收藏数量
@property (nonatomic, copy) NSString *collect_num;
/// 点击量
@property (nonatomic, copy) NSString *hits;
/// 创建时间
@property (nonatomic, copy) NSString *create_time;
/// 图集
@property (nonatomic, copy) NSString *shape_text;
/// 创建时间提示
@property (nonatomic, copy) NSString *create_at;
/// 商家logo
@property (nonatomic, copy) NSString *cp_logo;
/// 商家全称
@property (nonatomic, copy) NSString *cp_fullname;
/// 商家简称
@property (nonatomic, copy) NSString *cp_shortname;
/// 地区名字
@property (nonatomic, copy) NSString *qu_name;
/// 分类ID
@property (nonatomic, copy) NSString *channel_id;
/// 分类名字
@property (nonatomic, copy) NSString *channel_name;


///// --- end ---- /////


/// 图文需要用的文字提示
@property (nonatomic, copy) NSString *content;
/// 图文需要用的文字提示
@property (nonatomic, copy) NSString *link;
/// 图文需要用的文字提示
@property (nonatomic, copy) NSString *mlink;
/// 图文需要用的文字提示(0:未收藏 1:已收藏)
@property (nonatomic, assign) NSInteger is_collect;
/// 是否关注了当前商家(0:未关注 1:已关注)
@property (nonatomic, assign) NSInteger is_follow;
/// 站点名称
@property (nonatomic, copy) NSString *site_name;

@property (nonatomic, strong) BusinessAuthModel *auth;

@property (nonatomic, strong) NSMutableArray<DynamicModel *> *list;


////// --- end ---- //////

/// 图片集推荐和视频 列表
@property (nonatomic, strong) NSMutableArray<DynamicGalleryModel *> *gallery;


////// --- end ---- //////
@property (nonatomic, copy) NSString *videoURL;


@end


@interface DynamicGalleryModel : NSObject
/// 当前ID
@property (nonatomic, copy) NSString *kid;
/// 动态ID
@property (nonatomic, copy) NSString *feed_id;
/// 图片路径
@property (nonatomic, copy) NSString *path;
/// 编号
@property (nonatomic, copy) NSString *title;
/// 描述
@property (nonatomic, copy) NSString *k_description;
/// 排序
@property (nonatomic, copy) NSString *sort;

@end
