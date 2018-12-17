//
//  FMChannelModel.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/8/13.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <Foundation/Foundation.h>


@class ChannelModel,ChannelChild;
@interface FMChannelModel : NSObject

@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *errcode;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, strong) NSMutableArray<ChannelModel *> *data;

@end

@interface ChannelModel : NSObject
/// 大分类编号
@property (nonatomic, copy) NSString *channel_id;
/// 大分类名称
@property (nonatomic, copy) NSString *name;
/// 英文名称
@property (nonatomic, copy) NSString *enname;
/// 小分类数组
@property (nonatomic, strong) NSMutableArray<ChannelChild *> *child;

@end

@interface ChannelChild : NSObject

/// 是否显示 0:不显示 1：显示
@property (nonatomic, assign) NSInteger is_show;
/// 小分类ID
@property (nonatomic, copy) NSString *class_id;
/// 小分类名称
@property (nonatomic, copy) NSString *class_name;
/// 小分类名称
@property (nonatomic, copy) NSString *class_enname;
@end
