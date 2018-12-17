//
//  FMTemplateThreeTableViewCell.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/12.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMFiveCellModel.h"

@interface FMTemplateThreeTableViewCell : UITableViewCell
/// 标题
@property (nonatomic, strong) UILabel *titleLabel;
/// 内容(副标题)
@property (nonatomic, strong) UILabel *subtitleLabel;
/// 价格
@property (nonatomic, strong) UILabel *priceLabel;
/// 原价
@property (nonatomic, strong) SCDeleteLineLabel *oldPriceLabel;
//// 浏览量
@property (nonatomic, strong) UILabel *browseLabel;
/// 分割线
@property (nonatomic, strong) UIView *linerView;

@property (nonatomic, strong) BusinessTaoxiModel *taoxiModel;


@end
