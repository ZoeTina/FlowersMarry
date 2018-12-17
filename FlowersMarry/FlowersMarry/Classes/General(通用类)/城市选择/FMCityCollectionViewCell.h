//
//  FMCityCollectionViewCell.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/8/2.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FMCityCollectionViewCell : UICollectionViewCell
@property (nonatomic, copy) NSString *currentCityStr;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, assign) BOOL isIcon;

@end
