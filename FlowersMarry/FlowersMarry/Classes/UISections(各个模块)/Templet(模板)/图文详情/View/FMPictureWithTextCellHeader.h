//
//  FMPictureWithTextCellHeader.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/6/29.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FMPictureWithTextCellHeader : UITableViewCell

/// 头像图片
@property (nonatomic, strong) UIImageView *imagesView;
/// 标题
@property (nonatomic, strong) UILabel *titleLabel;
/// 昵称
@property (nonatomic, strong) UILabel *nicknameLabel;
/// 关注按钮
@property (nonatomic, strong) UIButton *guanzhuButton;

@property (nonatomic, strong) DynamicModel *dynamicModel;


@end
