//
//  NSString+URL.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/11/30.
//  Copyright © 2018 宁小陌. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (URL)
/**
 *  中文转义
 *
 *  @return 转以后的字符
 */
+ (NSString *) URLEncodedString:(NSString *) string;
@end

NS_ASSUME_NONNULL_END
