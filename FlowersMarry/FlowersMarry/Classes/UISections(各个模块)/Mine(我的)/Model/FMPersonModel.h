//
//  FMPersonModel.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/4.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MineModel,MineMessageCount;
@interface FMPersonModel : NSObject
@property(nonatomic, copy)NSString* title;
@property(nonatomic, copy)NSString* subtitle;
@property(nonatomic, copy)NSString* content;
@property(nonatomic, copy)NSString* imageText;
@property(nonatomic, copy)NSString* showClass;
@property(nonatomic, assign)NSInteger index;
@end


@interface FMMineModel : NSObject

/// 状态 success/failed
@property (nonatomic, copy) NSString *status;
/// 错误码
@property (nonatomic, assign) NSInteger errcode;
///     "sid": "got8at6g7t6v2o0mlbsq1lvp71"
@property (nonatomic, copy) NSString *sid;
/// 文字提示
@property (nonatomic, copy) NSString *message;

@property (nonatomic, strong) MineModel *data;
@end

@interface MineModel : NSObject
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *realname;
@property (nonatomic, copy) NSString *avatar;
@property (nonatomic, copy) NSString *sex;
@property (nonatomic, copy) NSString *birthday;
@property (nonatomic, copy) NSString *weday;
@property (nonatomic, copy) NSString *lastlogin_time;
@property (nonatomic, copy) NSString *create_time;
@property (nonatomic, strong) MineMessageCount *count;

/// 平台消息数
@property (nonatomic, copy) NSString *message;

@end

@interface MineMessageCount : NSObject
/// 商家关注数
@property (nonatomic, copy) NSString *fllow;
/// 动态收藏数
@property (nonatomic, copy) NSString *feed_collect;
/// 动态评论数
@property (nonatomic, copy) NSString *feed_comment;
/// 预约数
@property (nonatomic, copy) NSString *yuyue;
/// 点评数
@property (nonatomic, copy) NSString *comment;

@end

@class ThirdModel;
@interface ThirdPartyModel : NSObject
/// 状态 success/failed
@property (nonatomic, copy) NSString *status;
/// 错误码
@property (nonatomic, assign) NSInteger errcode;
///     "sid": "got8at6g7t6v2o0mlbsq1lvp71"
@property (nonatomic, copy) NSString *sid;
/// 文字提示
@property (nonatomic, copy) NSString *message;

@property (nonatomic, strong) NSMutableArray<ThirdModel *> *data;
@end

@interface ThirdModel : NSObject
/// 平台
@property (nonatomic, copy) NSString *platform;
/// 点评数
@property (nonatomic, copy) NSString *nickname;
/// 绑定时间
@property (nonatomic, copy) NSString *create_time;
@end
