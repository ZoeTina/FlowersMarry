//
//  FMEvaluationTemplateTableViewCell.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/20.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCStartRating.h"
#import "FMEvaluationModel.h"

@class FMEvaluationTemplateTableViewCell;
@protocol FMEvaluationTemplateTableViewCellDelegate <NSObject>

/**
 * 点击UICollectionViewCell的代理方法
 */
- (void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath withContent:(NSString *)content;
@end


@interface FMEvaluationTemplateTableViewCell : UITableViewCell


@property (nonatomic, strong) EvaluationModel *model;

@property (nonatomic, weak) id<FMEvaluationTemplateTableViewCellDelegate> delegate;


/// 标题
@property (nonatomic, strong) UILabel *titleLabel;
/// 头像
@property (nonatomic, strong) UIImageView *imagesView;
/// 昵称
@property (nonatomic, strong) UILabel *nicknameLabel;
/// 时间
@property (nonatomic, strong) UILabel *datetimeLabel;
@property (nonatomic, strong) SCStartRating *startRating;

/// 回复内容View
@property (nonatomic, strong) UIView *replyView;
/// 回复内容
@property (nonatomic, strong) UILabel *replyLabel;
/// 回复前面的图标
@property (nonatomic, strong) UIImageView *replyImagesView;


@property (nonatomic, assign) NSInteger idx;
//// 图片数量
@property (nonatomic, assign) NSInteger imagesCount;
@property (nonatomic,strong) UICollectionView * collectionView;
@end
