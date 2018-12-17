//
//  FMHotsCityTableViewCell.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/8/1.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMHotsCityTableViewCell.h"
#import "FMTravelCollectionViewCell.h"
static NSString* reuseIdentifier = @"FMTravelCollectionViewCell";

@interface FMHotsCityTableViewCell()<UICollectionViewDelegate, UICollectionViewDataSource>
{
@private
    UICollectionView * _collectionView;
}
@property(nonatomic,strong,readonly)UICollectionView * collectionView;

/// 记录最后的height
@property (nonatomic, assign) CGFloat endHeight;

@end
@implementation FMHotsCityTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initView];
        [self.collectionView reloadData];
    }
    return self;
}

- (void) initView{
    [self addSubview:self.collectionView];
    self.collectionView.frame = CGRectMake(0, 0, kScreenWidth-34, self.height);
}

- (void)setHotsModel:(NSMutableArray<CityModel *> *)hotsModel{
    _hotsModel = hotsModel;
}

// MARK:- ====UICollectionViewDataSource,UICollectionViewDelegate=====
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

//每个分区有多少个数据
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.hotsModel.count>9?9:self.hotsModel.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FMTravelCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.backgroundColor = kColorWithRGB(246, 247, 251);
    cell.cityLabel.hidden = NO;
    CityModel *model = self.hotsModel[indexPath.row];
    cell.cityLabel.text = model.site_name;
    [self updateCollectionViewHeight:self.collectionView.collectionViewLayout.collectionViewContentSize.height];
    return cell;
}

/// 点击collectionViewCell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectItemAtIndexPath:withContent:)]) {
        [self.delegate didSelectItemAtIndexPath:indexPath withContent:self.dataArray[indexPath.section][indexPath.row]];
    }
}

/// 更新CollectionViewHeight
- (void)updateCollectionViewHeight:(CGFloat)height {
    if (self.endHeight != height) {
        self.endHeight = height;
        self.collectionView.frame = CGRectMake(0, 0, self.collectionView.width, height);
        
        if (_delegate && [_delegate respondsToSelector:@selector(updateTableViewCellHeight:andheight:andIndexPath:)]) {
            [self.delegate updateTableViewCellHeight:self andheight:height andIndexPath:self.indexPath];
        }
    }
}

//布局协议对应的方法实现
#pragma mark - UICollectionViewDelegateFlowLayout
//设置footer呈现的size, 如果布局是垂直方向的话，size只需设置高度，宽与collectionView一致
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    
    return CGSizeMake(0,0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return CGSizeMake(0,0);
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        //确定滚动方向
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        CGFloat margin = 15;
        CGFloat spacing = 10*2;
        //确定item的大小
        flowLayout.itemSize = CGSizeMake((kScreenWidth-margin-spacing-34)/3, 33);
        //确定横向间距(设置行间距)
        flowLayout.minimumLineSpacing = 10;
        //确定纵向间距(设置列间距)
        flowLayout.minimumInteritemSpacing = 10;
        //确定距离上左下右的距离
        flowLayout.sectionInset = UIEdgeInsetsMake(10,15,10,0);
        //头尾部高度
        flowLayout.headerReferenceSize = CGSizeMake(0, 0);
        flowLayout.footerReferenceSize = CGSizeMake(0, 0);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:[FMTravelCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.bounces = YES;
        self.layer.shouldRasterize = YES;
        self.layer.rasterizationScale = kScreenScale;
        self.layer.drawsAsynchronously = YES;
    }
    return _collectionView;
}

@end
