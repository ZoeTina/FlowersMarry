//
//  FMViewForHeaderInSectionTableViewCell.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/6/29.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FMViewForHeaderInSectionTableViewCell : UITableViewCell
/// 前面竖线
@property (nonatomic, strong) UIView *lineView;
/// 显示的标题
@property (nonatomic, strong) UILabel *titleLabel;
/// 横向的标题
@property (nonatomic, strong) UIView *linesView;
/// 右边的副标题
@property (nonatomic, strong) UILabel *subtitleLabel;
@end
