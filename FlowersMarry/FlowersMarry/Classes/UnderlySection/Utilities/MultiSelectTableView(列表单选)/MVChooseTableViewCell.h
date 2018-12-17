//
//  MVChooseTableViewCell.h
//  MerchantVersion
//
//  Created by 寜小陌 on 2018/3/2.
//  Copyright © 2018年 寜小陌. All rights reserved.
//



#import <UIKit/UIKit.h>

@interface MVChooseTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *selectBtn;
@property (nonatomic, assign) BOOL isSelected;
- (void) updateCellWithState:(BOOL)select;

@end
