//
//  IMessagesTools.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/9/12.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "IMessagesTools.h"
#import "TTChatHelper.h"

@implementation IMessagesTools
+ (SCCustomMarginLabel *)lz_labelWithTitle:(NSString *)datatimeStr {
    SCCustomMarginLabel *timeLabel = [[SCCustomMarginLabel alloc] init];
    timeLabel.font                  = kFontSizeMedium10;
    timeLabel.edgeInsets            = UIEdgeInsetsMake(1.5f, 5.f, 1.5f, 5.f); // 设置左内边距
    timeLabel.backgroundColor       = [UIColor lz_colorWithHexString:@"CECECE"];
    timeLabel.textColor             = [UIColor lz_colorWithHexString:@"FFFFFF"];
    timeLabel.text                  = datatimeStr;
    timeLabel.textAlignment         = NSTextAlignmentCenter;
    timeLabel.layer.masksToBounds   = YES;
    timeLabel.layer.cornerRadius    = 4;
    timeLabel.layer.borderColor     = [[UIColor lz_colorWithHexString:@"CECECE"] CGColor];
    timeLabel.layer.borderWidth     = 1;
    [timeLabel sizeToFit];
    return timeLabel;
}

+ (UILabel *)lz_labelWithMessage:(NSString *)messageStr{
    UILabel *messagelabel           = [[UILabel alloc] init];
    messagelabel.numberOfLines      = 0;
    messagelabel.lineBreakMode      = NSLineBreakByWordWrapping;
    messagelabel.font               = kFontSizeMedium15;
    messagelabel.textColor          = [UIColor lz_colorWithHexString:@"444444"];
    messagelabel.backgroundColor    = [UIColor clearColor];
    
    messagelabel.attributedText     = [TTChatHelper formatMessageString:messageStr];
    return messagelabel;
}

+ (CGRect)lz_labelTextDealWith:(NSString *)messageText maxWidth:(CGFloat)maxWidth{

    NSDictionary *attributes = @{NSFontAttributeName: kFontSizeMedium15};
    CGRect rect = [messageText boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT)
                                                options:NSStringDrawingUsesLineFragmentOrigin
                                         attributes:attributes
                                                context:nil];
    return rect;
}

+ (CGSize)sizeForLabel:(NSAttributedString *)messageText  maxWidth:(CGFloat)maxWidth{
    CGRect frame = [messageText boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT)
                                             options:(NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading)
                                             context:nil];
    
    return frame.size;
}

+ (UIImageView *)lz_createMessageAvatar:(NSString *)avatarUrl{
    UIImageView *imageAvatar=[[UIImageView alloc] init];
    [imageAvatar lz_setCornerRadius:20.0];
    [imageAvatar setImageWithURL:[NSURL URLWithString:avatarUrl] placeholderImage:kGetImage(mineAvatar)];
    return imageAvatar;
}
@end
