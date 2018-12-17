//
//  FMPersonalTableViewCell.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/9.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMPersonModel.h"

@interface FMPersonalTableViewCell : UITableViewCell


@property (strong, nonatomic) UILabel       *titleLabel;
@property (strong, nonatomic) UILabel       *contentLabel;
@property (strong, nonatomic) UILabel       *subtitleLable;
@property (strong, nonatomic) UIImageView       *arrowImageView;

@property(nonatomic, strong) FMPersonModel* personModel;

@end
