//
//  IMessagesToolsBarModel.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/9/11.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "IMessagesToolsBarModel.h"

@implementation IMessagesToolsBarModel
+ (NSArray *)loadToolsArray{
    ChatToolBarItem *item1 = [ChatToolBarItem barItemWithKind:kBarItemFace normal:@"tools_emotion_normal" high:@"tools_emotion_press" select:@"tools_keyboard_normal"];
    ChatToolBarItem *item2 = [ChatToolBarItem barItemWithKind:kBarItemVoice normal:@"tools_voice_normal" high:@"tools_voice_press" select:@"tools_keyboard_normal"];
    ChatToolBarItem *item3 = [ChatToolBarItem barItemWithKind:kBarItemMore normal:@"tools_more_normal" high:@"tools_more_press" select:nil];
    ChatToolBarItem *item4 = [ChatToolBarItem barItemWithKind:kBarItemSwitchBar normal:@"switchDown" high:nil select:nil];
    
    return @[item1, item2, item3, item4];
}
@end
