//
//  FMRecommendBusinessCollectionViewCell.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/17.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FMRecommendBusinessCollectionViewCell : UICollectionViewCell

/// 标题
@property (nonatomic, strong) UILabel *titleLabel;
/// 播放图片
@property (nonatomic, strong) UIImageView *imagesPlay;
/// 背景图
@property (nonatomic, strong) UIImageView *imagesView;
/// 图片数量
@property (strong, nonatomic) UIButton *imagesCountButton;

@end
