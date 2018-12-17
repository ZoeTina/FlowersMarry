//
//  TTChatFaceHeleper.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/9/20.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TTChatFaceHeleper : NSObject

@property (nonatomic, strong) NSMutableArray *faceGroupArray;
+ (TTChatFaceHeleper *) sharedFaceHelper;
- (NSArray *) getFaceArrayByGroupID:(NSString *)groupID;

@end

