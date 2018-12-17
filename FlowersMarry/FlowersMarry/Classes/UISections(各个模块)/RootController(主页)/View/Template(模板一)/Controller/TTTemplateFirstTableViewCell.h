//
//  FMTemplateFirstTableViewCell.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/12/7.
//  Copyright © 2018 宁小陌. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class TTTemplateFirstTableViewCell;
@protocol TTTemplateFirstTableViewCellDelegate <NSObject>

/**
 * 动态改变UITableViewCell的高度
 */
- (void)updateTableViewCellHeight:(TTTemplateFirstTableViewCell *)cell andheight:(CGFloat)height andIndexPath:(NSIndexPath *)indexPath;


/**
 * 点击UICollectionViewCell的代理方法
 */
- (void)didToolsSelectItemAtIndexPath:(NSIndexPath *)indexPath withContent:(NSString *)content;
@end


@interface TTTemplateFirstTableViewCell : UITableViewCell

@property (nonatomic, weak) id<TTTemplateFirstTableViewCellDelegate> delegate;

@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

NS_ASSUME_NONNULL_END
