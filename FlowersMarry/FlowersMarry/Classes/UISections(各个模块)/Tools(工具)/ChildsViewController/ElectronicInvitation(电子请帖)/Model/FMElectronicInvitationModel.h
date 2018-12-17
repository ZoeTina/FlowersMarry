//
//  FMElectronicInvitationModel.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/11/2.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class InvitationListModel,InvitationModel;
@interface FMElectronicInvitationModel : NSObject
/// 状态 success/failed
@property (nonatomic, copy) NSString *status;
/// 错误码
@property (nonatomic, assign) NSInteger errcode;
///     "sid": "got8at6g7t6v2o0mlbsq1lvp71"
@property (nonatomic, copy) NSString *sid;
/// 文字提示
@property (nonatomic, copy) NSString *message;

@property (nonatomic, strong) InvitationListModel *data;
@end

@interface InvitationListModel : NSObject

@property (nonatomic, copy) NSString *replyCount;
@property (nonatomic, strong) NSMutableArray<InvitationModel *> *lists;

@end

@interface InvitationModel : NSObject
@property (nonatomic, copy) NSString *kid;
/// 图片URL
@property (nonatomic, copy) NSString *thumb;
/// 模板HTML地址
@property (nonatomic, copy) NSString *url;
@end


@interface InvitationTemplateModel : NSObject
/// 状态 success/failed
@property (nonatomic, copy) NSString *status;
/// 错误码
@property (nonatomic, assign) NSInteger errcode;
///     "sid": "got8at6g7t6v2o0mlbsq1lvp71"
@property (nonatomic, copy) NSString *sid;
/// 文字提示
@property (nonatomic, strong) NSMutableArray<InvitationModel *> *lists;

@end

NS_ASSUME_NONNULL_END
