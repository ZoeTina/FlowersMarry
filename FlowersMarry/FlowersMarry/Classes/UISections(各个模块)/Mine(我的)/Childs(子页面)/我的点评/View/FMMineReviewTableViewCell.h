//
//  FMMineReviewTableViewCell.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/16.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMMineReviewModel.h"

@class FMMineReviewTableViewCell;
@protocol FMMineReviewTableViewCellDelegate <NSObject>

/**
 * 动态改变UITableViewCell的高度
 */
- (void)updateTableViewCellHeight:(FMMineReviewTableViewCell *)cell andheight:(CGFloat)height andIndexPath:(NSIndexPath *)indexPath;


/**
 * 点击UICollectionViewCell的代理方法
 */
- (void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath withContent:(NSString *)content;
@end

@interface FMMineReviewTableViewCell : UITableViewCell


@property (nonatomic, weak) id<FMMineReviewTableViewCellDelegate> delegate;
@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, strong) NSIndexPath *indexPath;

/// 标题
@property (nonatomic, strong) UILabel *titleLabel;
/// 头像
@property (nonatomic, strong) UIImageView *imagesView;
/// 昵称
@property (nonatomic, strong) UILabel *nicknameLabel;
/// 时间
@property (nonatomic, strong) UILabel *datetimeLabel;

/// 是否被通过
@property (nonatomic, strong) UILabel *isThroughLabel;
/// 删除按钮
@property (nonatomic, strong) UIButton *delButton;

/// 回复区域
@property (nonatomic, strong) UIView *dynamicContainerView;
/// 回复前面的图标
@property (nonatomic, strong) UIImageView *replyImagesView;
/// 回复提示
@property (nonatomic, strong) UILabel *replyLabel;
/// 回复的内容
@property (nonatomic, strong) SCVerticallyAlignedLabel *replyContentLabel;
/// 回复的内容
@property (nonatomic, strong) UILabel *replyDatetimeLabel;

/// 顶部分割线
@property (nonatomic, strong) UIView *replyLineView;

@property (nonatomic, strong) MineReviewListModel *model;

@end
