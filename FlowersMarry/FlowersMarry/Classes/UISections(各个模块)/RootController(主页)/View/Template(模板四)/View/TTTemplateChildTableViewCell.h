//
//  TTTemplateChildTableViewCell.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/12/12.
//  Copyright © 2018 宁小陌. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class TTTemplateChildTableViewCell;
@protocol TTTemplateChildTableViewCellDelegate <NSObject>

/**
 * 点击UICollectionViewCell的代理方法
 */
//- (void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath withContent:(NSString *)content;
- (void)didSelectChildItemAtIndexPath:(NSIndexPath *)indexPath withCasesModel:(BusinessCasesModel *)model;


@end

@interface TTTemplateChildTableViewCell : UITableViewCell
/// 标题
@property (nonatomic, strong) UILabel *titleLabel;
/// 评论数量
@property (nonatomic, strong) UILabel *commentCountLabel;
/// 风格
@property (nonatomic, strong) UILabel *styleLabel;
/// 价格
@property (nonatomic, strong) UILabel *priceLabel;

@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, weak) id<TTTemplateChildTableViewCellDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
