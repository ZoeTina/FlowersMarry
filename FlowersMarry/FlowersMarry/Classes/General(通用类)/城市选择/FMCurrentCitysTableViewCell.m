//
//  FMCurrentCitysTableViewCell.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/8/1.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMCurrentCitysTableViewCell.h"
#import "FMCityCollectionViewCell.h"
static NSString* reuseIdentifier = @"FMCityCollectionViewCell";

@interface FMCurrentCitysTableViewCell()<UICollectionViewDelegate, UICollectionViewDataSource>

@property(nonatomic,strong)UICollectionView * collectionView;

/// 记录最后的height
@property (nonatomic, assign) CGFloat endHeight;

@end
@implementation FMCurrentCitysTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setCurrentModel:(CityModel *)currentModel{
    _currentModel = currentModel;
    [self reloadView];
}

- (void)setHotsModel:(NSMutableArray<CityModel *> *)hotsModel{
    _hotsModel = hotsModel;
    AppDelegate* delegate = (AppDelegate*)kAppDelegate;
    [delegate jumpMainVC];
    [delegate openTencentLocation];
    [self reloadView];
}



- (void)setIsIcon:(BOOL)isIcon{
    _isIcon = isIcon;
}

- (void) reloadView{
    [self initView];
    [self.collectionView reloadData];
}

- (void) initView{
    [self addSubview:self.collectionView];
    self.collectionView.frame = CGRectMake(0, 0, kScreenWidth-34, self.height);
}

// MARK:- ====UICollectionViewDataSource,UICollectionViewDelegate=====
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

//每个分区有多少个数据
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.isIcon) {
        return 1;
    }
    return self.hotsModel.count>9?9:self.hotsModel.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FMCityCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.isIcon = self.isIcon;
    if (self.isIcon) {
        // 需要重新定位
        cell.currentCityStr = kUserInfo.cityName;
    }else{
        CityModel *model = self.hotsModel[indexPath.row];
        cell.currentCityStr = model.site_name;
    }
    [self updateCollectionViewHeight:self.collectionView.collectionViewLayout.collectionViewContentSize.height];
    return cell;
}

/// 点击collectionViewCell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSString *didStr = @"";
    if (self.isIcon) {
    }else{
        CityModel *model = self.hotsModel[indexPath.row];
        didStr = model.site_name;
        
        kUserInfo.cityName = model.site_name;
        kUserInfo.site_id = model.site_id;
        kUserInfo.city_id = model.city_id;
    }
    [kUserInfo dump];

    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectItemAtIndexPath:withContent:)]) {
        [self.delegate didSelectItemAtIndexPath:indexPath withContent:didStr];
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

// 布局协议对应的方法实现
#pragma mark - UICollectionViewDelegateFlowLayout
// 设置footer呈现的size, 如果布局是垂直方向的话，size只需设置高度，宽与collectionView一致
// 设置section header大小
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
        [_collectionView registerClass:[FMCityCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
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
