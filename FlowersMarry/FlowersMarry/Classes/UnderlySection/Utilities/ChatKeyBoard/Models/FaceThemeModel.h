//
//  FaceModel.h
//  LWGreenBaby
//
//  Created by 律金刚 on 16/4/11.
//  Copyright © 2016年 宁小陌. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, FaceThemeStyle)
{
    FaceThemeStyleSystemEmoji,       //30*30
    FaceThemeStyleCustomEmoji,       //40*40
    FaceThemeStyleGif                //60*60
};

@interface FaceModel : NSObject

/** 表情标题 */
@property (nonatomic, copy) NSString *faceTitle;
/** 表情图片 */
@property (nonatomic, copy) NSString *faceIcon;

@end

@interface FaceThemeModel : NSObject

@property (nonatomic, assign) FaceThemeStyle themeStyle;
@property (nonatomic, copy)   NSString *themeIcon;
@property (nonatomic, copy)   NSString *themeDecribe;
@property (nonatomic, strong) NSArray *faceModels;

@end
