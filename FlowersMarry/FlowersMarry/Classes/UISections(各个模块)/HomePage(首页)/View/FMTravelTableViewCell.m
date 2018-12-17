//
//  FMTravelTableViewCell.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/5.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMTravelTableViewCell.h"
#import "FMTravelCollectionViewCell.h"
static NSString* reuseIdentifier = @"FMTravelCollectionViewCell";

@interface FMTravelTableViewCell()<UICollectionViewDelegate, UICollectionViewDataSource>
{
@private
    UICollectionView * _collectionView;
    UIImageView * _iconImageView;
    UILabel * _titleLabel;
}
@property(nonatomic,strong,readonly)UICollectionView * collectionView;
@property(nonatomic,strong,readonly)UIImageView * iconImageView;
@property(nonatomic,strong,readonly)UILabel * titleLabel;

/// 记录最后的height
@property (nonatomic, assign) CGFloat endHeight;
/// headerView的高度
@property (nonatomic, assign) CGFloat headerHeight;

@end
@implementation FMTravelTableViewCell

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
        [self initView];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.headerHeight = 38;
    }
    return self;
}

- (void) initView{
    [self addSubview:self.iconImageView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.collectionView];
    self.collectionView.frame = CGRectMake(0, self.headerHeight, kScreenWidth, self.height+self.headerHeight);

    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(13);
        make.left.mas_equalTo(IPHONE6_W(152));
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.iconImageView);
        make.left.mas_equalTo(self.iconImageView.mas_right).mas_offset(IPHONE6_W(5));
    }];
}

// MARK:- ====UICollectionViewDataSource,UICollectionViewDelegate=====
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.dataArray.count;
}

//每个分区有多少个数据
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    NSArray *array = self.dataArray[section];
    return array.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FMTravelCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    if (indexPath.section==1) {
        cell.backgroundColor = kColorWithRGB(231, 242, 248);
        cell.cityLabel.hidden = NO;
        cell.cityLabel.text = self.dataArray[indexPath.section][indexPath.row];
    }else{
        cell.containerView.hidden = NO;
        if (indexPath.row==0) {
            cell.imagesView.image = kGetImage(@"base_home_sanya");
        }else if (indexPath.row==1) {
            cell.imagesView.image = kGetImage(@"base_home_dali");
        }
        cell.titleLabel.text = self.dataArray[indexPath.section][indexPath.row];

    }
    self.indexPath = indexPath;
    [self updateCollectionViewHeight:self.collectionView.collectionViewLayout.collectionViewContentSize.height+self.headerHeight];

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
        self.collectionView.frame = CGRectMake(0, self.headerHeight, self.collectionView.width, height);
        
        if (_delegate && [_delegate respondsToSelector:@selector(updateTableViewCellHeight:andheight:andIndexPath:)]) {
            [self.delegate updateTableViewCellHeight:self andheight:height andIndexPath:self.indexPath];
        }
    }
}

/// 同一行的cell的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

//布局协议对应的方法实现
#pragma mark - UICollectionViewDelegateFlowLayout
//设置每个一个Item（cell）的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        CGFloat margin = 15*2;
        CGFloat spacing = 3;
        return CGSizeMake((kScreenWidth-margin-spacing)/2, 100);
    }
    CGFloat margin = 15*2;
    CGFloat spacing = 5*3;
    return CGSizeMake((kScreenWidth-margin-spacing)/4, 33);
}

//设置所有的cell组成的视图与section 上、左、下、右的间隔
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if (section==0) {
        return UIEdgeInsetsMake(0,15,0,15);
    }
    return UIEdgeInsetsMake(8,15,8,15);
}

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
        //确定item的大小
//        flowLayout.itemSize = CGSizeMake(100, 120);
        //确定横向间距(设置行间距)
        flowLayout.minimumLineSpacing = 0;
        //确定纵向间距(设置列间距)
        flowLayout.minimumInteritemSpacing = 0;
        //确定距离上左下右的距离
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
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
    }
    return _collectionView;
}

//- (NSArray *)dataArray{
//    if (!_dataArray) {
////        _dataArray = @[@"厦门",@"丽江",@"大连",@"青岛"];
//        _dataArray = @[@[@"1元", @"2元", @"3元", @"4元", @"5元", @"6元"],
//                       @[@"1元", @"2元", @"3元", @"4元", @"10元", @"20元", @"30元", @"40元", @"11元", @"22元", @"33元"],
//                       @[@"100元", @"200元", @"300元", @"400元", @"10元", @"20元", @"30元", @"40元", @"11元", @"22元", @"33元",@"1元", @"2元", @"3元", @"4元", @"5元", @"6元"]];
//
//    }
//    return _dataArray;
//}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel lz_labelWithTitle:@"全球旅拍" color:kTextColor102 font:kFontSizeMedium14];
    }
    return _titleLabel;
}

- (UIImageView *)iconImageView{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.image = kGetImage(@"base_icon_plane");
    }
    return _iconImageView;
}

@end
