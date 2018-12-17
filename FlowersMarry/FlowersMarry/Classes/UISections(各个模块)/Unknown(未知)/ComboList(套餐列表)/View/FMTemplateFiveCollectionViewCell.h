//
//  FMTemplateFiveCollectionViewCell.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/13.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FMFiveCellModel.h"
@interface FMTemplateFiveCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *imagesView;
@property (nonatomic, strong) UIView *linerView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *subtitleLabel;

@property (nonatomic, strong) FMFiveCellModel *fiveModel;

@end
