//
//  TTChatHelper.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/9/20.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTChatHelper : NSObject

@property (nonatomic, strong) NSMutableArray *faceGroupArray;

+ (NSAttributedString *) formatMessageString:(NSString *)text;

@end
