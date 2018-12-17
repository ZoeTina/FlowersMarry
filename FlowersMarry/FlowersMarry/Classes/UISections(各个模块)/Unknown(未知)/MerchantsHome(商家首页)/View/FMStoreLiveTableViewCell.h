//
//  FMStoreLiveTableViewCell.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/19.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMBusinessModel.h"

@class FMStoreLiveTableViewCell;
@protocol FMStoreLiveTableViewCellDelegate <NSObject>

/**
 * 点击UICollectionViewCell的代理方法
 */
- (void)didSelectStoreLiveItemAtIndexPath:(NSIndexPath *)indexPath;
@end
@interface FMStoreLiveTableViewCell : UITableViewCell

@property (nonatomic, weak) id<FMStoreLiveTableViewCellDelegate> delegate;

@property (nonatomic, strong) NSMutableArray<BusinessCasesPhotoModel *> *listModel;

@end
