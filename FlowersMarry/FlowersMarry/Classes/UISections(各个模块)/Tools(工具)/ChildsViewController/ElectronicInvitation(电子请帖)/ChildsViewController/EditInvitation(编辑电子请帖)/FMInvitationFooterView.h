//
//  FMInvitationFooterView.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/11/2.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

// 这里要定义一个block的别名(申明) 类型 ----> void (^) (NSString *text)
typedef void(^InvitationFooterButtonBlock) (NSInteger idx);
@interface FMInvitationFooterView : UIView

//定义一个block
@property (nonatomic, copy) InvitationFooterButtonBlock block;
/// 加页
@property (nonatomic, strong)  UIButton *addButton;
/// 排序
@property (nonatomic, strong)  UIButton *sortButton;
/// 设置
@property (nonatomic, strong)  UIButton *setupButton;
/// 预览
@property (nonatomic, strong)  UIButton *previewButton;
/// 发送
@property (nonatomic, strong)  UIButton *sendButton;

@end

NS_ASSUME_NONNULL_END
