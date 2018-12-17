//
//  FMEvaluationTemplateThreeTableViewCell.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/8/22.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCStartRating.h"
#import "FMBusinessModel.h"
@class FMEvaluationTemplateThreeTableViewCell;
@protocol FMEvaluationTemplateThreeTableViewCellDelegate <NSObject>

/**
 * 点击UICollectionViewCell的代理方法
 */
- (void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath withContent:(NSString *)content;
@end

@interface FMEvaluationTemplateThreeTableViewCell : UITableViewCell
/// 标题
@property (nonatomic, strong) UILabel *titleLabel;
/// 头像
@property (nonatomic, strong) FLAnimatedImageView *imagesView;
/// 昵称
@property (nonatomic, strong) UILabel *nicknameLabel;
/// 时间
@property (nonatomic, strong) UILabel *datetimeLabel;
@property (nonatomic, strong) SCStartRating *startRating;
@property (nonatomic, strong) BusinessComment *evaluationModel;

/// 图片
@property (nonatomic,strong) UICollectionView * collectionView;

@property (nonatomic, weak) id<FMEvaluationTemplateThreeTableViewCellDelegate> delegate;
@end
