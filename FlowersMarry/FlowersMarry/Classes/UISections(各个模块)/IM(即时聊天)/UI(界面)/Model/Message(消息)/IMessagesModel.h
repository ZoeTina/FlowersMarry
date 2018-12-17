//
//  IMessagesModel.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/9/12.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  消息所有者类型
 */
typedef NS_ENUM(NSInteger, iMessagePartnerType){
    iMessagePartnerTypeUser = 0,      // 用户
    iMessagePartnerTypeGroup,         // 群聊
};

/// 消息类型
typedef NS_OPTIONS(NSUInteger, iMessageType) {
    iMessageTypeText = 1,
    iMessageTypeVoice,
    iMessageTypeImage,
    iMessageTypeSystem
};

/// 消息拥有者
typedef NS_OPTIONS(NSUInteger, iMessageSenderType) {
    iMessageOwnerTypeUnknown,       // 未知的消息拥有者
    iMessageOwnerTypeSystem,        // 系统消息
    iMessageOwnerTypeSelf,          // 自己发送的消息
    iMessageOwnerTypeFriend,        // 接收到的他人消息
};

/// 消息发送状态
typedef NS_OPTIONS(NSUInteger, iMessageSentStatus) {
    iMessageSentStatusSuccess=1,    // 送达消息发送成功
    iMessageSentStatusSending,      // 正在发送
    iMessageSentStatusFail          // 消息发送失败
};

/// 消息接收状态
typedef NS_OPTIONS(NSUInteger, iMessageReadStatus) {
    iMessageReadStatusRead=1,       //消息已读
    iMessageReadStatusUnRead        //消息未读
    
};


/**
 *  只有当消息送达的时候，才会出现 接收状态，
 *  消息已读 和未读 仅仅针对自己
 *
 *  未送达显示红色，
 *  发送中显示菊花
 *  送达状态彼此互斥
 */
@interface IMessagesModel : NSObject

/// 加载消息数据
+ (NSArray *)loadMessageArray;

/// 消息类型
@property (nonatomic, assign) iMessageType          messageType;
/// 发送者类型
@property (nonatomic, assign) iMessageSenderType    messageSenderType;
/// 消息发送状态
@property (nonatomic, assign) iMessageSentStatus    messageSentStatus;
/// 消息阅读状态
@property (nonatomic, assign) iMessageReadStatus    messageReadStatus;


/// 距离顶部的位置
@property (nonatomic, assign) CGFloat masTop;

#pragma mark - 基本数据
/// 是否显示小时的时间
@property (nonatomic, assign) BOOL      showMessageTime;
/// 消息时间  2018-09-12 11:46
@property (nonatomic, retain) NSString  *messageTime;
/// 头像URL
@property (nonatomic, retain) NSString  *avatarURL;

/// 消息大小
@property (nonatomic, assign) CGSize messageSize;
/// Cell高度
@property (nonatomic, assign) CGFloat cellHeight;
/// Cell标识符
@property (nonatomic, strong) NSString *cellIndentify;


#pragma mark - 文字消息
/// 消息文本内容
@property (nonatomic, retain) NSString    *messageText;
// 格式化的文字信息
@property (nonatomic, strong) NSAttributedString *messageAttrText;

#pragma mark - 图片消息
/// 网络图片URL
@property (nonatomic, retain) NSString  *imageURL;
/// 图片文件(图片缓存)
@property (nonatomic, retain) UIImage   *imageSmall;
/// 本地图片Path
@property (nonatomic, strong) NSString  *imagePath;
#pragma mark - 语音消息
/// 本地语音Path
@property (nonatomic, strong) NSString  *voicePath;
/// 消息音频url
@property (nonatomic, retain) NSString  *voiceURL;
/// 语音时间
@property (nonatomic, assign) NSInteger voiceTime;

@end

