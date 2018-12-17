//
//  TTTemplateSecondTableViewCell.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/12/7.
//  Copyright © 2018 宁小陌. All rights reserved.
//

#import "TTTemplateSecondTableViewCell.h"
#import "TTTemplateSecondCollectionViewCell.h"
static NSString* reuseIdentifier = @"TTTemplateSecondCollectionViewCell";

@interface TTTemplateSecondTableViewCell()<UICollectionViewDelegate, UICollectionViewDataSource>
{
@private
    UICollectionView * _collectionView;
}
@property(nonatomic,strong,readonly)UICollectionView * collectionView;

/// 记录最后的height
@property (nonatomic, assign) CGFloat endHeight;
/// headerView的高度
@property (nonatomic, assign) CGFloat headerHeight;
/// headerView的高度
@property (nonatomic, strong) UIView *headerView;
/// headerView的高度
@property (nonatomic, strong) UILabel *headerTitle;
/// headerView的高度
@property (nonatomic, strong) UILabel *headerSubtitle;
@end
@implementation TTTemplateSecondTableViewCell

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
        
        self.headerHeight = 40;
        [self initView];
    }
    return self;
}

- (void) initView{
    [self addSubview:self.collectionView];
    
    [self addSubview:self.headerView];
    [self.headerView addSubview:self.headerTitle];
    [self.headerView addSubview:self.headerSubtitle];
    self.collectionView.frame = CGRectMake(0, self.headerHeight, kScreenWidth, self.height+self.headerHeight);

    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.equalTo(@(self.headerHeight));
    }];
    
    [self.headerTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(15));
        make.centerY.equalTo(self.headerView);
    }];
    
    [self.headerSubtitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headerTitle.mas_right).offset(7);
        make.centerY.equalTo(self.headerView);
    }];
}

// MARK:- ====UICollectionViewDataSource,UICollectionViewDelegate=====
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

//每个分区有多少个数据
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TTTemplateSecondCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.imagesView.image = kGetImage(self.dataArray[indexPath.row]);
    
    self.indexPath = indexPath;
    [self updateSecondCollectionViewHeight:self.collectionView.collectionViewLayout.collectionViewContentSize.height+self.headerHeight];
    
    return cell;
}

/// 点击collectionViewCell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didHotCitySelectItemAtIndexPath:)]) {
        [self.delegate didHotCitySelectItemAtIndexPath:indexPath];
    }
}

/// 更新CollectionViewHeight
- (void)updateSecondCollectionViewHeight:(CGFloat)height {
    if (self.endHeight != height) {
        self.endHeight = height;
        self.collectionView.frame = CGRectMake(0, self.headerHeight, self.collectionView.width, height);
        if (_delegate && [_delegate respondsToSelector:@selector(updateSecondTableViewCellHeight:andheight:andIndexPath:)]) {
            [self.delegate updateSecondTableViewCellHeight:self andheight:height andIndexPath:self.indexPath];
        }
    }
}

//布局协议对应的方法实现
#pragma mark - UICollectionViewDelegateFlowLayout
//设置每个一个Item（cell）的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat margin = 15*2;
    CGFloat spacing = 5*2;
    return CGSizeMake((kScreenWidth-margin-spacing)/3, 80);
}

//设置所有的cell组成的视图与section 上、左、下、右的间隔
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0,15,10,15);
}

//设置footer呈现的size, 如果布局是垂直方向的话，size只需设置高度，宽与collectionView一致
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    
    return CGSizeMake(0,10);
}

//设置header呈现的size, 如果布局是垂直方向的话，size只需设置高度，宽与collectionView一致
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return CGSizeMake(0,0);
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        //确定滚动方向
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        //确定item的大小
        //        flowLayout.itemSize = CGSizeMake(100, 120);
        //确定横向间距(设置行间距)
        flowLayout.minimumLineSpacing = 3;
        //确定纵向间距(设置列间距)
        flowLayout.minimumInteritemSpacing = 0;
        //确定距离上左下右的距离
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        //头尾部高度
        flowLayout.headerReferenceSize = CGSizeMake(0, 0);
        flowLayout.footerReferenceSize = CGSizeMake(0, 0);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:[TTTemplateSecondCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.bounces = YES;
    }
    return _collectionView;
}

- (NSArray *)dataArray{
    if (!_dataArray) {
        _dataArray = @[@"home_city_sanya",@"home_city_qingdao",@"home_city_xiamen",
                       @"home_city_dalian",@"home_city_lijiang",@"home_city_dali"];
    }
    return _dataArray;
}

- (UIView *)headerView{
    if (!_headerView) {
        _headerView = [UIView lz_viewWithColor:kWhiteColor];
    }
    return _headerView;
}

- (UILabel *)headerTitle {
    if (!_headerTitle) {
        _headerTitle = [UILabel lz_labelWithTitle:@"全球旅拍" color:kTextColor12 font:kFontSizeScBold17];
    }
    return _headerTitle;
}

- (UILabel *)headerSubtitle {
    if (!_headerSubtitle) {
        _headerSubtitle = [UILabel lz_labelWithTitle:@"六大热门圣地等你来" color:kTextColor153 font:kFontSizeMedium12];
    }
    return _headerSubtitle;
}
@end
