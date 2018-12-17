//
//  TTMessageTextCell.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/9/21.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "TTMessageTextCell.h"

@implementation TTMessageTextCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.messageTextLabel];
    }
    return self;
}

- (void) layoutSubviews {
    [super layoutSubviews];
    /**
     *  Label 的位置根据头像的位置来确定
     */
    float y = self.imageAvatar.originY + 11;
    float x = self.imageAvatar.originX + (self.messageModel.messageSenderType == iMessageOwnerTypeSelf ? - self.messageTextLabel.width - 27 : self.imageAvatar.width + 23);
    [self.messageTextLabel setOrigin:CGPointMake(x, y)];
    
    x -= 18;                                    // 左边距离头像 5
    y = self.imageAvatar.originY - 5;       // 上边与头像对齐 (北京图像有5个像素偏差)
    float h = MAX(self.messageTextLabel.height + 30, self.imageAvatar.height + 10);
    [self.messageBackgroundImageView setFrame:CGRectMake(x, y, self.messageTextLabel.width + 40, h)];
}

#pragma mark - Getter and Setter
- (void)setMessageModel:(IMessagesModel *)messageModel {
    [super setMessageModel:messageModel];
    [_messageTextLabel setAttributedText:messageModel.messageAttrText];
    _messageTextLabel.size = messageModel.messageSize;
}

- (UILabel *) messageTextLabel {
    if (!_messageTextLabel) {
        _messageTextLabel = [[UILabel alloc] init];
        [_messageTextLabel setFont:kFontSizeMedium15];
        [_messageTextLabel setNumberOfLines:0];
    }
    return _messageTextLabel;
}

@end
