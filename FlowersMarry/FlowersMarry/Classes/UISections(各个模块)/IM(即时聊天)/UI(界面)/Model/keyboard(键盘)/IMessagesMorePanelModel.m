//
//  IMessagesMorePanelModel.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/9/11.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "IMessagesMorePanelModel.h"

@implementation IMessagesMorePanelModel
//从持久化存储里面加载表情源
+ (NSArray *)loadMoreArray {
    MoreItem *item1 = [MoreItem moreItemWithPicName:@"sharemore_pic" highLightPicName:nil itemName:@"照片"];
    MoreItem *item2 = [MoreItem moreItemWithPicName:@"sharemore_video" highLightPicName:nil itemName:@"拍摄"];
    MoreItem *item3 = [MoreItem moreItemWithPicName:@"sharemore_videovoip" highLightPicName:nil itemName:@"视频聊天"];
    MoreItem *item4 = [MoreItem moreItemWithPicName:@"sharemore_location" highLightPicName:nil itemName:@"位置"];
    MoreItem *item5 = [MoreItem moreItemWithPicName:@"sharemore_wallet" highLightPicName:nil itemName:@"红包"];
    MoreItem *item6 = [MoreItem moreItemWithPicName:@"sharemore_pay" highLightPicName:nil itemName:@"转账"];
    MoreItem *item7 = [MoreItem moreItemWithPicName:@"sharemore_favorite" highLightPicName:nil itemName:@"收藏"];
    MoreItem *item8 = [MoreItem moreItemWithPicName:@"sharemore_friendcard" highLightPicName:nil itemName:@"个人名片"];
    MoreItem *item9 = [MoreItem moreItemWithPicName:@"sharemore_voiceinput" highLightPicName:nil itemName:@"语音输入"];
    MoreItem *item10 = [MoreItem moreItemWithPicName:@"sharemore_wallet" highLightPicName:nil itemName:@"卡券"];
    return @[item1, item2, item3, item4, item5, item6, item7, item8, item9, item10];
}
@end
