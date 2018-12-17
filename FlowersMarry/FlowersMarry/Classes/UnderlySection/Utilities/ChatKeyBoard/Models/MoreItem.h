//
//  MoreItem.h
//  LWGreenBaby
//
//  Created by 律金刚 on 16/4/11.
//  Copyright © 2016年 宁小陌. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MoreItem : NSObject

@property (nonatomic, copy) NSString * itemPicName;
@property (nonatomic, copy) NSString * itemHighlightPicName;
@property (nonatomic, copy) NSString * itemName;

+ (instancetype)moreItemWithPicName:(NSString *)picName highLightPicName:(NSString *)highLightPicName itemName:(NSString *)itemName;

@end
