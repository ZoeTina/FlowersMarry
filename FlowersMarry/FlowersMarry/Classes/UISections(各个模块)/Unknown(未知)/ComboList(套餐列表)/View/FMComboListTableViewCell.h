//
//  FMComboListTableViewCell.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/2.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FMComboListTableViewCell : UITableViewCell

/// 图片
@property (nonatomic, strong) UIImageView *imagesView;
/// 标题
@property (nonatomic, strong) UILabel *titleLabel;
/// 副标题(内容)
@property (nonatomic, strong) UILabel *subtitleLabel;
/// 当前价格
@property (nonatomic, strong) UILabel *priceLabel;
/// 原价
@property (nonatomic, strong) SCDeleteLineLabel *oldPriceLabel;
//// 浏览量
@property (nonatomic, strong) UILabel *browseLabel;
/// Cell 分割线
@property (nonatomic, strong) UIView *linerViewCell;


@end
