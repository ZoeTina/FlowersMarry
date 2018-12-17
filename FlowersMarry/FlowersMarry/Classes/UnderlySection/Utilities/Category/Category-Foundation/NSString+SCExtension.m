//
//  NSString+SCExtension.m
//  LZExtension
//
//  Created by 宁小陌 on 2018/8/1.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "NSString+SCExtension.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation NSString (SCExtension)
- (NSString *)sc_documentDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:self];
}

- (NSString *)sc_cacheDirecotry {
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:self];
}

- (NSString *)sc_tmpDirectory {
    return [NSTemporaryDirectory() stringByAppendingPathComponent:self];
}

- (NSString *)sc_base64encode {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    
    return [data base64EncodedStringWithOptions:0];
}

- (NSString *)sc_base64decode {
    NSData *data = [[NSData alloc] initWithBase64EncodedString:self options:0];
    
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

#pragma mark - 散列函数
- (NSString *)sc_md5String {
    const char *str = self.UTF8String;
    uint8_t buffer[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(str, (CC_LONG)strlen(str), buffer);
    
    return [self stringFromBytes:buffer length:CC_MD5_DIGEST_LENGTH];
}

/**
 *  返回二进制 Bytes 流的字符串表示形式
 *
 *  @param bytes  二进制 Bytes 数组
 *  @param length 数组长度
 *
 *  @return 字符串表示形式
 */
- (NSString *)stringFromBytes:(uint8_t *)bytes length:(int)length {
    NSMutableString *stringM = [NSMutableString string];
    
    for (int i = 0; i < length; i++) {
        [stringM appendFormat:@"%02x", bytes[i]];
    }
    
    return stringM.copy;
}


//网络地址转义
- (NSString *)sc_urlString{
    return [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
}

//string为空的时候的处理
+ (NSString *)sc_stringWhenNil:(NSString *)string{
    if (string.length < 1) {
        return @"";
    }
    return string;
}

//存储
+ (void)sc_setObject:(NSString *)string   key:(NSString *)keyString{
    if (string.length < 1) {
        return ;
    }
    [[NSUserDefaults standardUserDefaults] setObject:string forKey:keyString];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

//取值
+ (NSString *)sc_stringForKey:(NSString *)keyStrng{
    
    return [[NSUserDefaults standardUserDefaults] objectForKey:keyStrng];
}
//删除
+ (void)sc_removeObjectForKey:(NSString *)keyString{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:keyString];
}
-(NSString*)transformationStringToSimplify{
    if (self.length == 0 || !self) {
        return 0;
    }
    if (self.integerValue < 10000) {
        return self;
    }
    return [NSString stringWithFormat:@"%.1f w",self.floatValue/10000];
}


//获取到分页的url
- (NSString *_Nullable)sc_urlStringWithIndex:(NSInteger)pageIndex {
    if (pageIndex <= 0) {
        return self;
    }
    if ([self rangeOfString:@"json"].location == NSNotFound) {
        return @"";
    }
    
    if (![self containsString:@"json"]) {
        return  self;
    }
    return  [self stringByReplacingOccurrencesOfString:@".json" withString:[NSString stringWithFormat:@"_%zd.json",pageIndex]];
}

- (NSString *_Nullable)sc_abandonCharacterWithCharacterArray:(NSArray *_Nullable)characterArray {
    NSMutableString *responseString = [NSMutableString stringWithString:self];
    NSString *character = nil;
    for (NSString *characterStr in characterArray) {
        
        for (int i = 0; i < responseString.length; i ++) {
            character = [responseString substringWithRange:NSMakeRange(i, 1)];
            if ([character isEqualToString:characterStr]) {
                [responseString deleteCharactersInRange:NSMakeRange(i, 1)];
            }
            
            //        if ([character isEqualToString:@"\r"]) {
            //            [responseString deleteCharactersInRange:NSMakeRange(i, 1)];
            //        }
        }
    }
    return responseString;
}

+ (NSString *_Nullable)getHHMMSSFromSS:(NSInteger)totalTime {
    NSInteger seconds = totalTime;
    
    //format of hour
    NSString *str_hour = [NSString stringWithFormat:@"%02ld",seconds/3600];
    //format of minute
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(seconds%3600)/60];
    //format of second
    NSString *str_second = [NSString stringWithFormat:@"%02ld",seconds%60];
    //format of time
    NSString *format_time = [NSString stringWithFormat:@"%@:%@:%@",str_hour,str_minute,str_second];
    
    return format_time;
}
+ (NSString *_Nullable)getMMSSFromSS:(NSInteger)totalTime {
    NSInteger seconds = totalTime;
    
    //format of minute
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",seconds/60];
    //format of second
    NSString *str_second = [NSString stringWithFormat:@"%02ld",seconds%60];
    //format of time
    NSString *format_time = [NSString stringWithFormat:@"%@:%@",str_minute,str_second];
    
    NSLog(@"format_time : %@",format_time);
    
    return format_time;
}

+ (NSString *_Nullable)getIntervalWithTimeStr:(NSString *_Nullable)timeStr {
    NSArray *array = [timeStr componentsSeparatedByString:@":"]; //从字符A中分隔成2个元素的数组
    NSInteger zonghms = 0;
    if (array.count == 3) {
        NSString *HH = [array lz_safeObjectAtIndex:0];
        NSString *MM= [array lz_safeObjectAtIndex:1];
        NSString *ss = [array lz_safeObjectAtIndex:2];
        NSInteger h = [HH integerValue];
        NSInteger m = [MM integerValue];
        NSInteger s = [ss integerValue];
        zonghms = h*3600 + m*60 +s;
    }
    if (array.count == 2) {
        
        NSString *MM= [array lz_safeObjectAtIndex:0];
        NSString *ss = [array lz_safeObjectAtIndex:1];
        
        NSInteger m = [MM integerValue];
        NSInteger s = [ss integerValue];
        zonghms = m*60 +s;
    }
    
    if (array.count == 1) {
        NSString *ss = [array lz_safeObjectAtIndex:0];
        NSInteger s = [ss integerValue];
        zonghms = s;
    }
    //需要的在转 NSString类型
    NSString *stringInt = [NSString stringWithFormat:@"%ld",(long)zonghms];//转字符串
    return stringInt;
}

+ (NSString *_Nullable)finddocumentpath{
    //寻找documents路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *value = paths.lastObject;
    return value;
}
@end
