//
//  ToolBarItem.h
//  LWGreenBaby
//
//  Created by 律金刚 on 16/4/11.
//  Copyright © 2016年 宁小陌. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, BarItemKind){
    kBarItemVoice,
    kBarItemFace,
    kBarItemMore,
    kBarItemSwitchBar
};

@interface ChatToolBarItem : NSObject

@property (nonatomic, copy) NSString *normalStr;
@property (nonatomic, copy) NSString *highLStr;
@property (nonatomic, copy) NSString *selectStr;
@property (nonatomic, assign) BarItemKind itemKind;

+ (instancetype)barItemWithKind:(BarItemKind)itemKind normal:(NSString*)normalStr high:(NSString *)highLstr select:(NSString *)selectStr;

@end
