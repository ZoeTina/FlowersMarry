//
//  IMessagesTools.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/9/12.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "UIKit+AFNetworking.h"
//#import "MLEmojiLabel.h"

@interface IMessagesTools : NSObject
/// 创建时间
+ (SCCustomMarginLabel *)lz_labelWithTitle:(NSString *)datatimeStr;
/// 创建文字消息
+ (UILabel *)lz_labelWithMessage:(NSString *)messageStr;
/// 处理文字内容自适应
+ (CGRect)lz_labelTextDealWith:(NSString *)messageText maxWidth:(CGFloat)maxWidth;
/// 创建消息头像
+ (UIImageView *)lz_createMessageAvatar:(NSString *)avatarUrl;
@end

