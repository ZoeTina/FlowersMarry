//
//  FMImagesRightTableViewCell.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/5.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FMImagesRightTableViewCell : UITableViewCell

//// 标题
@property (strong, nonatomic) SCVerticallyAlignedLabel *titleLabel;
/// 背景图片
@property (strong, nonatomic) UIImageView *imagesView;

/// 头像
@property (strong, nonatomic) UIImageView *avatarImageView;
/// 昵称
@property (strong, nonatomic) UILabel *nicknameLabel;
/// 日期时间
@property (strong, nonatomic) UILabel *datetimeLabel;
/// 点赞前面的图标
@property (strong, nonatomic) UIImageView *likeImageView;
/// 点赞数量
@property (strong, nonatomic) UILabel *likeCountLabel;
@property (strong, nonatomic) DynamicModel *dynamicModel;


@end
