//
//  FMBasicInformationTextFieldCell.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/11/6.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FMBasicInformationTextFieldCell : UITableViewCell<UITextFieldDelegate>

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextField *textField;

@end

NS_ASSUME_NONNULL_END
