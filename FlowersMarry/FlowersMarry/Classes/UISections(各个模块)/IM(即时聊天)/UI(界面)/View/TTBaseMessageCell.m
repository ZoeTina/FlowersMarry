//
//  TTBaseMessageCell.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/9/21.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "TTBaseMessageCell.h"
#import "IMessagesTools.h"

@implementation TTBaseMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle )style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        for (UIView *v  in [self.contentView subviews]) {
            [v removeFromSuperview];
        }
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        [self addSubview:self.messageBackgroundImageView];
        [self addSubview:self.imageAvatar];
    }
    return  self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    if (_messageModel.showMessageTime) {
        /// 创建时间
        SCCustomMarginLabel *timeLabel = [IMessagesTools lz_labelWithTitle:_messageModel.messageTime];
        [self.contentView addSubview:timeLabel];
        [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.contentView.mas_top).offset(10);
            make.centerX.equalTo(self.contentView);
            make.height.mas_equalTo(17);
        }];
    }
}

- (void)setMessageModel:(IMessagesModel *)messageModel{
    _messageModel = messageModel;
    
    /**
     *  聊天的具体界面，只要考虑这两种类型，自己的，别人的。
     */
    if (_messageModel.messageSenderType == iMessageOwnerTypeSelf) {
        // 屏幕宽 - 10 - 头像宽
        [self.imageAvatar setOrigin:CGPointMake(self.width - 10 - self.imageAvatar.width, _messageModel.masTop)];
    } else if (_messageModel.messageSenderType == iMessageOwnerTypeFriend) {
        [self.imageAvatar setOrigin:CGPointMake(10, _messageModel.masTop)];
    }
    
    switch (_messageModel.messageSenderType) {
        case iMessageOwnerTypeSelf:
            /**
             *  自己发的消息
             */
            [self.imageAvatar setHidden:NO];
            [self.imageAvatar setImageWithURL:kGetImageURL(_messageModel.avatarURL) placeholderImage:kGetImage(mineAvatar)];
            [self.messageBackgroundImageView setHidden:NO];
            /**
             *  UIImageResizingModeStretch：拉伸模式，通过拉伸UIEdgeInsets指定的矩形区域来填充图片
             UIImageResizingModeTile：平铺模式，通过重复显示UIEdgeInsets指定的矩形区域来填充图片
             比如下面方法中的拉伸区域：UIEdgeInsetsMake(28, 20, 15, 20)
             */
            self.messageBackgroundImageView.image = [kGetImage(@"message_sender_background_normal") resizableImageWithCapInsets:UIEdgeInsetsMake(28, 20, 15, 20) resizingMode:UIImageResizingModeStretch];
            
            // 设置高亮图片
            self.messageBackgroundImageView.highlightedImage = [kGetImage(@"message_sender_background_highlight") resizableImageWithCapInsets:UIEdgeInsetsMake(28, 20, 15, 20) resizingMode:UIImageResizingModeStretch];
            break;
            
        case iMessageOwnerTypeFriend:
            /**
             *  自己接收到的消息
             */
            [self.imageAvatar setHidden:NO];
            [self.imageAvatar setImageWithURL:kGetImageURL(_messageModel.avatarURL) placeholderImage:kGetImage(mineAvatar)];
            [self.messageBackgroundImageView setHidden:NO];
            [self.messageBackgroundImageView setImage:[kGetImage(@"message_receiver_background_normal") resizableImageWithCapInsets:UIEdgeInsetsMake(28, 20, 15, 20) resizingMode:UIImageResizingModeStretch]];
            self.messageBackgroundImageView.highlightedImage = [kGetImage(@"message_receiver_background_highlight") resizableImageWithCapInsets:UIEdgeInsetsMake(28, 20, 15, 20) resizingMode:UIImageResizingModeStretch];
            break;
            
        case iMessageOwnerTypeSystem:
            [self.imageAvatar setHidden:YES];
            [self.messageBackgroundImageView setHidden:YES];
            break;
        default:
            
            break;
    }
}

//- (SCCustomMarginLabel *)timeLabel{
//    if (!_timeLabel) {
//        _timeLabel = [[SCCustomMarginLabel alloc] init];
//        _timeLabel.font                  = kFontSizeMedium10;
//        _timeLabel.edgeInsets            = UIEdgeInsetsMake(1.5f, 5.f, 1.5f, 5.f); // 设置左内边距
//        _timeLabel.backgroundColor       = [UIColor lz_colorWithHexString:@"CECECE"];
//        _timeLabel.textColor             = [UIColor lz_colorWithHexString:@"FFFFFF"];
//        _timeLabel.textAlignment         = NSTextAlignmentCenter;
//        _timeLabel.layer.masksToBounds   = YES;
//        _timeLabel.layer.cornerRadius    = 4;
//        _timeLabel.layer.borderColor     = [[UIColor lz_colorWithHexString:@"CECECE"] CGColor];
//        _timeLabel.layer.borderWidth     = 1;
//        [_timeLabel sizeToFit];
//    }
//    return _timeLabel;
//}


/**
 * avatarImageView 头像
 */
-(UIImageView *)imageAvatar {
    if (_imageAvatar == nil) {
        float imageWidth = 40;
        _imageAvatar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, imageWidth, imageWidth)];
        [_imageAvatar lz_setCornerRadius:_imageAvatar.middleX];
        [_imageAvatar setHidden:YES];
    }
    return _imageAvatar;
}

/**
 *  聊天背景图
 */
- (UIImageView *) messageBackgroundImageView {
    if (_messageBackgroundImageView == nil) {
        _messageBackgroundImageView = [[UIImageView alloc] init];
        [_messageBackgroundImageView setHidden:YES];
    }
    return _messageBackgroundImageView;
}

@end
