//
//  NSString+LZPinYin.h
//  LZExtension
//
//  Created by 寕小陌 on 2016/12/12.
//  Copyright © 2016年 寕小陌. All rights reserved.
//

#import <Foundation/Foundation.h>

/** 拼音扩展 */
@interface NSString (LZPinYin)
/**
 * 汉子转为拼音
 */
- (NSString*)lz_chineseStringTransformToPinYin;

/**
 *  获取汉字的首字的首字母大写
 *
 *  @return 汉字的首字的首字母大写
 */
- (NSString*)lz_fisrtUppercasePinYin;



/**
 *  是否包含中文
 *
 *  @return BOOL值
 */
- (BOOL)lz_isContainChinese;

@end
