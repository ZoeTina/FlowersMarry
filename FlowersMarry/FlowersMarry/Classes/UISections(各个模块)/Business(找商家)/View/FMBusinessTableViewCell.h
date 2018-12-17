//
//  FMBusinessTableViewCell.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/6/27.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMBusinessModel.h"

@class FMBusinessTableViewCell;
@protocol FMBusinessTableViewCellDelegate <NSObject>

/**
 * 点击UICollectionViewCell的代理方法
 */
//- (void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath withContent:(NSString *)content;
- (void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath withCasesModel:(BusinessCasesModel *)model;


@end

@interface FMBusinessTableViewCell : UITableViewCell

@property (nonatomic, weak) id<FMBusinessTableViewCellDelegate> delegate;

@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) BusinessModel *businessModel;

/// 标题
@property (nonatomic, strong) UILabel *titleLabel;
/// 图片(保)
@property (nonatomic, strong) UIImageView *baoImagesView;
/// 图片(企\个)
@property (nonatomic, strong) UIImageView *qiImagesView;
/// 图片(推荐)
@property (nonatomic, strong) UIImageView *recommendedImagesView;

/// 图片(礼物)
@property (nonatomic, strong) UIImageView *giftImagesView;
@property (nonatomic, strong) UILabel *contentLabel;

/// 星级
@property (nonatomic, strong) UILabel *scoreLabel;

/// 区域
@property (nonatomic, strong) UILabel *areaLabel;


/**
 添加相应的子控件
 */
-(void)setupSubviews;

/**
 控件布局，子类实现
 */
-(void)addLayoutSubViews;

/**
 更新控件约束，子类实现
 */
-(void)updateLayoutSubViews;

@end
