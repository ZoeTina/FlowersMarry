//
//  TTMessageVoiceCell.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/9/21.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "TTMessageVoiceCell.h"
#import "IMessagesModel.h"

@implementation TTMessageVoiceCell

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
        [self addSubview:self.voiceAnimationImageView];
    }
    return  self;
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    /**
     *  Label 的位置根据头像的位置来确定
     */
    float y = self.imageAvatar.originY + 11;
    float x = self.imageAvatar.originX + (self.messageModel.messageSenderType == iMessageOwnerTypeSelf ? - self.messageBackgroundImageView.width - 27 : self.imageAvatar.width + 23);
    [self.messageBackgroundImageView setOrigin:CGPointMake(x, y)];
    
    [self.messageBackgroundImageView setFrame:CGRectMake(x, y, self.messageBackgroundImageView.width + 40, 40)];
}

- (void)setMessageModel:(IMessagesModel *)messageModel {
    [super setMessageModel:messageModel];
    self.voiceAnimationImageView=[[UIImageView alloc] init];
    self.voiceAnimationImageView.animationRepeatCount = 0;
    self.voiceAnimationImageView.animationDuration = 2;
    // 是自己还是别人
    if (messageModel.messageSenderType == iMessageOwnerTypeFriend) {
        self.messageBackgroundImageView.frame=CGRectMake(12, 12, 12, 16);
        self.messageBackgroundImageView.image=kGetImage(@"wechatvoice3");
        
        NSArray *imageArray = @[kGetImage(@"wechatvoice3"),
                                kGetImage(@"wechatvoice3_1"),
                                kGetImage(@"wechatvoice3_0"),
                                kGetImage(@"wechatvoice3_1"),
                                kGetImage(@"wechatvoice3")];
        self.voiceAnimationImageView.animationImages = imageArray;
        [self.messageBackgroundImageView addSubview:self.voiceAnimationImageView];
    }else if (messageModel.messageSenderType == iMessageOwnerTypeSelf){
        
        self.messageBackgroundImageView.frame=CGRectMake([self voiceLength:messageModel.voiceTime]-12-11, 12, 11, 16);
        self.messageBackgroundImageView.image=kGetImage(@"wechatvoice4");
        NSArray *imageArray = @[kGetImage(@"wechatvoice4"),
                                kGetImage(@"wechatvoice4_1"),
                                kGetImage(@"wechatvoice4_0"),
                                kGetImage(@"wechatvoice4_1"),
                                kGetImage(@"wechatvoice4")];
        self.voiceAnimationImageView.animationImages = imageArray;
        [self.messageBackgroundImageView addSubview:self.voiceAnimationImageView];
    }
}

- (CGFloat)voiceLength:(NSInteger)seconds{
    if (seconds==0) {
        return 75;
    }
    //    6~197 6p~230
    // 75
    CGFloat max=kScreenWidth>750?230:197;
    return 75+(seconds-1)*(max-75)*1.0/60.0;
}


@end
