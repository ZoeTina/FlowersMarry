//
//  FMMineTableViewCell.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/4.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMPersonModel.h"
@interface FMMineTableViewCell : UITableViewCell
@property(nonatomic, strong) FMPersonModel* personModel;
@property(nonatomic, strong) UIImageView* imagesView;
@property(nonatomic, strong) UILabel* titleLabel;
@property(nonatomic, strong) UILabel* subtitleLabel;
@property(nonatomic, strong) UIImageView* imagesArrow;

@end
