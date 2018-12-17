//
//  LZChineseToPinyinResource.h
//  LZExtension
//
//  Created by 寕小陌 on 2017/7/20.
//  Copyright © 2016年 寕小陌. All rights reserved.
//

#ifndef _LZChineseToPinyinResource_H_
#define _LZChineseToPinyinResource_H_
#import <Foundation/Foundation.h>
@class NSArray;
@class NSMutableDictionary;

@interface LZChineseToPinyinResource : NSObject {
    NSString* _directory;
    NSDictionary *_unicodeToHanyuPinyinTable;
}
//@property(nonatomic, strong)NSDictionary *unicodeToHanyuPinyinTable;

- (id)init;
- (void)initializeResource;
- (NSArray *)getHanyuPinyinStringArrayWithChar:(unichar)ch;
- (BOOL)isValidRecordWithNSString:(NSString *)record;
- (NSString *)getHanyuPinyinRecordFromCharWithChar:(unichar)ch;
+ (LZChineseToPinyinResource *)getInstance;

@end



#endif // _LZChineseToPinyinResource_H_
