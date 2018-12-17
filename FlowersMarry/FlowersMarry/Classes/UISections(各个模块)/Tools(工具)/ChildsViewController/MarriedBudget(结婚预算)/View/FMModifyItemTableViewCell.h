//
//  FMModifyItemTableViewCell.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/10/11.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FMBudgetDetailsModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FMModifyItemTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *selectBtn;
@property (nonatomic, strong)FMBudgetDetailsModel  *model;

@end

NS_ASSUME_NONNULL_END
