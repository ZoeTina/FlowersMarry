//
//  NSDictionary+Extension.h
//  LZExtension
//
//  Created by 寕小陌 on 2016/12/12.
//  Copyright © 2016年 寕小陌. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  此分类增加了一些关于NSDictionary的有用方法
 */
@interface NSDictionary (Extension)
- (id _Nonnull)lz_objectForKey:(NSString *_Nonnull)key;
- (id _Nonnull)lz_getValue:(NSString *_Nonnull)key
                        as:(Class _Nonnull)type;

- (id _Nonnull)lz_getValue:(NSString *_Nonnull)key
                        as:(Class _Nonnull)type
              defaultValue:(id _Nonnull)defaultValue;
- (NSString *_Nonnull)lz_descriptionWithLocale:(id _Nonnull)locale;

/**
 *  以NSString类型将字典本身转换为JSON
 *
 *  @return 返回NSString类型的JSON或者当解析错误时返回nil
 */
- (NSString * _Nonnull)lz_dictionaryToJSON;

/**
 *  将给出的字典转换为NSString类型的JSON
 *
 *  @param dictionary 需要被转换的字典
 *
 *  @return 返回NSString类型的JSON或者当解析错误时返回nil
 */
+ (NSString * _Nonnull)lz_dictionaryToJSON:(NSDictionary * _Nonnull)dictionary;

/**
 *  如果key存在返回对应的对象，否则返回nil
 *
 *  @param key 键值
 *
 *  @return Value值，否则nil
 */
- (id _Nullable)lz_safeObjectForKey:(NSString * _Nonnull)key;
@end
