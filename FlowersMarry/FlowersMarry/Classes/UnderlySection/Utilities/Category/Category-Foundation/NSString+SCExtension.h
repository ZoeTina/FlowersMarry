//
//  NSString+SCExtension.h
//  LZExtension
//
//  Created by 宁小陌 on 2018/8/1.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (SCExtension)
/// 拼接了`文档目录`的全路径
@property (nullable, nonatomic, readonly) NSString *sc_documentDirectory;
/// 拼接了`缓存目录`的全路径
@property (nullable, nonatomic, readonly) NSString *sc_cacheDirecotry;
/// 拼接了临时目录的全路径
@property (nullable, nonatomic, readonly) NSString *sc_tmpDirectory;

/// BASE 64 编码的字符串内容
@property(nullable, nonatomic, readonly) NSString *sc_base64encode;
/// BASE 64 解码的字符串内容
@property(nullable, nonatomic, readonly) NSString *sc_base64decode;

#pragma mark - 散列函数 Hash

/**
 *  计算MD5散列结果
 *
 *  终端测试命令：
 *  @code
 *  md5 -s "string"
 *  @endcode
 *
 *  <p>提示：随着 MD5 碰撞生成器的出现，MD5 算法不应被用于任何软件完整性检查或代码签名的用途。<p>
 *
 *  @return 32个字符的MD5散列字符串
 */
- (NSString *_Nullable)sc_md5String;

#pragma mark - TODO:

//网络地址转义
- (NSString *_Nullable)sc_urlString;

//string为空的时候的处理

+ (NSString *_Nullable)sc_stringWhenNil:(NSString *_Nonnull)string;

//存储
+ (void)sc_setObject:(NSString *_Nonnull)string   key:(NSString *_Nonnull)keyString;
//取值
+ (NSString *_Nullable)sc_stringForKey:(NSString *_Nonnull)keyStrng;
//删除
+ (void)sc_removeObjectForKey:(NSString *_Nonnull)keyString;
//点赞数，评论数上10000，转w
-(NSString*_Nullable)transformationStringToSimplify;

//获取分页url
- (NSString *_Nullable)sc_urlStringWithIndex:(NSInteger)pageIndex;

- (NSString *_Nullable)sc_abandonCharacterWithCharacterArray:(NSArray *_Nullable)characterArray;

//传入秒数得到hh:mm:ss
+ (NSString *_Nullable)getHHMMSSFromSS:(NSInteger)totalTime;
//传入秒数得到mm:ss
+ (NSString *_Nullable)getMMSSFromSS:(NSInteger)totalTime;
//寻找document路径
+ (NSString *_Nullable)finddocumentpath;
//根据时：分：秒得到秒数
+ (NSString *_Nullable)getIntervalWithTimeStr:(NSString *_Nullable)timeStr;
@end
