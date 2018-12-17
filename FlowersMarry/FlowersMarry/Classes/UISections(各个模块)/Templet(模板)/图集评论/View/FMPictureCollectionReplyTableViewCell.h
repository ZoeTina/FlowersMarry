//
//  FMPictureCollectionReplyTableViewCell.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/19.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMCommentsDynamicModel.h"

@interface FMPictureCollectionReplyTableViewCell : UITableViewCell
/// 标题
@property (nonatomic, strong) UILabel *titleLabel;
/// 头像
@property (nonatomic, strong) UIImageView *imagesView;
/// 昵称
@property (nonatomic, strong) UILabel *nicknameLabel;
/// 时间
@property (nonatomic, strong) UILabel *datetimeLabel;


/// 时间
@property (nonatomic, strong) UIView *replyView;
@property (nonatomic, strong) UILabel *replyLabel;
/// 回复前面的图标
@property (nonatomic, strong) UIImageView *replyImagesView;

@property (nonatomic, strong) CommentsDynamicListModel *model;

@end
