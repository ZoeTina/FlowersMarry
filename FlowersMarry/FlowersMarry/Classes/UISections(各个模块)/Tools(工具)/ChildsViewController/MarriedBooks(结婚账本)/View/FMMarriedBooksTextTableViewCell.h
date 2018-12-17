//
//  FMMarriedBooksTextTableViewCell.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/9/28.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FMMarriedBooksTextTableViewCell : UITableViewCell
/// 竖线
@property (nonatomic, strong) UIView *linerView;
/// 圆点
@property (nonatomic, strong) UIView *dotView;
/// 图片
@property (nonatomic, strong) UIImageView *imagesView;
/// t标题
@property (nonatomic, strong) UILabel *titleLabel;
/// 副标题
@property (nonatomic, strong) UILabel *subtitleLabel;
/// 日期时间
@property (nonatomic, strong) UILabel *timeLabel;
/// 备注
@property (nonatomic, strong) UILabel *remarkLabel;
/// 备注
@property (nonatomic, strong) UILabel *priceLabel;

@end

NS_ASSUME_NONNULL_END
