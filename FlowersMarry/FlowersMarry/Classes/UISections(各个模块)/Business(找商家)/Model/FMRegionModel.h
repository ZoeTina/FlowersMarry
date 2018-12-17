//
//  FMRegionModel.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/23.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RegionModel;
@interface FMRegionModel : NSObject

@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *errcode;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, strong) NSMutableArray<RegionModel *> *data;

@end

@interface RegionModel : NSObject
/// 详细地址
@property (nonatomic, copy) NSString *cid;
/// 街道
@property (nonatomic, copy) NSString *name;
/// 城市
@property (nonatomic, copy) NSString *enname;
@end

