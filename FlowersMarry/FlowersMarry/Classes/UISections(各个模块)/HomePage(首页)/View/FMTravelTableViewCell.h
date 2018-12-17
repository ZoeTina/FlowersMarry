//
//  FMTravelTableViewCell.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/5.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <UIKit/UIKit.h>


@class FMTravelTableViewCell;
@protocol FMTravelTableViewCellDelegate <NSObject>

/**
 * 动态改变UITableViewCell的高度
 */
- (void)updateTableViewCellHeight:(FMTravelTableViewCell *)cell andheight:(CGFloat)height andIndexPath:(NSIndexPath *)indexPath;


/**
 * 点击UICollectionViewCell的代理方法
 */
- (void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath withContent:(NSString *)content;
@end


@interface FMTravelTableViewCell : UITableViewCell

@property (nonatomic, weak) id<FMTravelTableViewCellDelegate> delegate;

@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) NSArray *dataArray;

@end
