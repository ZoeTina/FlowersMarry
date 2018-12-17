//
//  FMTemplateSevenTableViewCell.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/10/29.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@class FMTemplateSevenTableViewCell;
@protocol FMTemplateSevenTableViewCellDelegate <NSObject>

/**
 * 动态改变UITableViewCell的高度
 */
- (void)updateTableViewCellHeight:(FMTemplateSevenTableViewCell *)cell andheight:(CGFloat)height andIndexPath:(NSIndexPath *)indexPath;


/**
 * 点击UICollectionViewCell的代理方法
 */
- (void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath withContent:(NSString *)content;
@end

@interface FMTemplateSevenTableViewCell : UITableViewCell

@property (nonatomic, weak) id<FMTemplateSevenTableViewCellDelegate> delegate;

@property (nonatomic, strong) NSIndexPath *indexPath;


@end

NS_ASSUME_NONNULL_END
