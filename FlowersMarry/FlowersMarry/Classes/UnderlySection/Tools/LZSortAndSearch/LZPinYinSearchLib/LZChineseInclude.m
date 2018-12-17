//
//  LZChineseInclude.m
//  LZExtension
//
//  Created by 寕小陌 on 2017/7/20.
//  Copyright © 2016年 寕小陌. All rights reserved.
//

#import "LZChineseInclude.h"

@implementation LZChineseInclude
+ (BOOL)isIncludeChineseInString:(NSString*)str {
    for (int i=0; i<str.length; i++) {
        unichar ch = [str characterAtIndex:i];
        if (0x4e00 < ch  && ch < 0x9fff) {
            return true;
        }
    }
    return false;
}
@end
