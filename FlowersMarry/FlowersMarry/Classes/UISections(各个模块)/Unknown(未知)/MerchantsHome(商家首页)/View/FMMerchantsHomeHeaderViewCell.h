//
//  FMMerchantsHomeHeaderViewCell.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/2.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FMMerchantsHomeHeaderViewCell;
@protocol FMMerchantsHomeHeaderViewCellDelegate <NSObject>

/**
 * 点击UICollectionViewCell的代理方法
 */
- (void)didSelectSecurityItemAtIndexPath:(NSIndexPath *)indexPath withContent:(NSString *)content;
@end

@interface FMMerchantsHomeHeaderViewCell : UITableViewCell

/// 标题
@property (nonatomic, strong) UILabel *titleLabel;
/// 图片
@property (nonatomic, strong) UIImageView *imagesView;
/// 分数
@property (nonatomic, strong) UILabel *scoreLabel;
/// 图片(保)
@property (nonatomic, strong) UIImageView *baoImagesView;
/// 图片(企\个)
@property (nonatomic, strong) UIImageView *qiImagesView;
/// 图片(推荐)
@property (nonatomic, strong) UIImageView *recommendedImagesView;

@property (nonatomic, strong) BusinessModel *businessModel;

@property (nonatomic, weak) id<FMMerchantsHomeHeaderViewCellDelegate> delegate;

@end
