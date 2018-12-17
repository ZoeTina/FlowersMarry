//
//  TTChatFaceHeleper.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/9/20.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "TTChatFaceHeleper.h"
#import "TTChatFaceModel.h"

static TTChatFaceHeleper * faceHeleper = nil;
@implementation TTChatFaceHeleper

+ (TTChatFaceHeleper *)sharedFaceHelper{
    if (!faceHeleper) {
        faceHeleper = [[TTChatFaceHeleper alloc]init];
    }
    return  faceHeleper;
}

/**
 *   通过这个方法，从  plist 文件中取出来表情
 */
#pragma mark - Public Methods
- (NSArray *) getFaceArrayByGroupID:(NSString *)groupID {
    NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"face" ofType:@"plist"]];
    NSMutableArray *data = [[NSMutableArray alloc] initWithCapacity:array.count];
    for (NSDictionary *dic in array) {
        TTChatFaceModel *face = [[TTChatFaceModel alloc] init];
        face.faceID = [dic objectForKey:@"face_id"];
        face.faceName = [dic objectForKey:@"face_name"];
        [data addObject:face];
    }
    return data;
}

#pragma mark -  ChatFaceGroup Getter
- (NSMutableArray *) faceGroupArray {
    if (!_faceGroupArray) {
        _faceGroupArray = [[NSMutableArray alloc] init];
        TTChatFaceGroup *group = [[TTChatFaceGroup alloc] init];
        group.themeStyle = TTFaceThemeStyleSystemEmoji;
        group.groupID = @"normal_face";
        group.groupImageName = @"EmotionsEmojiHL";
        group.facesArray = nil;
        [_faceGroupArray addObject:group];
    }
    return _faceGroupArray;
}
@end
