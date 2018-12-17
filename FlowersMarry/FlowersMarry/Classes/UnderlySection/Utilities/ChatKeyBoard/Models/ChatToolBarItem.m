//
//  ToolBarItem.m
//  LWGreenBaby
//
//  Created by 律金刚 on 16/4/11.
//  Copyright © 2016年 宁小陌. All rights reserved.
//

#import "ChatToolBarItem.h"

@implementation ChatToolBarItem

+ (instancetype)barItemWithKind:(BarItemKind)itemKind normal:(NSString*)normalStr high:(NSString *)highLstr select:(NSString *)selectStr
{
    return [[[self class] alloc] initWithItemKind:itemKind normal:normalStr high:highLstr select:selectStr];
}


- (instancetype)initWithItemKind:(BarItemKind)itemKind normal:(NSString*)normalStr high:(NSString *)highLstr select:(NSString *)selectStr
{
    if (self = [super init]) {
        self.itemKind = itemKind;
        self.normalStr = normalStr;
        self.highLStr = highLstr;
        self.selectStr = selectStr;
    }
    return self;
}

@end
