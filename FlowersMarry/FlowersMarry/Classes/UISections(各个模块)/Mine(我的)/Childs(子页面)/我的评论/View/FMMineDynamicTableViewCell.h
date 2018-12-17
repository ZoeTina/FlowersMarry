//
//  FMMineDynamicTableViewCell.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/16.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMMineCommentsModel.h"

@interface FMMineDynamicTableViewCell : UITableViewCell

/// 图片
@property (nonatomic, strong) UIImageView *imagesView;
/// 播放按钮
@property (nonatomic, strong) UIImageView *imagesPlay;
/// 动态标题
@property (nonatomic, strong) UILabel *titleLabel;
/// 头像
@property (nonatomic, strong) UIImageView *imagesAvatar;
/// 昵称
@property (nonatomic, strong) UILabel *nicknameLabel;
/// 图片数量
@property (strong, nonatomic) UIButton *imagesCountButton;

@property (nonatomic, strong) MineCommentsListModel *commentsModel;
@end
