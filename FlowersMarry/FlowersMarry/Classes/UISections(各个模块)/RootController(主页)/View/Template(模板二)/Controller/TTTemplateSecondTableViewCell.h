//
//  TTTemplateSecondTableViewCell.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/12/7.
//  Copyright © 2018 宁小陌. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class TTTemplateSecondTableViewCell;
@protocol TTTemplateSecondTableViewCellDelegate <NSObject>

/**
 * 动态改变UITableViewCell的高度
 */
- (void)updateSecondTableViewCellHeight:(TTTemplateSecondTableViewCell *)cell andheight:(CGFloat)height andIndexPath:(NSIndexPath *)indexPath;


/**
 * 点击UICollectionViewCell的代理方法
 */
- (void)didHotCitySelectItemAtIndexPath:(NSIndexPath *)indexPath;
@end


@interface TTTemplateSecondTableViewCell : UITableViewCell

@property (nonatomic, weak) id<TTTemplateSecondTableViewCellDelegate> delegate;

@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) NSArray *dataArray;

@end
NS_ASSUME_NONNULL_END
