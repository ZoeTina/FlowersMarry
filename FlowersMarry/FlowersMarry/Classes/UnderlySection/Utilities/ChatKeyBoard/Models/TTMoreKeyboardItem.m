//
//  TTMoreKeyboardItem.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/9/18.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "TTMoreKeyboardItem.h"

@implementation TTMoreKeyboardItem

+ (TTMoreKeyboardItem *)moreItemWithTitle:(NSString *)title imagePath:(NSString *)imagePath type:(TTMoreKeyboardItemType)type{
    TTMoreKeyboardItem *item = [[TTMoreKeyboardItem alloc] init];
    item.imagePath = imagePath;
    item.title = title;
    item.type = type;
    return item;
}

@end
