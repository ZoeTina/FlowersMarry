//
//  FMTemplateSixTableViewCell.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/8/15.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FMTemplateSixTableViewCell : UITableViewCell

@property (nonatomic, assign) NSInteger indexPathRow;

/// 标题
@property (nonatomic, strong) UILabel *titleLabel;
/// 描述
@property (nonatomic, strong) UILabel *subtitleLabel;
/// 套餐Meta
@property (nonatomic, strong) BusinessTaoxiMetaModel *metaModel;
@end
