//
//  FMHotsCityTableViewCell.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/8/1.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMSelectedCityModel.h"

@class FMHotsCityTableViewCell;
@protocol FMHotsCityTableViewCellDelegate <NSObject>

/**
 * 动态改变UITableViewCell的高度
 */
- (void)updateTableViewCellHeight:(FMHotsCityTableViewCell *)cell andheight:(CGFloat)height andIndexPath:(NSIndexPath *)indexPath;


/**
 * 点击UICollectionViewCell的代理方法
 */
- (void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath withContent:(NSString *)content;
@end


@interface FMHotsCityTableViewCell : UITableViewCell

@property (nonatomic, weak) id<FMHotsCityTableViewCellDelegate> delegate;

@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSMutableArray<CityModel *> *hotsModel;

@end
