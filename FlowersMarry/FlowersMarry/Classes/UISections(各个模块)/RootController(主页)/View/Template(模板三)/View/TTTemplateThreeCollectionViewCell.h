//
//  TTTemplateThreeCollectionViewCell.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/12/10.
//  Copyright © 2018 宁小陌. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TTTemplateThreeCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *imagesView;
@property (nonatomic, strong) UIImageView *imagesPlay;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) DynamicModel *dynamicModel;
@end

NS_ASSUME_NONNULL_END
