//
//  FMShowPhotoCollectionViewCell.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/6/28.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FMShowPhotoCollectionViewCell : UICollectionViewCell
@property (nonatomic, weak, readonly) UILabel *label;
@property (nonatomic, strong) UIImageView *imagesView;

@property (nonatomic, strong) DynamicGalleryModel *galleryModel;


@end
