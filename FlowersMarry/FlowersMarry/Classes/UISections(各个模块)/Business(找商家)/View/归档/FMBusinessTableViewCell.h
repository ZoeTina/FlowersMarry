//
//  FMBusinessTableViewCell.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/6/27.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SCStartRating.h"
@interface FMBusinessTableViewCell : UITableViewCell


@property (nonatomic, strong) SCStartRating *stratingView;

/// 标题
@property (nonatomic, strong) UILabel *titleLabel;
/// 图片1
@property (nonatomic, strong) UIImageView *imagesView1;
/// 图片2
@property (nonatomic, strong) UIImageView *imagesView2;
/// 图片3
@property (nonatomic, strong) UIImageView *imagesView3;
/// 图片(保)
@property (nonatomic, strong) UIImageView *baoImagesView;
/// 图片(企\个)
@property (nonatomic, strong) UIImageView *qiImagesView;
/// 图片(推荐)
@property (nonatomic, strong) UIImageView *recommendedImagesView;

/// 图片(礼物)
@property (nonatomic, strong) UIImageView *giftImagesView;
@property (nonatomic, strong) UILabel *contentLabel;

/// 星级
@property (nonatomic, strong) UILabel *scoreLabel;

/// 区域
@property (nonatomic, strong) UILabel *areaLabel;

/// 图片容器
@property (nonatomic, strong) UIView *imageContainerView;
@end
