//
//  FMTemplateOneTableViewCell.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/6.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FMTemplateOneTableViewCell : UITableViewCell

/// 标题
@property (nonatomic, strong) UILabel *titleLabel;
/// 副标题
@property (nonatomic, strong) UILabel *subtitleLabel;
/// 风格
@property (nonatomic, strong) UILabel *styleLabel;
/// 场景
@property (nonatomic, strong) UILabel *scenarioLabel;
/// 价格
@property (nonatomic, strong) UILabel *priceLabel;
/// 参考价
@property (nonatomic, strong) UILabel *priceTextLabel;
//// 浏览量
@property (nonatomic, strong) UILabel *browseLabel;

/// 分割线
@property (nonatomic, strong) UIView *linerView;
@property (nonatomic, strong) BusinessCasesModel *casesModel;

@end
