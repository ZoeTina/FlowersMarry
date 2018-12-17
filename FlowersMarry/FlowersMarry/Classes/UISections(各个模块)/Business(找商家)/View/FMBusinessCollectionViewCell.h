//
//  FMBusinessCollectionViewCell.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/24.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "FMBusinessModel.h"
@interface FMBusinessCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) SCCustomMarginLabel *titleLabel;
@property (nonatomic, strong) UIImageView *imagesView;
@property (nonatomic, strong) BusinessCasesModel *model;

@end
