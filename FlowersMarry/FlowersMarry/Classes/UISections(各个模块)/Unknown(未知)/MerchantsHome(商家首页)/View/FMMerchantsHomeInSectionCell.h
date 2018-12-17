//
//  FMMerchantsHomeInSectionCell.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/3.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FMMerchantsHomeInSectionCell : UITableViewCell
/// 前面竖线
@property (nonatomic, strong) UIView *lineView;
/// 显示的标题
@property (nonatomic, strong) UILabel *titleLabel;
/// 右边的副标题
@property (nonatomic, strong) UILabel *subtitleLabel;
/// 右边的箭头
@property (nonatomic, strong) UIImageView *arrowImageView;
@end
