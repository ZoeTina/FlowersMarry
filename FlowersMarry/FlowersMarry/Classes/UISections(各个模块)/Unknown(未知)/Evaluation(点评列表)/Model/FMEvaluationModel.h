//
//  FMEvaluationModel.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/8/18.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EvaluationDataModel,EvaluationModel,EvaluationPhotoModel;
@interface FMEvaluationModel : NSObject
/// 状态 success/failed
@property (nonatomic, copy) NSString *status;
/// 错误码
@property (nonatomic, assign) NSInteger errcode;
///     "sid": "got8at6g7t6v2o0mlbsq1lvp71"
@property (nonatomic, copy) NSString *sid;
/// 文字提示
@property (nonatomic, copy) NSString *message;
/// 实景列表数据
@property (nonatomic, strong) EvaluationDataModel *data;
@end


@interface EvaluationDataModel : NSObject

/// 数据总数值
@property (nonatomic, assign) NSInteger count;
/// 点评列表数据
@property (nonatomic, strong) NSMutableArray<EvaluationModel *> *list;
@end

@interface EvaluationModel : NSObject
/// 编号
@property (nonatomic, copy) NSString *ct_id;
/// 商家编号
@property (nonatomic, copy) NSString *cp_id;
/// 点评分数
@property (nonatomic, assign) CGFloat ct_level;
/// 点评人昵称
@property (nonatomic, copy) NSString *user_name;
/// 回复时间
@property (nonatomic, copy) NSString *ct_re_time;
/// 点评时间
@property (nonatomic, copy) NSString *ct_add_time;
/// 图片数量
@property (nonatomic, copy) NSString *ct_photonum;
/// 点评文本
@property (nonatomic, copy) NSString *level_text;
/// 评论时间提示
@property (nonatomic, copy) NSString *add_time_tips;
/// 回复时间提示
@property (nonatomic, copy) NSString *re_time_tips;
/// 头像
@property (nonatomic, copy) NSString *avatar;
/// 评论内容
@property (nonatomic, copy) NSString *ct_content;
/// 回复类容
@property (nonatomic, copy) NSString *ct_re_content;
/// 图片数组
@property (nonatomic, strong) NSMutableArray<EvaluationPhotoModel *> *photo;

@end

@interface EvaluationPhotoModel : NSObject
@property (nonatomic, copy) NSString *kid;
@property (nonatomic, copy) NSString *p_filename;
@property (nonatomic, copy) NSString *p_sort;
@property (nonatomic, copy) NSString *p_filetitle;

@end
