//
//  TTMoreKeyboardItem.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/9/18.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, TTMoreKeyboardItemType) {
    TTMoreKeyboardItemTypeImage,
    TTMoreKeyboardItemTypeCamera,
    TTMoreKeyboardItemTypeVideo,
    TTMoreKeyboardItemTypeVideoCall,
    TTMoreKeyboardItemTypeWallet,
    TTMoreKeyboardItemTypeTransfer,
    TTMoreKeyboardItemTypePosition,
    TTMoreKeyboardItemTypeFavorite,
    TTMoreKeyboardItemTypeBusinessCard,
    TTMoreKeyboardItemTypeVoice,
    TTMoreKeyboardItemTypeCards,
};

@interface TTMoreKeyboardItem : NSObject

@property (nonatomic, assign) TTMoreKeyboardItemType type;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *imagePath;

+ (TTMoreKeyboardItem *)moreItemWithTitle:(NSString *)title imagePath:(NSString *)imagePath type:(TTMoreKeyboardItemType)type;

@end

