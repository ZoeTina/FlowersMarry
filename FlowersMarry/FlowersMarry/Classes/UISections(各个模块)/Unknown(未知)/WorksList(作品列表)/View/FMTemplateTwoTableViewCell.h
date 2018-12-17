//
//  FMTemplateTwoTableViewCell.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/6.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCStartRating.h"

@interface FMTemplateTwoTableViewCell : UITableViewCell

/// 标题
@property (nonatomic, strong) UILabel *titleLabel;
//// 星星分数
@property (nonatomic, strong) UILabel *scoreLabel;
/// 图片
@property (nonatomic, strong) UIImageView *imagesView;

/// 保
@property (nonatomic, strong) UIImageView *baoImages;
/// 个\企
@property (nonatomic, strong) UIImageView *enterpriseImages;
/// 推荐
@property (nonatomic, strong) UIImageView *recommendImages;
/// 标签
@property (nonatomic, strong) SCCustomMarginLabel *tagLabel;

/// 关注按钮
@property (nonatomic, strong) UIButton *guanzhuButton;
@property (nonatomic, strong) SCStartRating *startRating;
@property (nonatomic, strong) BusinessModel *businessModel;

@end
