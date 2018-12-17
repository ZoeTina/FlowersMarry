//
//  MoreItem.m
//  LWGreenBaby
//
//  Created by 律金刚 on 16/4/11.
//  Copyright © 2016年 宁小陌. All rights reserved.
//

#import "MoreItem.h"

@implementation MoreItem

+ (instancetype)moreItemWithPicName:(NSString *)picName highLightPicName:(NSString *)highLightPicName itemName:(NSString *)itemName {
    return [[self alloc] initWithPicName:picName highLightPicName:highLightPicName itemName:itemName];
}

- (instancetype)initWithPicName:(NSString *)picName highLightPicName:(NSString *)highLightPicName itemName:(NSString *)itemName
{
    if (self = [super init]) {
        if (picName.length == 0) {
            picName = nil;
        }
        if (highLightPicName.length == 0) {
            highLightPicName = nil;
        }
        self.itemName = itemName;
        self.itemPicName = picName;
        self.itemHighlightPicName = highLightPicName;
    }
    return self;
}

@end
