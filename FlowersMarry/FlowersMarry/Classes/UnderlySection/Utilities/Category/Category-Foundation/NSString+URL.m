//
//  NSString+URL.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/11/30.
//  Copyright © 2018 宁小陌. All rights reserved.
//

#import "NSString+URL.h"

@implementation NSString (URL)
/**
 *  中文转义
 *
 *  @return 转以后的字符
 */
+ (NSString *) URLEncodedString:(NSString *) string{
    NSString *encodedString = [string stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    return encodedString;
}
@end
