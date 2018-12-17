//
//  SCPublishBaseController.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/8/9.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "MVBaseViewController.h"

@interface SCPublishBaseController : MVBaseViewController

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign) CGFloat collectionFrameY;
/// 选择的图片数据
@property(nonatomic,strong) NSMutableArray *arrSelected;
/// 方形压缩图image 数组
@property(nonatomic,strong) NSMutableArray * imageArray;
/// collectionView所在view
@property(nonatomic,strong) UIView *showInView;

@property(nonatomic,strong) NSMutableArray *selectedPhotos;
@property(nonatomic,strong) NSMutableArray *selectedAssets;
@end
