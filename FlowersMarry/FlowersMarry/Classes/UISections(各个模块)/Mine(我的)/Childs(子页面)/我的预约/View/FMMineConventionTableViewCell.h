//
//  FMMineConventionTableViewCell.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/13.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMMineConventionModel.h"

@interface FMMineConventionTableViewCell : UITableViewCell

/// 标题
@property (nonatomic, strong) UILabel *titleLabel;
/// 图片
@property (nonatomic, strong) UIImageView *imagesView;
/// 预约电话
@property (nonatomic, strong) UILabel *telLabel;
/// 预约日期
@property (nonatomic, strong) UILabel *dateLabel;
/// 是否确定
@property (nonatomic, strong) UILabel *determinedLabel;

/// 容器
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) ConventionListData *listData;


@end
