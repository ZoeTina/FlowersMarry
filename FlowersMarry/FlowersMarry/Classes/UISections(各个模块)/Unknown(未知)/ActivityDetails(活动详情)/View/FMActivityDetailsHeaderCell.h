//
//  FMActivityDetailsHeaderCell.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/11.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FMActivityDetailsHeaderCell : UITableViewCell


/// 活动标题
@property (nonatomic, strong) UILabel *titleLabel;
/// 倒计时
@property (nonatomic, strong) UILabel *timeLabel;
//// 浏览量
@property (nonatomic, strong) UILabel *browseLabel;
/// 倒计时图标
@property (nonatomic, strong) UIImageView *timeimages;

/// 分割线
@property (nonatomic, strong) UIView *linesView;

@property (nonatomic, strong) BusinessHuodongModel *huodongModel;
@end
