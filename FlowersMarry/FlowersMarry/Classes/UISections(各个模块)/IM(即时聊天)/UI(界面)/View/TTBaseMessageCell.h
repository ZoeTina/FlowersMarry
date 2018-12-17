//
//  TTBaseMessageCell.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/9/21.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IMessagesModel.h"
#import "UIKit+AFNetworking.h"
@interface TTBaseMessageCell : UITableViewCell
@property(nonatomic,strong) IMessagesModel *messageModel;

/**
 *  其他的cell 继承与这个cell，这个cell中只有头像是共有的，就只写头像，其他的就在各自cell中去写。
 */
/// 头像
@property (nonatomic, strong) UIImageView *imageAvatar;
/// 消息背景
@property (nonatomic, strong) UIImageView *messageBackgroundImageView;
/// 消息发送状态
@property (nonatomic, strong) UIImageView *messageSendStatusImageView;
/// 时间
@property (nonatomic, strong) SCCustomMarginLabel *timeLabel;

@end

