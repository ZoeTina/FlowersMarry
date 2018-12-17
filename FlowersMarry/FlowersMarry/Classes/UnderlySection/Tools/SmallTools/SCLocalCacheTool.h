//
//  SCLocalCacheTool.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/24.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SCLocalCacheTool : NSObject

/**
 * 根据文件名生成本地缓存的路径
 *
 * @param fileName 文件名
 */
+ (NSString *)userDataDirectoryWithFileName:(NSString *)fileName;


/**
 * 创建用户本地缓存的文件夹
 *
 * @param userDataPath 文件路径
 */
+ (void)createUserLocalDirectory:(NSString *)userDataPath;

/**
 * 移除文件
 */
+ (void)removeFileWithPath:(NSString *)filePath;

@end
