//
//  FMMarriedTaskHeaderView.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/10/12.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCProgressView.h"

NS_ASSUME_NONNULL_BEGIN
typedef void (^FMMarriedTaskHeaderViewBlock) (void);

@interface FMMarriedTaskHeaderView : UIView
- (void) setToolsTaskTableHeadViewBlock:(FMMarriedTaskHeaderViewBlock)block;
/// 标题
@property (strong, nonatomic) UILabel           *titleLabel;
/// 总数
@property (strong, nonatomic) UILabel           *totalCountLabel;
/// 提示label
@property (strong, nonatomic) UILabel           *tipsLabel;
/// 进度条
@property (strong, nonatomic) SCProgressView    *progressView;
/// 邀请提示的View
@property (strong, nonatomic) UIView            *bottomView;
/// 邀请按钮
@property (strong, nonatomic) UIButton          *invitationButton;
/// 邀请提示语
@property (strong, nonatomic) UILabel           *invitationLabel;

@end

NS_ASSUME_NONNULL_END
