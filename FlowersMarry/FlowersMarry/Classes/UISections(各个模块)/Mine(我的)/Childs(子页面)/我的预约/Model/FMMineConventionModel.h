//
//  FMMineConventionModel.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/13.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ConventionListData,ConventionData;
@interface FMMineConventionModel : NSObject

/// 状态 success/failed
@property (nonatomic, copy) NSString *status;
/// 错误码
@property (nonatomic, assign) NSInteger errcode;
///     "sid": "got8at6g7t6v2o0mlbsq1lvp71"
@property (nonatomic, copy) NSString *sid;
/// 文字提示
@property (nonatomic, copy) NSString *message;

@property (nonatomic, strong) ConventionData *data;

@end

@interface ConventionData : NSObject

@property (nonatomic, assign) NSInteger count;
@property (nonatomic, strong) NSMutableArray<ConventionListData *> *list;

@end

@interface ConventionListData : NSObject

/// 预约id
@property(nonatomic, assign) NSInteger ap_id;
/// 商家ID
@property(nonatomic, assign) NSInteger cp_id;
/// 商家电话
@property(nonatomic, copy)NSString* ap_phone;
/// 0:等待商家确认 1：商家确认完成 2:关闭 9:回收站
@property(nonatomic, assign) NSInteger ap_status;
/// 添加时间(预约时间)
@property(nonatomic, copy)NSString* add_time;
/// 商家名称
@property(nonatomic, copy)NSString* cp_fullname;
/// 商家logo
@property(nonatomic, copy)NSString* cp_logo;
@end
