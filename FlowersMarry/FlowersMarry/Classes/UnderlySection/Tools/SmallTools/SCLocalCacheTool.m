//
//  SCLocalCacheTool.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/24.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "SCLocalCacheTool.h"

@implementation SCLocalCacheTool

+ (NSString *)userDataDirectoryWithFileName:(NSString *)fileName
{
    NSString *bundlePath = NSHomeDirectory();
    NSString *documentsPath = [bundlePath stringByAppendingPathComponent:@"Documents"];
    NSString *userDataPath = [documentsPath stringByAppendingPathComponent:fileName];
    return userDataPath;
}

+ (void)createUserLocalDirectory:(NSString *)userDataPath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDirectory           = YES;
    NSError *error             = nil;
    
    if (![fileManager fileExistsAtPath:userDataPath isDirectory:&isDirectory]) {
        [fileManager createDirectoryAtPath:userDataPath withIntermediateDirectories:YES attributes:nil error:&error];
    }
}
+ (void)removeFileWithPath:(NSString *)filePath
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtPath:filePath error:nil];
}

@end
