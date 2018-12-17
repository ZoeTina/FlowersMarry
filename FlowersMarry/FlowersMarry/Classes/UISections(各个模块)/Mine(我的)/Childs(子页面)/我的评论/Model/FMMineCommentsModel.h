//
//  FMMineCommentsModel.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/16.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MineCommentsModel,MineCommentsListModel,MineCommentsFeedModel,MineCommentsReplyModel,MineLikeBusinessAuth;
@interface FMMineCommentsModel : NSObject
/// 状态 success/failed
@property (nonatomic, copy) NSString *status;
/// 错误码
@property (nonatomic, assign) NSInteger errcode;
///     "sid": "got8at6g7t6v2o0mlbsq1lvp71"
@property (nonatomic, copy) NSString *sid;
/// 文字提示
@property (nonatomic, copy) NSString *message;

@property (nonatomic, strong) MineCommentsModel *data;
@end

@interface MineCommentsModel : NSObject

@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) NSMutableArray<MineCommentsListModel *> *list;
@end

@interface MineCommentsListModel : NSObject
/// 评论ID
@property (nonatomic, assign) NSInteger kid;
/// 信息编号
@property (nonatomic, assign) NSInteger feed_id;
/// 商家ID
@property (nonatomic, assign) NSInteger cp_id;
/// 评论内容
@property (nonatomic, copy) NSString *content;
/// 评论时间
@property (nonatomic, copy) NSString *create_time;
/// 是否有回复 0：没回复 1：有回复
@property (nonatomic, assign) NSInteger cp_isreply;
/// create_at
@property (nonatomic, copy) NSString *create_at;
/// 商家logo
@property (nonatomic, copy) NSString *cp_logo;
/// 商家名称
@property (nonatomic, copy) NSString *cp_fullname;
/// 商家简称
@property (nonatomic, copy) NSString *cp_shortname;
/// 是否关注
@property (nonatomic, assign) NSInteger is_follow;
/// 区域名称
@property (nonatomic, copy) NSString *qu_name;
/// 分类ID
@property (nonatomic, copy) NSString *channel_id;
/// 分类名称
@property (nonatomic, copy) NSString *channel_name;
/// 认证信息
@property (nonatomic, strong) MineLikeBusinessAuth *auth;

/// 动态信息
@property (nonatomic, strong) MineCommentsFeedModel *feed;
/// 回复内容
@property (nonatomic, strong) NSMutableArray<MineCommentsReplyModel *> *reply;


/// 状态 0:待审核 1:已通过 2:拒绝 3:管理员关闭 4:已过期 5:待上线 9:回收站 10:草稿 11:修改后提交 12:结束 13:商家关闭 21:商家的商铺关闭
@property (nonatomic, assign) NSInteger status;
/// 显示标识 1:显示,0:不显示
@property (nonatomic, assign) NSInteger visible;
/// 更新时间
@property (nonatomic, copy) NSString *ct_time;
/// 评论人id
@property (nonatomic, assign) NSInteger ct_uid;
/// 评论人姓名
@property (nonatomic, copy) NSString *ct_username;
/// 商家是否回复 0:未回复 1:已回复
@property (nonatomic, assign) NSInteger isReply;
/// 头像
@property (nonatomic, copy) NSString *avatar;

@end

@interface MineCommentsFeedModel : NSObject

@property (nonatomic, assign) NSInteger kid;
/// 标题
@property (nonatomic, copy) NSString *title;
/// 归属商家(id)
@property (nonatomic, assign) NSInteger cp_id;
/// 内容类型 (1:图文 2:图集 3:视频）
@property (nonatomic, assign) NSInteger shape;
/// 缩略图数量
@property (nonatomic, assign) NSInteger thumb_num;
/// 缩略图1
@property (nonatomic, copy) NSString *thumb1;
/// 缩略图2
@property (nonatomic, copy) NSString *thumb2;
/// 缩略图3
@property (nonatomic, copy) NSString *thumb3;
/// 图片数量
@property (nonatomic, assign) NSInteger gallery_num;
/// 评级
@property (nonatomic, copy) NSString *create_at;
@end

@interface MineCommentsReplyModel : NSObject
/// 商家ID
@property (nonatomic, copy) NSString *create_time;
/// 点评内容
@property (nonatomic, copy) NSString *content;
/// 更新时间
@property (nonatomic, copy) NSString *create_at;

@end

@interface MineLikeBusinessAuth : NSObject
/// 企业认证(1:是, 0:否)
@property (nonatomic, assign) NSInteger qy;
/// 个体认证(1:是, 0:否)
@property (nonatomic, assign) NSInteger gt;
/// 消保认证(1:是, 0:否)
@property (nonatomic, assign) NSInteger xb;
/// 广告商家(1:是, 0:否) 会员
@property (nonatomic, assign) NSInteger isavip;
@end
