//
//  FMActivityWebViewCell.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/10/23.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class FMActivityWebViewCell;
@protocol HuodongWebViewCellDelegate<NSObject>

- (void)webViewDidFinishLoad:(CGFloat)webHeight cellIndex:(NSInteger)index;
/**
 * 动态改变UITableViewCell的高度
 */
- (void)updateTableViewCellHeight:(FMActivityWebViewCell *)cell andheight:(CGFloat)height andIndexPath:(NSIndexPath *)indexPath;
@end
@interface FMActivityWebViewCell : UITableViewCell
@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic,weak) id<HuodongWebViewCellDelegate>delegate;
//@property (nonatomic, assign) NSInteger indexPath;
- (void)refreshWebView:(NSString *)hd_content indexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
