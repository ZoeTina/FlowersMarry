//
//  FMCurrentCitysTableViewCell.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/8/1.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMSelectedCityModel.h"

@class FMCurrentCitysTableViewCell;
@protocol FMCurrentCitysTableViewCellDelegate <NSObject>

/**
 * 动态改变UITableViewCell的高度
 */
- (void)updateTableViewCellHeight:(FMCurrentCitysTableViewCell *)cell andheight:(CGFloat)height andIndexPath:(NSIndexPath *)indexPath;


/**
 * 点击UICollectionViewCell的代理方法
 */
- (void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath withContent:(NSString *)content;
@end


@interface FMCurrentCitysTableViewCell : UITableViewCell

@property (nonatomic, weak) id<FMCurrentCitysTableViewCellDelegate> delegate;

@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, assign) BOOL isIcon;
@property (nonatomic, strong) CityModel *currentModel;
@property (nonatomic, strong) NSMutableArray<CityModel *> *hotsModel;
@end
