//
//  FMToolsTopCollectionViewCell.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/9/25.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FMToolsTopCollectionViewCell : UICollectionViewCell
/// 标题
@property (nonatomic, strong) UILabel *titleLabel;
/// 按钮
@property (nonatomic, strong) UIButton *button;
/// 副标题
@property (nonatomic, strong) UILabel *subtitleLabel;
@end

NS_ASSUME_NONNULL_END
