//
//  FMBasicInformationModel.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/11/8.
//  Copyright © 2018 宁小陌. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class BasicInformationModel;
@interface FMBasicInformationModel : NSObject
/// 状态 success/failed
@property (nonatomic, copy) NSString *status;
/// 错误码
@property (nonatomic, assign) NSInteger errcode;
///     "sid": "got8at6g7t6v2o0mlbsq1lvp71"
@property (nonatomic, copy) NSString *sid;
/// 文字提示
@property (nonatomic, copy) NSString *message;

@property (nonatomic, strong) BasicInformationModel *data;
@end

@interface BasicInformationModel : NSObject
/// 信息ID
@property (nonatomic, copy) NSString *kid;
/// 新郎姓名
@property (nonatomic, copy) NSString *man;
/// 新娘姓名
@property (nonatomic, copy) NSString *woman;
/// 手机号
@property (nonatomic, copy) NSString *mobile;
/// 是否开启弹幕(1:开启弹幕 0:关闭弹幕)
@property (nonatomic, assign) NSInteger barrage;
/// 音乐ID
@property (nonatomic, copy) NSString *music_id;
/// 婚礼日期
@property (nonatomic, copy) NSString *date;
/// 婚礼时间
@property (nonatomic, copy) NSString *time;
/// 婚礼地址
@property (nonatomic, copy) NSString *address;
/// 地图经纬度
@property (nonatomic, copy) NSString *map;
/// 缩略图
@property (nonatomic, copy) NSString *thumb;
/// 标签
@property (nonatomic, copy) NSString *tags;
/// 音乐名字
@property (nonatomic, copy) NSString *music_name;
@end

/************** 定位地址 **************/
@interface TencentMapModel : NSObject
/// 国家(中国)
@property (nonatomic, copy) NSString *country;
/// 省(四川省)
@property (nonatomic, copy) NSString *province;
/// 城市(成都市)
@property (nonatomic, copy) NSString *cityName;
/// 区/县(武侯区)
@property (nonatomic, copy) NSString *district;
/// 名字(天府三街74号)
@property (nonatomic, copy) NSString *name;
/// 街道(天府三街)
@property (nonatomic, copy) NSString *address;
/// 子街道(74号)
@property (nonatomic, copy) NSString *street;
/// 经度
@property (nonatomic, assign) float longitude;
/// 纬度
@property (nonatomic, assign) float latitude;
@end

NS_ASSUME_NONNULL_END
