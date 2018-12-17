//
//  TTChatFaceModel.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/9/20.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, TTFaceThemeStyle){
    TTFaceThemeStyleSystemEmoji,       //30*30
    TTFaceThemeStyleCustomEmoji,       //40*40
    TTFaceThemeStyleGif                //60*60
};

@interface TTChatFaceModel : NSObject

/** 表情标题 */
@property (nonatomic, copy) NSString *faceTitle;
/** 表情图片 */
@property (nonatomic, copy) NSString *faceIcon;

@property (nonatomic, strong) NSString *faceID;
@property (nonatomic, strong) NSString *faceName;

@end

@interface TTChatFaceGroup : NSObject

@property (nonatomic, assign)   TTFaceThemeStyle themeStyle;
@property (nonatomic, copy)     NSString *groupID;
@property (nonatomic, copy)     NSString *groupImageName;
@property (nonatomic, strong)   NSArray *facesArray;

@end
