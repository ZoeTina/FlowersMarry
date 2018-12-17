//
//  FMCommentsDynamicModel.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/8/8.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CommentsDynamicModel,CommentsDynamicListModel,CommentsDynamicReplyModel;
@interface FMCommentsDynamicModel : NSObject
/// 状态 success/failed
@property (nonatomic, copy) NSString *status;
/// 错误码
@property (nonatomic, assign) NSInteger errcode;
///     "sid": "got8at6g7t6v2o0mlbsq1lvp71"
@property (nonatomic, copy) NSString *sid;
/// 文字提示
@property (nonatomic, copy) NSString *message;

@property (nonatomic, strong) CommentsDynamicModel *data;
@end

@interface CommentsDynamicModel : NSObject
/// 总评论数
@property (nonatomic, copy) NSString *totalCount;
/// 评论列表
@property (nonatomic, strong) NSMutableArray<CommentsDynamicListModel *> *info;
@end

@interface CommentsDynamicListModel : NSObject
/// 动态id
@property (nonatomic, copy) NSString *feed_id;
/// 商家id
@property (nonatomic, copy) NSString *cp_id;
/// 点评内容
@property (nonatomic, copy) NSString *ct_content;
/// 显示标识 1:显示,0:不显示
@property (nonatomic, copy) NSString *visible;
/// 回复数量
@property (nonatomic, copy) NSString *reply_num;
/// 点评时间
@property (nonatomic, copy) NSString *ct_time;
/// 点评人用户id
@property (nonatomic, copy) NSString *ct_uid;
/// 点评人姓名
@property (nonatomic, copy) NSString *ct_username;
/// 商家是否回复
@property (nonatomic, copy) NSString *cp_isreply;
/// 用户头像
@property (nonatomic, copy) NSString *avatar;
/// 回复内容
@property (nonatomic, strong) NSMutableArray<CommentsDynamicReplyModel *> *reply;


@end

@interface CommentsDynamicReplyModel : NSObject
/// 回复ID
@property (nonatomic, copy) NSString *kid;
/// 商家编号
@property (nonatomic, copy) NSString *cp_id;
/// 点评内容
@property (nonatomic, copy) NSString *ct_re_content;
/// 回复时间
@property (nonatomic, copy) NSString *create_time;
/// 更新时间
@property (nonatomic, copy) NSString *ct_re_time;
@end
