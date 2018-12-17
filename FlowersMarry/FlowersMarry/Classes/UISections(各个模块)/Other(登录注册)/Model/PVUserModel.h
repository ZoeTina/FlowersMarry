//
//  PVUserModel.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/25.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PVUserModel;
@interface PVUserDataModel : NSObject
/// 状态 success/failed
@property (nonatomic, copy) NSString *status;
/// 错误码
@property (nonatomic, assign) NSInteger errcode;
///     "sid": "got8at6g7t6v2o0mlbsq1lvp71"
@property (nonatomic, copy) NSString *sid;
/// 文字提示
@property (nonatomic, copy) NSString *message;

@property (nonatomic, strong) PVUserModel *data;
@end

@interface PVUserModel : NSObject
/// 用户ID
@property (nonatomic, copy) NSString *uid;
/// 用户昵称
@property (nonatomic, copy) NSString *username;
/// 用户手机
@property (nonatomic, copy) NSString *mobile;
/// 用户真实姓名
@property (nonatomic, copy) NSString *realname;
/// 用户头像
@property (nonatomic, copy) NSString *avatar;
/// 用户性别(1：男 0：女)
@property (nonatomic, assign) NSInteger sex;
/// 婚期
@property (nonatomic, copy) NSString *weday;
/// 生日
@property (nonatomic, copy) NSString *birthday;
/// 用户注册日期时间
@property (nonatomic, copy) NSString *create_time;
/// 快捷登录验证码
@property (nonatomic, copy) NSString *logintoken;
@property (nonatomic, copy) NSString *sid;

/// QQ昵称
@property (nonatomic, copy) NSString *qqName;
/// 微信昵称
@property (nonatomic, copy) NSString *wechatName;
/// 微博昵称
@property (nonatomic, copy) NSString *weiboName;

/// 城市ID
@property (nonatomic, copy) NSString *city_id;
/// 省ID
@property (nonatomic, copy) NSString *province_id;
/// 站点编号
@property (nonatomic, copy) NSString *site_id;
/// 站点编号
@property (nonatomic, copy) NSString *channel_id;


/// 是否已绑定手机号（先判断是否绑定，如果已绑定 返回登录信息，未绑定 返回false，并跳转至绑定页）
@property (nonatomic, copy) NSString *isBindAccount;
/// 是否已绑定手机号（先判断是否绑定，如果已绑定 返回登录信息，未绑定 返回false，并跳转至绑定页）
@property (nonatomic, assign) BOOL isBindTel;
/// 新加的参数
@property (nonatomic, assign) BOOL isLogin; //是否登录

/************ 定位地址 ************/
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

+ (instancetype)shared;
/**
 * 归档 将user对象保存到本地文件夹
 */
- (void)dump;

/**
 * 取档 从本地文件夹中获取user对象
 */
- (PVUserModel *)load;

/**
 * 清空数据
 */
- (void)logout;


@end
