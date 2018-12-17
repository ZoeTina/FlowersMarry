//
//  LZPinYinForObjc.h
//  LZExtension
//
//  Created by 寕小陌 on 2017/7/20.
//  Copyright © 2016年 寕小陌. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LZHanyuPinyinOutputFormat.h"
#import "LZPinyinHelper.h"

@interface LZPinYinForObjc : NSObject

+ (NSString*)chineseConvertToPinYin:(NSString*)chinese;//转换为拼音
+ (NSString*)chineseConvertToPinYinHead:(NSString *)chinese;//转换为拼音首字母
@end
