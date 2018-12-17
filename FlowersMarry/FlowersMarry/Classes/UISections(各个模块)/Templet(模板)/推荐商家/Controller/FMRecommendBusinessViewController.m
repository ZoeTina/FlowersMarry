//
//  FMRecommendBusinessViewController.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/17.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMRecommendBusinessViewController.h"
#import "FMRecommendBusinessModel.h"
#import "FMRecommendBusinessCollectionViewCell.h"

static NSString * const reuseIdentifier = @"FMRecommendBusinessCollectionViewCell";

@interface FMRecommendBusinessViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, strong) NSMutableArray *itemModelArray;

@end

@implementation FMRecommendBusinessViewController

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        self.contentView.backgroundColor = kColorWithRGB(16, 16, 16);
        [self setupUI];
        [self initConstraints];
    }
    return self;
}

- (void)setDynamicModel:(DynamicModel *)dynamicModel{
    _dynamicModel = dynamicModel;
    self.itemModelArray = self.dynamicModel.list;
    TTLog(@"selft -  ^%ld",self.itemModelArray.count);
}

- (void)setupUI {
    [self addSubview:self.collectionView];
}

- (void) initConstraints{
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.top.mas_equalTo(kNavBarHeight);
        CGFloat height = 49+kSafeAreaBottomHeight;
        make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-height);
    }];
}

#pragma mark ---- UICollectionViewDataSource
// MARK:- ====UICollectionViewDataSource,UICollectionViewDelegate=====
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

//每个分区有多少个数据
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.itemModelArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FMRecommendBusinessCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    DynamicModel *model = self.itemModelArray[indexPath.row];
    /// 类型: 1:图文 2:图集 3:视频
    if (model.shape==1) {
        cell.imagesCountButton.hidden = NO;
    }else{
        cell.imagesPlay.hidden = NO;
    }
    cell.titleLabel.text = model.title;
    CGFloat item = 2;
    CGFloat spacing = 5.0;
    CGFloat margin = 15.0*2;
    CGFloat width = (kScreenWidth-IPHONE6_W(margin)-IPHONE6_W(spacing))/item;
    NSString *URLString = [SCSmallTools imageTailoring:model.thumb1 width:width height:IPHONE6_W(105)];
    [cell.imagesView sd_setImageWithURL:kGetImageURL(URLString) placeholderImage:kGetImage(imagePlaceholder)];
    return cell;
}

/// 点击collectionViewCell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

//布局协议对应的方法实现
#pragma mark - UICollectionViewDelegateFlowLayout
//设置每个一个Item（cell）的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat item = 2;
    CGFloat spacing = 5.0;
    CGFloat margin = 15.0*2;
    CGFloat width = (kScreenWidth-IPHONE6_W(margin)-IPHONE6_W(spacing))/item;
    return CGSizeMake(width, IPHONE6_W(158));
}

//设置所有的cell组成的视图与section 上、左、下、右的间隔（设置边距）
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(0,15,0,15);
}


- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        //确定滚动方向
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        //确定item的大小
        //        flowLayout.itemSize = CGSizeMake(100, 120);
        //确定横向间距(设置行间距)
        flowLayout.minimumLineSpacing = 5;
        //确定纵向间距(设置列间距)
        flowLayout.minimumInteritemSpacing = 5;
        //确定距离上左下右的距离
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        //头尾部高度
        flowLayout.headerReferenceSize = CGSizeMake(0, 0);
        flowLayout.footerReferenceSize = CGSizeMake(0, 0);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:[FMRecommendBusinessCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.bounces = YES;
    }
    return _collectionView;
}

- (NSMutableArray *)itemModelArray{
    if (!_itemModelArray) {
        _itemModelArray = [[NSMutableArray alloc] init];
        //        _itemModelArray = [FMMineConventionModel getModelData];
    }
    return _itemModelArray;
}

@end
