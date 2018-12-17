//
//  LZPinyinFormatter.h
//  LZExtension
//
//  Created by 寕小陌 on 2017/7/20.
//  Copyright © 2016年 寕小陌. All rights reserved.
//

#ifndef _LZPinyinFormatter_H_
#define _LZPinyinFormatter_H_
#import <Foundation/Foundation.h>
@class LZHanyuPinyinOutputFormat;

@interface LZPinyinFormatter : NSObject {
}

+ (NSString *)formatHanyuPinyinWithNSString:(NSString *)pinyinStr
                withHanyuPinyinOutputFormat:(LZHanyuPinyinOutputFormat *)outputFormat;
+ (NSString *)convertToneNumber2ToneMarkWithNSString:(NSString *)pinyinStr;
- (id)init;
@end

#endif // _LZPinyinFormatter_H_
