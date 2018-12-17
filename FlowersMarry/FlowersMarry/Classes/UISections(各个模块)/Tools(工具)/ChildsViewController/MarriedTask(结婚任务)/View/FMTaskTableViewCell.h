//
//  FMTaskTableViewCell.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/10/13.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FMTaskTableViewCell : UITableViewCell
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *selectBtn;
@property (nonatomic, strong) UILabel *subtitleLabel;
@property (nonatomic, strong) UIImageView *imagesArrow;
@property (nonatomic, strong) UIButton *tagButton;
@end

NS_ASSUME_NONNULL_END
