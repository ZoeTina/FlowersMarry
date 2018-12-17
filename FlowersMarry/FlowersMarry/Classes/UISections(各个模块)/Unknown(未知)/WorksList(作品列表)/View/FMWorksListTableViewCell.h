//
//  FMWorksListTableViewCell.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/2.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMBusinessModel.h"

@interface FMWorksListTableViewCell : UITableViewCell
/// 图片(大图)
@property (nonatomic, strong) UIImageView *imagesView;
/// 图片(右上图)
@property (nonatomic, strong) UIImageView *imagesViewRightTop;
/// 图片(右下图)
@property (nonatomic, strong) UIImageView *imagesViewRightBottom;
/// 标题
@property (nonatomic, strong) UILabel *titleLabel;
/// 标题
@property (nonatomic, strong) UILabel *subtitleLabel;
/// 风格
@property (nonatomic, strong) UILabel *styleLabel;
/// 场景
@property (nonatomic, strong) UILabel *scenarioLabel;
/// 图片数量
@property (nonatomic, strong) UILabel *imagesCountLabel;
//// 浏览量
@property (nonatomic, strong) UILabel *browseLabel;

@property (nonatomic, strong) BusinessCasesModel *casesModel;
@end
