//
//  FMBudgetDetailsTableViewCell.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/10/10.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FMBudgetDetailsTableViewCell : UITableViewCell<UITextFieldDelegate>

@property (nonatomic, strong) UIImageView *imagesView;
@property (nonatomic, strong) UILabel *iconLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIButton *editButton;


@end

NS_ASSUME_NONNULL_END
