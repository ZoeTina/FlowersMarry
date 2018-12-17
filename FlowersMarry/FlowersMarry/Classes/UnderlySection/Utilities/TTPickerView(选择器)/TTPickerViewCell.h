//
//  TTPickerViewCell.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/11/9.
//  Copyright © 2018 宁小陌. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TTPickerViewCell : UITableViewCell
@property (nonatomic, assign) BOOL isNeed;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, assign) BOOL isNext;
@end

NS_ASSUME_NONNULL_END
