//
//  IMessagesTableViewCell.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/9/12.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "IMessagesTableViewCell.h"
#import "UIKit+AFNetworking.h"

// 1s  length 75
// 60s  6~197 6p~230
#define MAX_IMAGE_WH 141.0
#define DEF_ICON @"collection4_10"
#define leftMargin (kScreenWidth>750?55:52.5)
#define rightMargin (kScreenWidth>750?89:73)
/// 消息最大宽度
#define maxWith kScreenWidth-leftMargin-rightMargin-14-12-4
@interface IMessagesTableViewCell()
@end
@implementation IMessagesTableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView messageModel:(IMessagesModel *)model{
    static NSString *identifier = @"IMessagesModel";
    IMessagesTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell!=nil) {
        cell=nil;
    }
    cell = [[IMessagesTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier messageModel:model];
    return cell;
}

- (void) imageAvatarCreate:(IMessagesModel *)model{
    /// 头像边距位置
    CGFloat imageAvatarWidth    = 40;
    CGFloat imageAvatarMargin   = (model.messageSenderType == iMessageOwnerTypeFriend) ? 10 : kScreenWidth-10-imageAvatarWidth;
    UIImageView *imageAvatar    = [IMessagesTools lz_createMessageAvatar:model.avatarURL];
    imageAvatar.frame           = CGRectMake(imageAvatarMargin, model.masTop, imageAvatarWidth, imageAvatarWidth);
    [self.contentView addSubview:imageAvatar];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier messageModel:(IMessagesModel *)model{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        self.messageModel=model;
        for (UIView *v  in [self.contentView subviews]) {
            [v removeFromSuperview];
        }
        if (model.showMessageTime) {
            /// 创建时间
            SCCustomMarginLabel *timeLabel = [IMessagesTools lz_labelWithTitle:model.messageTime];
            [self.contentView addSubview:timeLabel];
            [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_equalTo(self.contentView.mas_top).offset(10);
                make.centerX.equalTo(self.contentView);
                make.height.mas_equalTo(17);
            }];
        }
        
        /// 创建消息背景图片
        UIImageView *contextBack = [[UIImageView alloc] init];
        contextBack.userInteractionEnabled = YES;
        
        self.coversImageView = [[UIImageView alloc] init];
        self.coversImageView.userInteractionEnabled = YES;
        
        if (model.messageType==iMessageTypeText) {
            
            // 是自己还是别人
            if (model.messageSenderType == iMessageOwnerTypeFriend) {
                /// 创建自己的头像
                [self imageAvatarCreate:model];
                
                UILabel *textMessageLabel = [IMessagesTools lz_labelWithMessage:model.messageText];
                CGSize messageSize = [textMessageLabel sizeThatFits:CGSizeMake(maxWith, MAXFLOAT)];
                contextBack.frame=CGRectMake(leftMargin, model.masTop, messageSize.width+20, messageSize.height+20);
                contextBack.image=[kGetImage(@"wechatback1") stretchableImageWithLeftCapWidth:10 topCapHeight:25];
                [self.contentView addSubview:contextBack];
                textMessageLabel.frame=CGRectMake(leftMargin+12, model.masTop+10, messageSize.width, messageSize.height);
                textMessageLabel.size = [textMessageLabel sizeThatFits:CGSizeMake(maxWith, MAXFLOAT)];
                [self.contentView addSubview:textMessageLabel];
            }else if (model.messageSenderType==iMessageOwnerTypeSelf){
                /// 创建别人的头像
                [self imageAvatarCreate:model];
                
                UILabel *textMessageLabel = [IMessagesTools lz_labelWithMessage:model.messageText];
                CGSize messageSize = [textMessageLabel sizeThatFits:CGSizeMake(maxWith, MAXFLOAT)];

                contextBack.frame=CGRectMake(kScreenWidth-(messageSize.width+26)-leftMargin, model.masTop, messageSize.width+26, messageSize.height+20);
                contextBack.image=[[UIImage imageNamed:@"wechatback2"] stretchableImageWithLeftCapWidth:10 topCapHeight:25];
                [self.contentView addSubview:contextBack];
                textMessageLabel.frame=CGRectMake(kScreenWidth-(messageSize.width+26)-leftMargin+12, model.masTop+10, messageSize.width, messageSize.height);
                [self.contentView addSubview:textMessageLabel];
            } else if(model.messageType == iMessageOwnerTypeSystem){
                /// 系统消息
            } else if(model.messageType == iMessageOwnerTypeUnknown){
                /// 未知消息
            }
        }else if (model.messageType == iMessageTypeVoice){
            self.voiceAnimationImageView=[[UIImageView alloc] init];
            self.voiceAnimationImageView.animationRepeatCount = 0;
            self.voiceAnimationImageView.animationDuration = 2;
            
            // 是自己还是别人
            if (model.messageSenderType == iMessageOwnerTypeFriend) {
                /// 创建自己的头像
                [self imageAvatarCreate:model];
                
                contextBack.frame=CGRectMake(leftMargin, model.masTop, [self voiceLength:model.voiceTime], 40);
                contextBack.image=[[UIImage imageNamed:@"wechatback1"] stretchableImageWithLeftCapWidth:10 topCapHeight:25];
                [self.contentView addSubview:contextBack];
                
                self.voiceAnimationImageView.frame = CGRectMake(12, 12, 12, 16);
                self.voiceAnimationImageView.image = kGetImage(@"wechatvoice3");
                
                NSArray *imageArray = @[kGetImage(@"wechatvoice3"),
                                        kGetImage(@"wechatvoice3_1"),
                                        kGetImage(@"wechatvoice3_0"),
                                        kGetImage(@"wechatvoice3_1"),
                                        kGetImage(@"wechatvoice3")];
                self.voiceAnimationImageView.animationImages = imageArray;
                [contextBack addSubview:self.voiceAnimationImageView];
            }else if (model.messageSenderType == iMessageOwnerTypeSelf){
                /// 创建别人的头像
                [self imageAvatarCreate:model];
                
                contextBack.frame = CGRectMake(kScreenWidth-leftMargin-[self voiceLength:model.voiceTime], model.masTop, [self voiceLength:model.voiceTime], 40);
                contextBack.image = [[UIImage imageNamed:@"wechatback2"] stretchableImageWithLeftCapWidth:10 topCapHeight:25];
                [self.contentView addSubview:contextBack];
                
                self.voiceAnimationImageView.frame = CGRectMake([self voiceLength:model.voiceTime]-12-11, 12, 11, 16);
                self.voiceAnimationImageView.image = kGetImage(@"wechatvoice4");
                NSArray *imageArray = @[kGetImage(@"wechatvoice4"),
                                        kGetImage(@"wechatvoice4_1"),
                                        kGetImage(@"wechatvoice4_0"),
                                        kGetImage(@"wechatvoice4_1"),
                                        kGetImage(@"wechatvoice4")];
                self.voiceAnimationImageView.animationImages = imageArray;
                [contextBack addSubview:self.voiceAnimationImageView];
            }
        }else if (model.messageType==iMessageTypeImage){
            
            // 是自己还是别人
            if (model.messageSenderType==iMessageOwnerTypeFriend) {
                
                /// 创建自己的头像
                [self imageAvatarCreate:model];
                
                CGSize imageSize=[IMessagesTableViewCell imageShowSize:model.imageSmall];
                
                UIImageView *imageViewMask = [[UIImageView alloc] initWithImage:[kGetImage(@"wechatback1") stretchableImageWithLeftCapWidth:10 topCapHeight:25]];
                imageViewMask.frame = CGRectMake(0, 0, imageSize.width, imageSize.height);
                
                contextBack.frame=CGRectMake(leftMargin, model.masTop, imageSize.width, imageSize.height);
                contextBack.image=model.imageSmall;
                contextBack.layer.mask = imageViewMask.layer;
                [self.contentView addSubview:contextBack];
                
            } else if (model.messageSenderType==iMessageOwnerTypeSelf){
                
                /// 创建别人的头像
                [self imageAvatarCreate:model];
                
                CGSize imageSize=[IMessagesTableViewCell imageShowSize:model.imageSmall];
                
                UIImageView *imageViewMask = [[UIImageView alloc] initWithImage:[kGetImage(@"wechatback2") stretchableImageWithLeftCapWidth:10 topCapHeight:25]];
                imageViewMask.frame = CGRectMake(0, 0, imageSize.width, imageSize.height);
                
                contextBack.frame=CGRectMake(kScreenWidth-leftMargin-imageSize.width, model.masTop, imageSize.width, imageSize.height);
                contextBack.image=model.imageSmall;
                contextBack.layer.mask = imageViewMask.layer;
                [self.contentView addSubview:contextBack];
            }
        }
        
        UILongPressGestureRecognizer *longPressGesture=[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressBubbleView:)];
        [contextBack addGestureRecognizer:longPressGesture];
        
        UITapGestureRecognizer * singleTap    = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
        UITapGestureRecognizer * doubleTap    = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
        [doubleTap setNumberOfTapsRequired:2];
        [singleTap requireGestureRecognizerToFail:doubleTap];
        [contextBack addGestureRecognizer:doubleTap];
        [contextBack addGestureRecognizer:singleTap];
        
        
        self.coversImageView.frame=contextBack.frame;
        if (model.messageSenderType==iMessageOwnerTypeFriend) {
            self.coversImageView.image=[kGetImage(@"wechatback1cover") stretchableImageWithLeftCapWidth:10 topCapHeight:25];
        }else{
            self.coversImageView.image=[kGetImage(@"wechatback2cover") stretchableImageWithLeftCapWidth:10 topCapHeight:25];
        }
        
        [self.contentView addSubview:self.coversImageView];
        self.coversImageView.hidden=YES;
        
        UITapGestureRecognizer * singleTap2    = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap2:)];
        [self.coversImageView addGestureRecognizer:singleTap2];
        if (model.messageSenderType==iMessageOwnerTypeSelf) {
            /// 送达状态仅仅针对 用户
            // 只有送达成功 才会出现 已读 和 未读的情况  text
            if (model.messageSentStatus==iMessageSentStatusSuccess) {
                
                UILabel *readStatusLabel=[[UILabel alloc] init];
                readStatusLabel.font=kFontSizeMedium12;
                
                if (model.messageReadStatus==iMessageReadStatusRead) {
                    readStatusLabel.text=@"已读";
                    readStatusLabel.textColor=[UIColor lz_colorWithHexString:@"BABABA"];
                }else if (model.messageReadStatus==iMessageReadStatusUnRead){
                    readStatusLabel.text=@"未读";
                    readStatusLabel.textColor=[UIColor lz_colorWithHexString:@"C00000"];
                }
                
                [self.contentView addSubview:readStatusLabel];
                if (model.messageType==iMessageTypeVoice) {
                    UILabel *seconds=[[UILabel alloc] init];
                    seconds.textColor=[UIColor lz_colorWithHexString:@"999999"];
                    seconds.font=kFontSizeMedium15;
                    seconds.text=[NSString stringWithFormat:@"%ld ''",model.voiceTime];
                    [self.contentView addSubview:seconds];
                    [seconds mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.centerY.equalTo(contextBack);
                        make.right.mas_equalTo(contextBack.mas_left).offset(-10);;
                    }];
                    
                    [readStatusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.centerY.equalTo(contextBack);
                        make.right.mas_equalTo(seconds.mas_left).offset(-10);;
                    }];
                }else{
                    [readStatusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.centerY.equalTo(contextBack);
                        make.right.mas_equalTo(contextBack.mas_left).offset(-10);;
                    }];
                }
            }else if(model.messageSentStatus==iMessageSentStatusFail){
                UIButton *unsendButton=[[UIButton alloc] init];
                [unsendButton setImage:[UIImage imageNamed:@"wechat_resendbut5"] forState:UIControlStateNormal];
                [unsendButton addTarget:self action:@selector(reSendAction:) forControlEvents:UIControlEventTouchUpInside];
                [self.contentView addSubview:unsendButton];
                
                if (model.messageType==iMessageTypeVoice) {
                    UILabel *seconds=[[UILabel alloc] init];
                    seconds.textColor=[UIColor lz_colorWithHexString:@"999999"];
                    seconds.font=kFontSizeMedium15;
                    seconds.text=[NSString stringWithFormat:@"%ld ''",model.voiceTime];
                    [self.contentView addSubview:seconds];
                    [seconds mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.centerY.equalTo(contextBack);
                        make.right.mas_equalTo(contextBack.mas_left).offset(-10);;
                    }];
                    
                    [unsendButton mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.centerY.equalTo(contextBack);
                        make.right.mas_equalTo(seconds.mas_left).offset(-10);;
                    }];
                }else{
                    [unsendButton mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.centerY.equalTo(contextBack);
                        make.right.mas_equalTo(contextBack.mas_left).offset(-10);;
                    }];
                    
                }
            }else if(model.messageSentStatus==iMessageSentStatusSending){
                
                UIActivityIndicatorView *acview=[[UIActivityIndicatorView alloc] init];
                [acview setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleGray];
                [self.contentView addSubview:acview];
                [acview mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerY.equalTo(contextBack);
                    make.right.mas_equalTo(contextBack.mas_left).offset(-10);;
                }];
                [acview startAnimating];
            }
        }
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(menuCotrollerWillHidden:) name:UIMenuControllerWillHideMenuNotification object:nil];
        //        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(menuCotrollerDidHidden:) name:UIMenuControllerDidHideMenuNotification object:nil];
    }
    return self;
}


- (void)reSendAction:(UIButton *)sender{
    if (self.resendblock) {
        self.resendblock(self.messageModel);
    }
}

- (void)handleSingleTap2:(id)sender{
    self.coversImageView.hidden=YES;
    //    [ setMenuVisible:YES animated:NO];
    if ([UIMenuController sharedMenuController].isMenuVisible) {
        [UIMenuController sharedMenuController].menuVisible=NO;
    }
    
}

-(void)menuCotrollerWillHidden:(id)sender{
    if (!self.coversImageView.isHidden) {
        self.coversImageView.hidden=YES;
    }
}
//-(void)menuCotrollerDidHidden:(id)sender{

//     NSLog(@"======###############==");
//}

-(void)setResendClickBlock:(DoubleClickBlock )resendClickBlock{
    
    self.resendblock=resendClickBlock;
}

-(void)setSingleClickBlock:(DoubleClickBlock )singleClickBlock{
    self.singleblock=singleClickBlock;
}

-(void)setDoubleClickBlock:(DoubleClickBlock )doubleClickBlock{
    self.doubleblock=doubleClickBlock;
}

-(void)handleDoubleTap:(id)sender{
    if (self.messageModel.messageType==iMessageTypeText) {
        if (self.doubleblock) {
            self.doubleblock(self.messageModel);
        }
    }
}

-(void)handleSingleTap:(id)sender{
    if (self.messageModel.messageType!=iMessageTypeText) {
        if (self.singleblock) {
            self.singleblock(self.messageModel);
        }
        
        if (self.messageModel.messageType==iMessageTypeVoice) {
            [self startVoiceAnimation];
            
            __block IMessagesTableViewCell/*主控制器*/ *weakSelf = self;
            
            self.coversImageView.hidden=NO;
            dispatch_time_t delayTime1 = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC));
            dispatch_after(delayTime1, dispatch_get_main_queue(), ^{
                self.coversImageView.hidden=YES;
            });
            dispatch_time_t delayTime2 = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(self.messageModel.voiceTime * NSEC_PER_SEC));
            
            dispatch_after(delayTime2, dispatch_get_main_queue(), ^{
                [weakSelf stopVoiceAnimation];
            });
        }
    }
}
#pragma 长按事件
- (void)longPressBubbleView:(UILongPressGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateBegan) {
        [self showMenuControllerInView:self bgView:sender.view];
    }
}

- (void)showMenuControllerInView:(IMessagesTableViewCell *)inView bgView:(UIView *)supView{
    self.coversImageView.hidden=NO;
    [self becomeFirstResponder];
    
    IMessagesModel *messageModel=self.messageModel;
    UIMenuItem *copyTextItem1 = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(copyTextSender1:)];
    UIMenuItem *copyTextItem2 = [[UIMenuItem alloc] initWithTitle:@"删除" action:@selector(copyTextSender2:)];
    UIMenuItem *copyTextItem3 = [[UIMenuItem alloc] initWithTitle:@"保存" action:@selector(copyTextSender2:)];
    UIMenuController *menu = [UIMenuController sharedMenuController];
    [menu setTargetRect:supView.frame inView:inView];
    [menu setArrowDirection:UIMenuControllerArrowDefault];
    if (messageModel.messageType==iMessageTypeText) {
        [menu setMenuItems:@[copyTextItem1,copyTextItem2,copyTextItem3]];
    }else if (messageModel.messageType==iMessageTypeImage){
        [menu setMenuItems:@[copyTextItem1,copyTextItem2,copyTextItem3]];
    }else if(messageModel.messageType==iMessageTypeVoice){
        [menu setMenuItems:@[copyTextItem1,copyTextItem2,copyTextItem3]];
    }
    [menu setMenuVisible:YES animated:YES];
}
#pragma mark 剪切板代理方法
-(BOOL)canBecomeFirstResponder {
    return YES;
}

-(BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    if (action == @selector(copyTextSender1:)) {
        return true;
    } else  if (action == @selector(copyTextSender2:)) {
        return true;
    } else {
        return false;
    }
}

/// 复制
-(void)copyTextSender1:(id)sender {
    //    UIPasteboard *pasteboard=[UIPasteboard generalPasteboard];
    //    pasteboard.string = copiedText;
    //    [self.chatCellDelegate showToastViewInCell:self toastText:[MQBundleUtil localizedStringForKey:@"save_text_success"]];
}
/// 删除
-(void)copyTextSender2:(id)sender {
    //    UIPasteboard *pasteboard=[UIPasteboard generalPasteboard];
    //    pasteboard.string = copiedText;
    //    [self.chatCellDelegate showToastViewInCell:self toastText:[MQBundleUtil localizedStringForKey:@"save_text_success"]];
}

/// 保存
-(void)copyImageSender:(id)sender {
    //    UIImageWriteToSavedPhotosAlbum(copiedImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}

/// 保存到相册的回调
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if(error != NULL){
        //        [self.chatCellDelegate showToastViewInCell:self toastText:[MQBundleUtil localizedStringForKey:@"save_photo_error"]];
    }else{
        //        [self.chatCellDelegate showToastViewInCell:self toastText:[MQBundleUtil localizedStringForKey:@"save_photo_success"]];
    }
}

+ (CGFloat)tableHeightWithModel:(IMessagesModel *)model{
    if (model.messageType==iMessageTypeText) {
        UILabel *labelTemp = [IMessagesTools lz_labelWithMessage:model.messageText];
        CGSize messageSize = [labelTemp sizeThatFits:CGSizeMake(maxWith, MAXFLOAT)];
        return messageSize.height+20+model.masTop+20;
    }else if (model.messageType==iMessageTypeVoice){
        return 40+model.masTop+20;
    }else if (model.messageType==iMessageTypeImage){
        CGSize cgsize=[self imageShowSize:model.imageSmall];
        return 40+cgsize.height+20;
    }
    return 0;
}

-(CGFloat)voiceLength:(NSInteger)seconds{
    
    if (seconds==0) {
        return 75;
    }
    
    //    6~197 6p~230
    // 75
    CGFloat max=kScreenWidth>750?230:197;
    
    return 75+(seconds-1)*(max-75)*1.0/60.0;
}



/*
 判断图片长度&宽度
 
 */
+(CGSize)imageShowSize:(UIImage *)image{
    
    CGFloat imageWith=image.size.width;
    CGFloat imageHeight=image.size.height;
    
    //宽度大于高度
    if (imageWith>=imageHeight) {
        // 宽度超过标准宽度
        /*
         if (imageWith>MAX_IMAGE_WH) {
         
         }else{
         
         }
         */
        return CGSizeMake(MAX_IMAGE_WH, imageHeight*MAX_IMAGE_WH/imageWith);
    }else{
        /*
         if (imageHeight>MAX_IMAGE_WH) {
         
         }else{
         
         }
         */
        return CGSizeMake(imageWith*MAX_IMAGE_WH/imageHeight, MAX_IMAGE_WH);
    }
    return CGSizeZero;
}

-(void)startVoiceAnimation{
    [self.voiceAnimationImageView startAnimating];
}

-(void)stopVoiceAnimation{
    [self.voiceAnimationImageView stopAnimating];
}

-(void)startSentMessageAnimation{
    
}

-(void)stopSentMessageAnimation{
    
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end
