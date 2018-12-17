//
//  PVUserModel.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/25.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "PVUserModel.h"
#import "SCLocalCacheTool.h"


static NSString *uid = @"uid";
static NSString *sid = @"sid";
static NSString *username = @"username";
static NSString *mobile = @"mobile";
static NSString *realname = @"realname";
static NSString *avatar = @"avatar";
static NSString *sex = @"sex";
static NSString *weday = @"weday";
static NSString *birthday = @"birthday";
static NSString *create_time = @"create_time";
static NSString *logintoken = @"logintoken";
static NSString *isLogin = @"isLogin";
static NSString *isBindTel = @"isBindTel";

static NSString *cityName = @"cityName";
static NSString *city_id = @"city_id";
static NSString *site_id = @"site_id";
static NSString *channel_id = @"channel_id";
static NSString *province_id = @"province_id";

static NSString *qqName = @"qqName";
static NSString *wechatName = @"wechatName";
static NSString *weiboName = @"weiboName";


static NSString *country = @"country";
static NSString *province = @"province";
static NSString *district = @"district";
static NSString *name = @"name";
static NSString *address = @"address";
static NSString *street = @"street";
static NSString *longitudeStr = @"longitude";
static NSString *latitudeStr = @"latitude";


@implementation PVUserDataModel

+ (NSDictionary *)objectClassInArray{
    return @{@"data" : [PVUserModel class]};
}

@end

@implementation PVUserModel

static PVUserModel *userModel = nil;
+ (instancetype)shared {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        userModel = [[PVUserModel alloc] init];
    });
    return userModel;
}

- (BOOL)isLogin{
    if (self.uid.length > 0) {
        return YES;
    }
    return NO;
}

- (BOOL)isBindTel{
    if (self.mobile.length > 0) {
        return YES;
    }
    return NO;
}

/**
 * 归档 将user对象保存到本地文件夹
 */
- (void)dump {
    NSString *userDataPath = [SCLocalCacheTool userDataDirectoryWithFileName:@"users"];
    [SCLocalCacheTool createUserLocalDirectory:userDataPath];
    NSString *userDataFile = [userDataPath stringByAppendingPathComponent:@"userInfo.dat"];
    
    BOOL b = [NSKeyedArchiver archiveRootObject:[PVUserModel shared] toFile:userDataFile];
    
    if (b) {
        MVLog(@"PVUserModel dump 成功");
    } else {
        MVLog(@"PVUserModel dump 失败");
    }
}

/**
 * 取档 从本地文件夹中获取user对象
 */
- (PVUserModel *)load {
    NSString *userDataPath = [SCLocalCacheTool userDataDirectoryWithFileName:@"users"];
    NSString *filePath = [userDataPath stringByAppendingPathComponent:@"userInfo.dat"];
    PVUserModel *user = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    
    if (user) {
        MVLog(@"SCSettingsModel load 成功");
        MVLog(@"userID:%@", [PVUserModel shared].uid);
    } else {
        MVLog(@"SCSettingsModel load 失败");
    }
    return user;
}

/// 从文件读取一个对象的时候会调用该方法，该方法用于描述如何读取保存在文件中的数据
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super init];
    if (self) {
        /// 解码并返回一个与给定键相关联的Object类型的值
        [PVUserModel shared].uid = [aDecoder decodeObjectForKey:uid];
        [PVUserModel shared].sid = [aDecoder decodeObjectForKey:sid];
        [PVUserModel shared].username = [aDecoder decodeObjectForKey:username];
        [PVUserModel shared].mobile = [aDecoder decodeObjectForKey:mobile];
        [PVUserModel shared].realname = [aDecoder decodeObjectForKey:realname];
        [PVUserModel shared].avatar = [aDecoder decodeObjectForKey:avatar];
        [PVUserModel shared].sex = [aDecoder decodeIntegerForKey:sex];
        [PVUserModel shared].weday = [aDecoder decodeObjectForKey:weday];
        [PVUserModel shared].birthday = [aDecoder decodeObjectForKey:birthday];
        [PVUserModel shared].create_time = [aDecoder decodeObjectForKey:create_time];
        [PVUserModel shared].logintoken = [aDecoder decodeObjectForKey:logintoken];
        
        /// 解码并返回一个与给定键相关联的Bool类型的值
        [PVUserModel shared].isLogin = [[aDecoder decodeObjectForKey:isLogin] boolValue];
        [PVUserModel shared].isBindTel = [[aDecoder decodeObjectForKey:isBindTel] boolValue];
        
        [PVUserModel shared].city_id = [aDecoder decodeObjectForKey:city_id];
        [PVUserModel shared].site_id = [aDecoder decodeObjectForKey:site_id];
        [PVUserModel shared].province_id = [aDecoder decodeObjectForKey:province_id];
        [PVUserModel shared].channel_id = [aDecoder decodeObjectForKey:channel_id];
        
        [PVUserModel shared].qqName = [aDecoder decodeObjectForKey:qqName];
        [PVUserModel shared].wechatName = [aDecoder decodeObjectForKey:wechatName];
        [PVUserModel shared].weiboName = [aDecoder decodeObjectForKey:weiboName];
        
        [PVUserModel shared].cityName = [aDecoder decodeObjectForKey:cityName];
        [PVUserModel shared].country = [aDecoder decodeObjectForKey:country];
        [PVUserModel shared].province = [aDecoder decodeObjectForKey:province];
        [PVUserModel shared].district = [aDecoder decodeObjectForKey:district];
        [PVUserModel shared].name = [aDecoder decodeObjectForKey:name];
        [PVUserModel shared].address = [aDecoder decodeObjectForKey:address];
        [PVUserModel shared].street = [aDecoder decodeObjectForKey:street];
        /// 解码并返回一个与给定键相关联的float类型的值
        [PVUserModel shared].longitude = [aDecoder decodeFloatForKey:longitudeStr];
        [PVUserModel shared].latitude = [aDecoder decodeFloatForKey:latitudeStr];

    }
    return self;
}

/// 将一个自定义归档时就会调用该方法，该方法用于描述如何存储自定义对象的属性
- (void)encodeWithCoder:(NSCoder *)aCoder{
    /// 将Object类型编码，使其与字符串类型的键相关联
    [aCoder encodeObject:[PVUserModel shared].uid forKey:uid];
    [aCoder encodeObject:[PVUserModel shared].sid forKey:sid];
    [aCoder encodeObject:[PVUserModel shared].username forKey:username];
    [aCoder encodeObject:[PVUserModel shared].mobile forKey:mobile];
    [aCoder encodeObject:[PVUserModel shared].realname forKey:realname];
    [aCoder encodeInteger:[PVUserModel shared].sex forKey:sex];
    [aCoder encodeObject:[PVUserModel shared].weday forKey:weday];
    [aCoder encodeObject:[PVUserModel shared].birthday forKey:birthday];
    [aCoder encodeObject:[PVUserModel shared].create_time forKey:create_time];
    [aCoder encodeObject:[PVUserModel shared].logintoken forKey:logintoken];
    /// 将BOOL类型编码，使其与字符串类型的键相关联
    [aCoder encodeBool:[NSNumber numberWithBool:[PVUserModel shared].isLogin] forKey:isLogin];
    [aCoder encodeBool:[NSNumber numberWithBool:[PVUserModel shared].isBindTel] forKey:isBindTel];
    
    [aCoder encodeObject:[PVUserModel shared].city_id forKey:city_id];
    [aCoder encodeObject:[PVUserModel shared].site_id forKey:site_id];
    [aCoder encodeObject:[PVUserModel shared].province_id forKey:province_id];
    [aCoder encodeObject:[PVUserModel shared].channel_id forKey:channel_id];
    
    [aCoder encodeObject:[PVUserModel shared].qqName forKey:qqName];
    [aCoder encodeObject:[PVUserModel shared].wechatName forKey:wechatName];
    [aCoder encodeObject:[PVUserModel shared].weiboName forKey:weiboName];
    
    
    [aCoder encodeObject:[PVUserModel shared].cityName forKey:cityName];
    [aCoder encodeObject:[PVUserModel shared].country forKey:country];
    [aCoder encodeObject:[PVUserModel shared].province forKey:province];
    [aCoder encodeObject:[PVUserModel shared].district forKey:district];
    [aCoder encodeObject:[PVUserModel shared].name forKey:name];
    [aCoder encodeObject:[PVUserModel shared].address forKey:address];
    [aCoder encodeObject:[PVUserModel shared].street forKey:street];
    /// 将float类型编码，使其与字符串类型的键相关联
    [aCoder encodeFloat:[PVUserModel shared].longitude forKey:longitudeStr];
    [aCoder encodeFloat:[PVUserModel shared].latitude forKey:latitudeStr];
    
}

/**
 * 清空数据
 */
- (void)logout {
    [PVUserModel shared].uid = @"";
    [PVUserModel shared].username = @"";
    [PVUserModel shared].mobile = @"";
    [PVUserModel shared].realname = @"";
    [PVUserModel shared].avatar = @"";
//    [PVUserModel shared].sex = @5;
    [PVUserModel shared].weday = @"";
    [PVUserModel shared].create_time = @"";
    [PVUserModel shared].isLogin = NO;
    [PVUserModel shared].isBindTel = NO;
    
    [PVUserModel shared].city_id = @"";
    [PVUserModel shared].site_id = @"";
    [PVUserModel shared].province_id = @"";
    [PVUserModel shared].channel_id = @"";
    
    
    [PVUserModel shared].cityName = @"";
    [PVUserModel shared].country = @"";
    [PVUserModel shared].province = @"";
    [PVUserModel shared].district = @"";
    [PVUserModel shared].name = @"";
    [PVUserModel shared].address = @"";
    [PVUserModel shared].street = @"";
    [PVUserModel shared].longitude = 0.0;
    [PVUserModel shared].latitude = 0.0;
}
@end

