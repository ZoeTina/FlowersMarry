//
//  TTTemplateThreeTableViewCell.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/12/10.
//  Copyright © 2018 宁小陌. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class TTTemplateThreeTableViewCell;
@protocol TTTemplateThreeTableViewCellDelegate <NSObject>

/**
 * 点击UICollectionViewCell的代理方法
 */
- (void)didRecommendVideoSelectItemAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface TTTemplateThreeTableViewCell : UITableViewCell
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, weak) id<TTTemplateThreeTableViewCellDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
