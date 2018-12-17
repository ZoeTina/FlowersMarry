//
//  TTMoreKBHelper.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/9/18.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "TTMoreKBHelper.h"
#import "TTMoreKeyboardItem.h"

@implementation TTMoreKBHelper

- (id)init {
    if (self = [super init]) {
        self.chatMoreKeyboardData = [[NSMutableArray alloc] init];
        [self p_initTestData];
    }
    return self;
}

- (void)p_initTestData {
    TTMoreKeyboardItem *imageItem = [TTMoreKeyboardItem moreItemWithTitle:@"照片" imagePath:@"sharemore_pic" type:TTMoreKeyboardItemTypeImage];
    TTMoreKeyboardItem *cameraItem = [TTMoreKeyboardItem moreItemWithTitle:@"拍摄" imagePath:@"sharemore_video" type:TTMoreKeyboardItemTypeCamera];
    TTMoreKeyboardItem *videoItem = [TTMoreKeyboardItem moreItemWithTitle:@"小视频" imagePath:@"moreKB_sight" type:TTMoreKeyboardItemTypeVideo];
    TTMoreKeyboardItem *videoCallItem = [TTMoreKeyboardItem moreItemWithTitle:@"视频聊天" imagePath:@"sharemore_videovoip" type:TTMoreKeyboardItemTypeVideoCall];
    TTMoreKeyboardItem *walletItem = [TTMoreKeyboardItem moreItemWithTitle:@"红包" imagePath:@"sharemore_wallet" type:TTMoreKeyboardItemTypeWallet];
    TTMoreKeyboardItem *transferItem = [TTMoreKeyboardItem moreItemWithTitle:@"转账" imagePath:@"sharemore_pay" type:TTMoreKeyboardItemTypeTransfer];
    TTMoreKeyboardItem *positionItem = [TTMoreKeyboardItem moreItemWithTitle:@"位置" imagePath:@"sharemore_location" type:TTMoreKeyboardItemTypePosition];
    TTMoreKeyboardItem *favoriteItem = [TTMoreKeyboardItem moreItemWithTitle:@"收藏" imagePath:@"sharemore_favorite" type:TTMoreKeyboardItemTypeFavorite];
    TTMoreKeyboardItem *businessCardItem = [TTMoreKeyboardItem moreItemWithTitle:@"个人名片" imagePath:@"sharemore_friendcard" type:TTMoreKeyboardItemTypeBusinessCard];
    TTMoreKeyboardItem *voiceItem = [TTMoreKeyboardItem moreItemWithTitle:@"语音输入" imagePath:@"sharemore_voiceinput" type:TTMoreKeyboardItemTypeVoice];
    TTMoreKeyboardItem *cardsItem = [TTMoreKeyboardItem moreItemWithTitle:@"卡券" imagePath:@"sharemore_wallet" type:TTMoreKeyboardItemTypeCards];
    [self.chatMoreKeyboardData addObjectsFromArray:@[imageItem, cameraItem, videoItem, videoCallItem, walletItem, transferItem, positionItem, favoriteItem, businessCardItem, voiceItem, cardsItem]];
}

@end
