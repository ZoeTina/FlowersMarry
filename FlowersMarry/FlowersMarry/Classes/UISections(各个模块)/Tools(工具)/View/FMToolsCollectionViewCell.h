//
//  FMToolsCollectionViewCell.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/9/25.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FMToolsCollectionViewCell : UICollectionViewCell

/// 标题
@property (nonatomic, strong) UILabel *titleLabel;
/// u图标
@property (nonatomic, strong) UIImageView *imagesView;
/// 副标题
@property (nonatomic, strong) UILabel *subtitleLabel;

@end

NS_ASSUME_NONNULL_END
