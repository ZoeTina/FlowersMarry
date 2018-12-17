//
//  IMessagesModel.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/9/12.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "IMessagesModel.h"
#import "TTChatHelper.h"
static UILabel *labelTemp = nil;
@implementation IMessagesModel

-(id)init{
    if (self = [super init]) {
        if (labelTemp == nil) {
            labelTemp = [[UILabel alloc] init];
            [labelTemp setNumberOfLines:0];
            [labelTemp setFont:kFontSizeMedium15];
        }
    }
    return self;
}


#pragma mark - Setter
- (void) setMessageText:(NSString *)messageText {
    _messageText = messageText;
    if (messageText.length > 0) {
        _messageAttrText = [TTChatHelper formatMessageString:messageText];
    }
}

- (void)setMessageType:(iMessageType)messageType{
    _messageType = messageType;
    switch (messageType) {
        case iMessageTypeText:
            self.cellIndentify = @"TTMessageTextCell";
            break;
        case iMessageTypeImage:
            self.cellIndentify = @"ZXImageMessageCell";
            break;
        case iMessageTypeVoice:
            self.cellIndentify = @"TTMessageVoiceCell";
            break;
        case iMessageTypeSystem:
            self.cellIndentify = @"ZXSystemMessageCell";
            break;
        default:
            break;
    }
}

- (CGFloat)masTop{
    self.masTop = 10;
    if (self.showMessageTime) {
        self.masTop = 37;
    }
    return _masTop;
}

- (CGSize) messageSize {
    switch (self.messageType) {
        case iMessageTypeText:
            [labelTemp setAttributedText:self.messageAttrText];
            _messageSize = [labelTemp sizeThatFits:CGSizeMake(kScreenWidth * 0.58, MAXFLOAT)];
            break;
        case iMessageTypeImage: {
            NSString *path = [NSString stringWithFormat:@"%@/%@", @"", self.imagePath];
            _imageSmall = [UIImage imageNamed:path];
            if (_imageSmall != nil) {
                _messageSize = (_imageSmall.size.width > kScreenWidth * 0.5 ? CGSizeMake(kScreenWidth * 0.5, kScreenWidth * 0.5 / _imageSmall.size.width * _imageSmall.size.height) : _imageSmall.size);
                _messageSize = (_messageSize.height > 60 ? (_messageSize.height < 200 ? _messageSize : CGSizeMake(_messageSize.width, 200)) : CGSizeMake(60.0 / _messageSize.height * _messageSize.width, 60));
            } else {
                _messageSize = CGSizeMake(0, 0);
            }
            break;
        }
        case iMessageTypeVoice:
            break;
            
        case iMessageTypeSystem:
            break;
            
        default:
            break;
    }
    
    return _messageSize;
}

- (CGFloat) cellHeight {
    switch (self.messageType){
            // cell 上下间隔为10
        case iMessageTypeText:
            return self.messageSize.height + 40 > 60 ? self.messageSize.height + 40 + self.masTop : 60 + self.masTop;
            break;
        case iMessageTypeImage:
            return self.messageSize.height + 20 + self.masTop;
            break;
        case iMessageTypeVoice:
            return 40 + 10 + self.masTop;
            break;
        default:
            
            break;
    }
    
    return 0;
}

+ (NSArray *)loadMessageArray{
    
    NSMutableArray *messageArray = [[NSMutableArray alloc] init];
    IMessagesModel *model=[[IMessagesModel alloc] init];
    model.avatarURL = @"https://avatars0.githubusercontent.com/u/12268079?s=460&v=4";
    model.showMessageTime=YES;
    model.messageTime=@"05:22";
    model.messageText=@"中央军委主席习近平日前签署命令，追授海军某舰载航空兵部队一级飞行员张超“逐梦海天的强军先锋”荣誉称号。2016年4月27日，张超在驾驶歼-15进行陆基模拟着舰训练时，飞机突发电传故障，不幸壮烈牺牲。中央军委号召，全军和武警部队广大官兵要以张超同志为榜样，高举中国特色社会主义伟大旗帜，坚持以邓小平理论、“三个代表”重要思想、科学发展观为指导，深入学习贯彻习主席系列重要讲话精神，团结奋进，锐意创新，扎实工作，为实现强军目标、建设世界一流军队贡献智慧和力量";
    model.messageSenderType = iMessageOwnerTypeFriend;
    model.messageType = iMessageTypeText;
    [messageArray addObject:model];
    
    
    model=[[IMessagesModel alloc] init];
    model.avatarURL = @"https://avatars0.githubusercontent.com/u/12268079?s=460&v=4";
    model.showMessageTime=NO;
    model.messageTime=@"06:22";
    model.messageText=@"中央军委主席习近平日前签署命令，追授海军某舰载航空兵部队一级飞行员张超“逐梦海天的强军先锋”荣誉称号。2016年4月27日，张超在驾驶歼-15进行陆基模拟着舰训练时，飞机突发电传故障，不幸壮烈牺牲。中央军委号召，全军和武警部队广大官兵要以张超同志为榜样，高举中国特色社会主义伟大旗帜，坚持以邓小平理论、“三个代表”重要思想、科学发展观为指导，深入学习贯彻习主席系列重要讲话精神，团结奋进，锐意创新，扎实工作，为实现强军目标、建设世界一流军队贡献智慧和力量";
    model.messageSenderType = iMessageOwnerTypeFriend;
    model.messageType = iMessageTypeText;
    [messageArray addObject:model];
    
    model=[[IMessagesModel alloc] init];
    model.avatarURL = @"https://avatars0.githubusercontent.com/u/12268079?s=460&v=4";
    model.showMessageTime=NO;
    model.messageTime=@"07:22";
    model.messageText=@"中央军委主席";
    model.messageSenderType = iMessageOwnerTypeFriend;
    model.messageType = iMessageTypeText;
    [messageArray addObject:model];
    
    model=[[IMessagesModel alloc] init];
    model.avatarURL = @"https://avatars0.githubusercontent.com/u/12268079?s=460&v=4";
    model.showMessageTime=NO;
    model.messageTime=@"08:22";
    model.messageText=@"中央军委主席";
    model.messageSenderType = iMessageOwnerTypeFriend;
    model.messageType = iMessageTypeText;
    [messageArray addObject:model];
    
    
    model=[[IMessagesModel alloc] init];
    model.avatarURL = @"https://aos-cdn-image.amap.com/pp/avatar/e84/a0/24/24930357.jpg?ver=1529746883&imgoss=1";
    model.showMessageTime=YES;
    model.messageTime=@"09:22";
    model.messageText=@"中央军委主席习近平日前签署命令，追授海军某舰载航空兵部队一级飞行员张超“逐梦海天的强军先锋”荣誉称号。2016年4月27日，张超在驾驶歼-15进行陆基模拟着舰训练时，飞机突发电传故障，不幸壮烈牺牲。中央军委号召，全军和武警部队广大官兵要以张超同志为榜样，高举中国特色社会主义伟大旗帜，坚持以邓小平理论、“三个代表”重要思想、科学发展观为指导，深入学习贯彻习主席系列重要讲话精神，团结奋进，锐意创新，扎实工作，为实现强军目标、建设世界一流军队贡献智慧和力量";
    model.messageSenderType = iMessageOwnerTypeSelf;
    model.messageType = iMessageTypeText;
    [messageArray addObject:model];
    
    
    
    
    
    model=[[IMessagesModel alloc] init];
    model.avatarURL = @"https://aos-cdn-image.amap.com/pp/avatar/e84/a0/24/24930357.jpg?ver=1529746883&imgoss=1";
    model.showMessageTime=NO;
    model.messageTime=@"11:22";
    model.messageText=@"中央军委主席习近平日前签署命令，追授海军某舰载航空兵部队一级飞行员张超“逐梦海天的强军先锋”荣誉称号。2016年4月27日，张超在驾驶歼-15进行陆基模拟着舰训练时，飞机突发电传故障，不幸壮烈牺牲。中央军委号召，全军和武警部队广大官兵要以张超同志为榜样，高举中国特色社会主义伟大旗帜，坚持以邓小平理论、“三个代表”重要思想、科学发展观为指导，深入学习贯彻习主席系列重要讲话精神，团结奋进，锐意创新，扎实工作，为实现强军目标、建设世界一流军队贡献智慧和力量中央军委主席习近平日前签署命令，追授海军某舰载航空兵部队一级飞行员张超“逐梦海天的强军先锋”荣誉称号。2016年4月27日，张超在驾驶歼-15进行陆基模拟着舰训练时，飞机突发电传故障，不幸壮烈牺牲。中央军委号召，全军和武警部队广大官兵要以张超同志为榜样，高举中国特色社会主义伟大旗帜，坚持以邓小平理论、“三个代表”重要思想、科学发展观为指导，深入学习贯彻习主席系列重要讲话精神，团结奋进，锐意创新，扎实工作，为实现强军目标、建设世界一流军队贡献智慧和力量中央军委主席习近平日前签署命令，追授海军某舰载航空兵部队一级飞行员张超“逐梦海天的强军先锋”荣誉称号。2016年4月27日，张超在驾驶歼-15进行陆基模拟着舰训练时，飞机突发电传故障，不幸壮烈牺牲。中央军委号召，全军和武警部队广大官兵要以张超同志为榜样，高举中国特色社会主义伟大旗帜，坚持以邓小平理论、“三个代表”重要思想、科学发展观为指导，深入学习贯彻习主席系列重要讲话精神，团结奋进，锐意创新，扎实工作，为实现强军目标、建设世界一流军队贡献智慧和力量中央军委主席习近平日前签署命令，追授海军某舰载航空兵部队一级飞行员张超“逐梦海天的强军先锋”荣誉称号。2016年4月27日，张超在驾驶歼-15进行陆基模拟着舰训练时，飞机突发电传故障，不幸壮烈牺牲。中央军委号召，全军和武警部队广大官兵要以张超同志为榜样，高举中国特色社会主义伟大旗帜，坚持以邓小平理论、“三个代表”重要思想、科学发展观为指导，深入学习贯彻习主席系列重要讲话精神，团结奋进，锐意创新，扎实工作，为实现强军目标、建设世界一流军队贡献智慧和力量中央军委主席习近平日前签署命令，追授海军某舰载航空兵部队一级飞行员张超“逐梦海天的强军先锋”荣誉称号。2016年4月27日，张超在驾驶歼-15进行陆基模拟着舰训练时，飞机突发电传故障，不幸壮烈牺牲。中央军委号召，全军和武警部队广大官兵要以张超同志为榜样，高举中国特色社会主义伟大旗帜，坚持以邓小平理论、“三个代表”重要思想、科学发展观为指导，深入学习贯彻习主席系列重要讲话精神，团结奋进，锐意创新，扎实工作，为实现强军目标、建设世界一流军队贡献智慧和力量中央军委主席习近平日前签署命令，追授海军某舰载航空兵部队一级飞行员张超“逐梦海天的强军先锋”荣誉称号。2016年4月27日，张超在驾驶歼-15进行陆基模拟着舰训练时，飞机突发电传故障，不幸壮烈牺牲。中央军委号召，全军和武警部队广大官兵要以张超同志为榜样，高举中国特色社会主义伟大旗帜，坚持以邓小平理论、“三个代表”重要思想、科学发展观为指导，深入学习贯彻习主席系列重要讲话精神，团结奋进，锐意创新，扎实工作，为实现强军目标、建设世界一流军队贡献智慧和力量中央军委主席习近平日前签署命令，追授海军某舰载航空兵部队一级飞行员张超“逐梦海天的强军先锋”荣誉称号。2016年4月27日，张超在驾驶歼-15进行陆基模拟着舰训练时，飞机突发电传故障，不幸壮烈牺牲。中央军委号召，全军和武警部队广大官兵要以张超同志为榜样，高举中国特色社会主义伟大旗帜，坚持以邓小平理论、“三个代表”重要思想、科学发展观为指导，深入学习贯彻习主席系列重要讲话精神，团结奋进，锐意创新，扎实工作，为实现强军目标、建设世界一流军队贡献智慧和力量";
    model.messageSenderType = iMessageOwnerTypeSelf;
    model.messageType = iMessageTypeText;
    [messageArray addObject:model];
    
    model=[[IMessagesModel alloc] init];
    model.avatarURL = @"https://aos-cdn-image.amap.com/pp/avatar/e84/a0/24/24930357.jpg?ver=1529746883&imgoss=1";
    model.showMessageTime=NO;
    model.messageTime=@"12:22";
    model.messageText=@"中央军委主席习近平日";
    model.messageSenderType = iMessageOwnerTypeSelf;
    model.messageType = iMessageTypeText;
    model.messageSentStatus = iMessageSentStatusSuccess;
    [messageArray addObject:model];
    
    
    
    model=[[IMessagesModel alloc] init];
    model.avatarURL = @"https://aos-cdn-image.amap.com/pp/avatar/e84/a0/24/24930357.jpg?ver=1529746883&imgoss=1";
    model.showMessageTime=NO;
    model.messageTime=@"13:22";
    model.messageText=@"中央军委主席习近平日";
    model.messageSenderType = iMessageOwnerTypeSelf;
    model.messageType = iMessageTypeText;
    model.messageSentStatus = iMessageSentStatusSuccess;
    [messageArray addObject:model];
    
    
    
    
    model=[[IMessagesModel alloc] init];
    model.avatarURL = @"https://aos-cdn-image.amap.com/pp/avatar/e84/a0/24/24930357.jpg?ver=1529746883&imgoss=1";
    model.showMessageTime=YES;
    model.messageTime=@"14:22";
    model.messageText=@"中央军委主席习近平日";
    model.messageSenderType = iMessageOwnerTypeSelf;
    model.messageType = iMessageTypeText;
    model.messageSentStatus = iMessageSentStatusSuccess;
    model.messageReadStatus = iMessageReadStatusRead;
    [messageArray addObject:model];
    
    
    
    
    model=[[IMessagesModel alloc] init];
    model.avatarURL = @"https://aos-cdn-image.amap.com/pp/avatar/e84/a0/24/24930357.jpg?ver=1529746883&imgoss=1";
    model.showMessageTime=NO;
    model.messageTime=@"15:22";
    model.messageText=@"中央军委";
    model.messageSenderType = iMessageOwnerTypeSelf;
    model.messageType = iMessageTypeText;
    model.messageSentStatus = iMessageSentStatusSuccess;
    model.messageReadStatus = iMessageReadStatusUnRead;
    [messageArray addObject:model];
    
    
    
    model=[[IMessagesModel alloc] init];
    model.avatarURL = @"https://aos-cdn-image.amap.com/pp/avatar/e84/a0/24/24930357.jpg?ver=1529746883&imgoss=1";
    model.showMessageTime=NO;
    model.messageTime=@"16:22";
    model.messageText=@"中";
    model.messageSenderType = iMessageOwnerTypeSelf;
    model.messageType = iMessageTypeText;
    [messageArray addObject:model];
    
    
    
    
    
    model=[[IMessagesModel alloc] init];
    model.avatarURL = @"https://aos-cdn-image.amap.com/pp/avatar/e84/a0/24/24930357.jpg?ver=1529746883&imgoss=1";
    model.showMessageTime=NO;
    model.messageTime=@"11:22";
    model.voiceTime=55;
    model.messageSenderType = iMessageOwnerTypeSelf;
    model.messageType = iMessageTypeVoice;
    [messageArray addObject:model];
    
    
    
    
    model=[[IMessagesModel alloc] init];
    model.avatarURL = @"https://aos-cdn-image.amap.com/pp/avatar/e84/a0/24/24930357.jpg?ver=1529746883&imgoss=1";
    model.showMessageTime=NO;
    model.messageTime=@"11:22";
    model.voiceTime=55;
    model.messageSenderType = iMessageOwnerTypeSelf;
    model.messageType = iMessageTypeVoice;
    [messageArray addObject:model];

    
    
    model=[[IMessagesModel alloc] init];
    model.avatarURL = @"https://aos-cdn-image.amap.com/pp/avatar/e84/a0/24/24930357.jpg?ver=1529746883&imgoss=1";
    model.showMessageTime=YES;
    model.messageTime=@"11:22";
    model.voiceTime=4;
    model.messageSenderType = iMessageOwnerTypeSelf;
    model.messageType = iMessageTypeVoice;
    [messageArray addObject:model];

    
    
    
    
    model=[[IMessagesModel alloc] init];
    model.avatarURL = @"https://aos-cdn-image.amap.com/pp/avatar/e84/a0/24/24930357.jpg?ver=1529746883&imgoss=1";
    model.showMessageTime=NO;
    model.messageTime=@"11:22";
    model.voiceTime=9;
    model.messageSentStatus = iMessageSentStatusSending;
    model.messageReadStatus = iMessageReadStatusUnRead;
    model.messageSenderType = iMessageOwnerTypeSelf;
    model.messageType = iMessageTypeVoice;
    [messageArray addObject:model];
    
    
    model=[[IMessagesModel alloc] init];
    model.avatarURL = @"https://aos-cdn-image.amap.com/pp/avatar/e84/a0/24/24930357.jpg?ver=1529746883&imgoss=1";
    model.showMessageTime=NO;
    model.messageTime=@"11:22";
    model.voiceTime=9;
    model.messageSentStatus = iMessageSentStatusSending;
    model.messageReadStatus = iMessageReadStatusUnRead;
    model.messageSenderType = iMessageOwnerTypeSelf;
    model.messageType = iMessageTypeVoice;
    [messageArray addObject:model];
    
    
    
    model=[[IMessagesModel alloc] init];
    model.avatarURL = @"https://aos-cdn-image.amap.com/pp/avatar/e84/a0/24/24930357.jpg?ver=1529746883&imgoss=1";
    model.showMessageTime=NO;
    model.messageTime=@"11:22";
    model.voiceTime=9;
    model.messageSentStatus = iMessageSentStatusSending;
    model.messageReadStatus = iMessageReadStatusUnRead;
    model.messageSenderType = iMessageOwnerTypeSelf;
    model.messageType = iMessageTypeVoice;
    [messageArray addObject:model];
    
    
    model=[[IMessagesModel alloc] init];
    model.avatarURL = @"https://aos-cdn-image.amap.com/pp/avatar/e84/a0/24/24930357.jpg?ver=1529746883&imgoss=1";
    model.showMessageTime=NO;
    model.messageTime=@"11:22";
    model.voiceTime=9;
    model.messageSentStatus = iMessageSentStatusSuccess;
    model.messageReadStatus = iMessageReadStatusRead;
    model.messageSenderType = iMessageOwnerTypeSelf;
    model.messageType = iMessageTypeVoice;
    [messageArray addObject:model];
    
    
    
    
    
    model=[[IMessagesModel alloc] init];
    model.avatarURL = @"https://avatars0.githubusercontent.com/u/12268079?s=460&v=4";
    model.showMessageTime=YES;
    model.messageTime=@"11:22";
    model.voiceTime=9;
    model.messageSenderType = iMessageOwnerTypeFriend;
    model.messageType = iMessageTypeVoice;
    [messageArray addObject:model];
    
    
    model=[[IMessagesModel alloc] init];
    model.avatarURL = @"https://avatars0.githubusercontent.com/u/12268079?s=460&v=4";
    model.showMessageTime=YES;
    model.messageTime=@"11:22";
    model.voiceTime=9;
    model.messageSenderType = iMessageOwnerTypeFriend;
    model.messageType = iMessageTypeImage;
    model.imageSmall= kGetImage(@"base_home_dali");
    [messageArray addObject:model];


    model=[[IMessagesModel alloc] init];
    model.avatarURL = @"https://aos-cdn-image.amap.com/pp/avatar/e84/a0/24/24930357.jpg?ver=1529746883&imgoss=1";
    model.showMessageTime=YES;
    model.messageTime=@"11:23";
    model.voiceTime=9;
    model.messageSenderType = iMessageOwnerTypeSelf;
    model.messageType = iMessageTypeImage;
    model.messageSentStatus = iMessageSentStatusFail;
    model.messageReadStatus = iMessageReadStatusRead;
    model.imageSmall=kGetImage(@"base_home_sanya");
    [messageArray addObject:model];



    model=[[IMessagesModel alloc] init];
    model.avatarURL = @"https://aos-cdn-image.amap.com/pp/avatar/e84/a0/24/24930357.jpg?ver=1529746883&imgoss=1";
    model.showMessageTime=YES;
    model.messageTime=@"11:25";
    model.voiceTime=9;
    model.messageSenderType = iMessageOwnerTypeSelf;
    model.messageType = iMessageTypeImage;
    model.messageSentStatus = iMessageSentStatusSuccess;
    model.messageReadStatus = iMessageReadStatusUnRead;
    model.imageSmall=kGetImage(@"base_image_tu52");
    [messageArray addObject:model];
    
    
    
    
    model=[[IMessagesModel alloc] init];
    model.avatarURL = @"https://aos-cdn-image.amap.com/pp/avatar/e84/a0/24/24930357.jpg?ver=1529746883&imgoss=1";
    model.showMessageTime=YES;
    model.messageTime=@"11:27";
    model.voiceTime=9;
    model.messageSenderType = iMessageOwnerTypeSelf;
    model.messageType = iMessageTypeImage;
    model.messageSentStatus = iMessageSentStatusSending;
    model.messageReadStatus = iMessageReadStatusRead;
    model.imageSmall=kGetImage(@"base_image_tu62");
    [messageArray addObject:model];
    
    
    
    model=[[IMessagesModel alloc] init];
    model.avatarURL = @"https://aos-cdn-image.amap.com/pp/avatar/e84/a0/24/24930357.jpg?ver=1529746883&imgoss=1";
    model.showMessageTime=YES;
    model.messageTime=@"11:29";
    model.voiceTime=9;
    model.messageSenderType = iMessageOwnerTypeSelf;
    model.messageType = iMessageTypeImage;
    model.messageSentStatus = iMessageSentStatusSuccess;
    model.messageReadStatus = iMessageReadStatusRead;
    model.imageSmall=kGetImage(@"base_image_tu63");
    [messageArray addObject:model];
    
    model=[[IMessagesModel alloc] init];
    model.avatarURL = @"https://avatars0.githubusercontent.com/u/12268079?s=460&v=4";
    model.showMessageTime=YES;
    model.messageTime=@"11:32";
    model.messageSenderType = iMessageOwnerTypeFriend;
    model.messageType = iMessageTypeImage;
    model.imageSmall= kGetImage(@"WechatIMG1_hd");
    [messageArray addObject:model];
    
    model=[[IMessagesModel alloc] init];
    model.avatarURL = @"https://aos-cdn-image.amap.com/pp/avatar/e84/a0/24/24930357.jpg?ver=1529746883&imgoss=1";
    model.showMessageTime=YES;
    model.messageTime=@"11:35";
    model.voiceTime=9;
    model.messageSenderType = iMessageOwnerTypeSelf;
    model.messageType = iMessageTypeImage;
    model.messageSentStatus = iMessageSentStatusSending;
    model.messageReadStatus = iMessageReadStatusUnRead;
    model.imageSmall = kGetImage(@"WechatIMG3_hd");
    [messageArray addObject:model];
    
    model=[[IMessagesModel alloc] init];
    model.avatarURL = @"https://aos-cdn-image.amap.com/pp/avatar/e84/a0/24/24930357.jpg?ver=1529746883&imgoss=1";
    model.showMessageTime=YES;
    model.messageTime=@"11:35";
    model.voiceTime=9;
    model.messageSenderType = iMessageOwnerTypeSelf;
    model.messageType = iMessageTypeImage;
    model.messageSentStatus = iMessageSentStatusFail;
    model.messageReadStatus = iMessageReadStatusUnRead;
    model.imageSmall=kGetImage(@"WechatIMG3_hd");
    [messageArray addObject:model];
    
    model=[[IMessagesModel alloc] init];
    model.avatarURL = @"https://aos-cdn-image.amap.com/pp/avatar/e84/a0/24/24930357.jpg?ver=1529746883&imgoss=1";
    model.showMessageTime=YES;
    model.messageTime=@"11:36";
    model.voiceTime=9;
    model.messageSenderType = iMessageOwnerTypeSelf;
    model.messageType = iMessageTypeImage;
    model.messageSentStatus = iMessageSentStatusFail;
    model.messageReadStatus = iMessageReadStatusUnRead;
    model.imageSmall=kGetImage(@"WechatIMG4_hd");
    [messageArray addObject:model];
    
    model=[[IMessagesModel alloc] init];
    model.avatarURL = @"https://avatars0.githubusercontent.com/u/12268079?s=460&v=4";
    model.showMessageTime=YES;
    model.messageTime=@"11:37";
    model.messageSenderType = iMessageOwnerTypeFriend;
    model.messageType = iMessageTypeImage;
    model.imageSmall= kGetImage(@"WechatIMG5_hd");
    [messageArray addObject:model];
    
    model=[[IMessagesModel alloc] init];
    model.avatarURL = @"https://avatars0.githubusercontent.com/u/12268079?s=460&v=4";
    model.showMessageTime=YES;
    model.messageTime=@"11:38";
    model.messageSenderType = iMessageOwnerTypeFriend;
    model.messageType = iMessageTypeImage;
    model.imageSmall= kGetImage(@"WechatIMG6_hd");
    [messageArray addObject:model];
    
    model=[[IMessagesModel alloc] init];
    model.avatarURL = @"https://avatars0.githubusercontent.com/u/12268079?s=460&v=4";
    model.showMessageTime=YES;
    model.messageTime=@"11:39";
    model.messageSenderType = iMessageOwnerTypeFriend;
    model.messageType = iMessageTypeImage;
    model.imageSmall= kGetImage(@"WechatIMG7_hd");
    [messageArray addObject:model];
    
    model=[[IMessagesModel alloc] init];
    model.avatarURL = @"https://avatars0.githubusercontent.com/u/12268079?s=460&v=4";
    model.showMessageTime=YES;
    model.messageTime=@"11:40";
    model.messageSenderType = iMessageOwnerTypeFriend;
    model.messageType = iMessageTypeImage;
    model.imageSmall= kGetImage(@"WechatIMG8_hd");
    [messageArray addObject:model];
    
    model=[[IMessagesModel alloc] init];
    model.avatarURL = @"https://aos-cdn-image.amap.com/pp/avatar/e84/a0/24/24930357.jpg?ver=1529746883&imgoss=1";
    model.showMessageTime=YES;
    model.messageTime=@"11:41";
    model.voiceTime=9;
    model.messageSenderType = iMessageOwnerTypeSelf;
    model.messageType = iMessageTypeImage;
    model.messageSentStatus = iMessageSentStatusFail;
    model.messageReadStatus = iMessageReadStatusRead;
    model.imageSmall= kGetImage(@"WechatIMG9_hd");
    [messageArray addObject:model];
    
    return messageArray;
}

@end
