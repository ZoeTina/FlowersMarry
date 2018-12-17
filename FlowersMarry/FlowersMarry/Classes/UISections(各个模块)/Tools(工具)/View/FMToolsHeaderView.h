//
//  FMToolsHeaderView.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/9/25.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <UIKit/UIKit.h>

//这里要定义一个block的别名(申明) 类型 ----> void (^) (NSString *text)
typedef void(^ToolsHeaderBlock) (NSInteger idx);

@interface FMToolsHeaderView : UIView
//定义一个block
@property (nonatomic, copy) ToolsHeaderBlock headerBlock;
/// 第一个头像
@property (nonatomic, strong) UIImageView *imagesBgView;
/// 第一个头像
@property (nonatomic, strong) UIImageView *imagesAvatarL;
/// 第二个头像
@property (nonatomic, strong) UIImageView *imagesAvatarR;
/// 昵称
@property (nonatomic, strong) UILabel *nicknameLabel;
/// 编辑
@property (nonatomic, strong) UIButton *editButton;
/// 婚礼倒计时
@property (nonatomic, strong) UILabel *labelTimer;
/// 绑定
@property (nonatomic, strong) UIButton *bindButton;
@end
