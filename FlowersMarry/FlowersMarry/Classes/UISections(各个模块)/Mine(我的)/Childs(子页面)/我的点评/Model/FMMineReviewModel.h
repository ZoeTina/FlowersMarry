//
//  FMMineReviewModel.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/16.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MineReviewModel,MineReviewListModel,MineBusinessAuth,MineCommentPhotoModel;
@interface FMMineReviewModel : NSObject
+ (NSMutableArray *)getModelData;

/// 状态 success/failed
@property (nonatomic, copy) NSString *status;
/// 错误码
@property (nonatomic, assign) NSInteger errcode;
///     "sid": "got8at6g7t6v2o0mlbsq1lvp71"
@property (nonatomic, copy) NSString *sid;
/// 文字提示
@property (nonatomic, copy) NSString *message;

@property (nonatomic, strong) MineReviewModel *data;
@end

@interface MineReviewModel : NSObject

@property (nonatomic, strong) NSMutableArray<MineReviewListModel *> *list;
@property (nonatomic, assign) NSInteger count;

@end

@interface MineReviewListModel : NSObject
/// 评论编号
@property (nonatomic, assign) NSInteger ct_id;
/// 商家编号
@property (nonatomic, assign) NSInteger cp_id;
/// 评论级别 10:力荐 8：推荐 6：还行 4：较差 2：很差
@property (nonatomic, assign) CGFloat ct_level;
/// level_text
@property (nonatomic, copy) NSString *user_id;
/// 评论人编号
@property (nonatomic, copy) NSString *level_text;
/// 评论人用户名
@property (nonatomic, copy) NSString *user_name;
/// 状态 0:待审核 1:已通过 2:拒绝 3:管理员关闭 4:已过期 5:待上线 9:回收站 10:草稿 11:修改后提交 12:结束 13:商家关闭 21:商家的商铺关闭
@property (nonatomic, assign) NSInteger ct_status;
/// 状态 0:待审核 1:已通过 2:拒绝 3:管理员关闭 4:已过期 5:待上线 9:回收站 10:草稿 11:修改后提交 12:结束 13:商家关闭 21:商家的商铺关闭
@property (nonatomic, copy) NSString *status_text;

/// 分类标签名称
@property (nonatomic, copy) NSString *channel_name;
/// 回复时间
@property (nonatomic, copy) NSString *ct_re_time;
/// 是否回复 0:否 1:是
@property (nonatomic, assign) NSInteger ct_isreply;
/// 创建时间
@property (nonatomic, copy) NSString *ct_add_time;
///
@property (nonatomic, copy) NSString *reply_at;
///
@property (nonatomic, copy) NSString *create_at;
/// 评论内容
@property (nonatomic, copy) NSString *ct_content;

/// 商家回复内容
@property (nonatomic, copy) NSString *ct_re_content;

/// 图片
@property (nonatomic, strong) NSMutableArray<MineCommentPhotoModel *> *photo;

/// 图片数量
@property (nonatomic,  copy) NSString *ct_photonum;
/// 商家logo
@property (nonatomic, copy) NSString *cp_logo;
/// 商家全称
@property (nonatomic, copy) NSString *cp_fullname;
/// 商家简称
@property (nonatomic, copy) NSString *cp_shortname;
/// 区域名称
@property (nonatomic, copy) NSString *qu_name;
/// 是否关注
@property (nonatomic, assign) NSInteger is_follow;
/// 认证体系
@property (nonatomic, strong) MineBusinessAuth *auth;
/// 用户头像
@property (nonatomic, copy) NSString *avatar;

@end

@interface MineBusinessAuth : NSObject
/// 企业认证(1:是, 0:否)
@property (nonatomic, assign) NSInteger qy;
/// 个体认证(1:是, 0:否)
@property (nonatomic, assign) NSInteger gt;
/// 消保认证(1:是, 0:否)
@property (nonatomic, assign) NSInteger xb;
/// 广告商家(1:是, 0:否) 会员
@property (nonatomic, assign) NSInteger isavip;
@end

@interface MineCommentPhotoModel : NSObject
@property (nonatomic, assign) NSInteger kid;
@property (nonatomic, copy) NSString *p_filename;
@property (nonatomic, copy) NSString *p_filetitle;
@end


