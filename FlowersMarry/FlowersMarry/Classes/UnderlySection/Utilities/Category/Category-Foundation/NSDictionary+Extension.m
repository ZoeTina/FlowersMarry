//
//  NSDictionary+Extension.m
//  LZExtension
//
//  Created by 寕小陌 on 2016/12/12.
//  Copyright © 2016年 寕小陌. All rights reserved.
//

#import "NSDictionary+Extension.h"

@implementation NSDictionary (Extension)

- (id _Nonnull)lz_objectForKey:(NSString *_Nonnull)key {
    if ([self isKindOfClass:[NSDictionary class]]){
        if ([self.allKeys containsObject:key]) {
            return [self objectForKey:key];
        }else{
            return nil;
        }
    }else {
        return nil;
    }
}

- (id _Nonnull)lz_getValue:(NSString *_Nonnull)key as:(Class _Nonnull)type {
    id value = [self objectForKey:key];
    
    // 类型一样，直接返回
    if ([value isKindOfClass:type]) {
        return value;
    }
    
    // 如果目标是number
    if (type == [NSNumber class] && [value isKindOfClass:[NSString class]]) {
        NSString *string = value;
        if ([string isEqualToString:@"true"]) {
            return @YES;
        }
        if ([string isEqualToString:@"no"]) {
            return @NO;
        }
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        return [formatter numberFromString:string];
    }
    
    // 如果目标是string
    if (type == [NSString class] && [value isKindOfClass:[NSNumber class]]) {
        return [value description];
    }
    if (type == [NSMutableString class]) {
        if ([value isKindOfClass:[NSNumber class]]) {
            return [[value description] mutableCopy];
        } else if ([value isKindOfClass:[NSString class]]) {
            return [value mutableCopy];
        }
    }
    
    // 如果目标是array
    if (type == [NSArray class] && [value isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dict = (NSDictionary *)value;
        return dict.allValues;
    }
    if (type == [NSMutableArray class]) {
        if ([value isKindOfClass:[NSDictionary class]]) {
            NSDictionary *dict = (NSDictionary *)value;
            return [dict.allValues mutableCopy];
        } else if ([value isKindOfClass:[NSDictionary class]]) {
            return [value mutableCopy];
        }
    }
    
    // 如果目标是dictionary
    if ((type == [NSDictionary class] || type == [NSMutableDictionary class]) && [value isKindOfClass:[NSArray class]]) {
        NSArray *array = (NSArray *)value;
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        for (id item in array) {
            if ([item isKindOfClass:[NSNumber class]]) {
                [dict setObject:item forKey:[item description]];
            } else {
                [dict setObject:item forKey:item];
            }
        }
        return dict;
    }
    
    return nil;
}

- (id _Nonnull)lz_getValue:(NSString *_Nonnull)key
                        as:(Class _Nonnull)type
              defaultValue:(id _Nonnull)defaultValue {
    id result = [self lz_getValue:key as:type];
    if (!result) {
        result = defaultValue;
    }
    
    return result;
}

- (NSString *_Nonnull)lz_descriptionWithLocale:(id _Nonnull)locale {
    NSMutableString *strM = [NSMutableString stringWithString:@"{\n"];
    
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [strM appendFormat:@"\t%@ = %@;\n", key, obj];
    }];
    
    [strM appendString:@"}\n"];
    
    return strM;
}

- (NSString * _Nonnull)lz_dictionaryToJSON {
    return [NSDictionary lz_dictionaryToJSON:self];
}

+ (NSString * _Nonnull)lz_dictionaryToJSON:(NSDictionary * _Nonnull)dictionary {
    NSString *json = nil;
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:&error];
    
    if (!jsonData) {
        return @"{}";
    } else if (!error) {
        json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        return json;
    } else {
        return error.localizedDescription;
    }
}

- (id _Nullable)lz_safeObjectForKey:(NSString * _Nonnull )key {
    NSArray *keysArray = [self allKeys];
    if ([keysArray containsObject:key]) {
        return [self objectForKey:key];
    } else {
        return nil;
    }
}

@end
