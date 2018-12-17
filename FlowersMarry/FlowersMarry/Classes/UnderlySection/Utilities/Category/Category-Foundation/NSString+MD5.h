//
//  NSString+MD5.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/11/29.
//  Copyright © 2018 宁小陌. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (MD5)
/**
 *  md5加密的字符串
 *  str
 *  @return
 */
+ (NSString *) md5:(NSString *) str;
@end

NS_ASSUME_NONNULL_END
