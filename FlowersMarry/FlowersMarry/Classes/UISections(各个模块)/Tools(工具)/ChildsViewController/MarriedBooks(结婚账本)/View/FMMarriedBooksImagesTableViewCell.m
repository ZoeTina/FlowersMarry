//
//  FMMarriedBooksImagesTableViewCell.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/9/28.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMMarriedBooksImagesTableViewCell.h"
#import "FMTravelCollectionViewCell.h"

static NSString * const reuseIdentifier = @"FMTravelCollectionViewCell";

@interface FMMarriedBooksImagesTableViewCell()<UICollectionViewDelegate,UICollectionViewDataSource,
UICollectionViewDelegate,UICollectionViewDataSource>
/// 记录最后的height
@property (nonatomic, assign) CGFloat endHeight;
/// headerView的高度
@property (nonatomic, assign) CGFloat headerHeight;

@end
@implementation FMMarriedBooksImagesTableViewCell

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
        self.headerHeight = 67;
        [self initView];
        self.titleLabel.text = @"";
        self.subtitleLabel.text = @"婚宴酒店";
        self.timeLabel.text = @"2018-08-03";
        self.remarkLabel.text = @"婚宴酒席";
        self.priceLabel.text = @"￥780";
        self.imagesView.image = kGetImage(@"tools_img_hunzhao");
    }
    return self;
}

- (void) initView{
    [self addSubview:self.linerView];
    [self addSubview:self.dotView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.imagesView];
    [self addSubview:self.subtitleLabel];
    [self addSubview:self.timeLabel];
    [self addSubview:self.remarkLabel];
    [self addSubview:self.priceLabel];
    [self addSubview:self.collectionView];
    [self initViewConstraints];
    CGFloat width = kScreenWidth-121;
    self.collectionView.frame = CGRectMake(106, self.headerHeight, width, self.height+self.headerHeight);
}

/// 更新CollectionViewHeight
- (void)updateCollectionViewHeight:(CGFloat)height {
    if (self.endHeight != height) {
        self.endHeight = height;
        self.collectionView.frame = CGRectMake(106, self.headerHeight, self.collectionView.width, height);
        
        if (_delegate && [_delegate respondsToSelector:@selector(updateTableViewCellHeight:andheight:andIndexPath:)]) {
            [self.delegate updateTableViewCellHeight:self andheight:height andIndexPath:self.indexPath];
        }
    }
}

#pragma mark ---- UICollectionViewDataSource
// MARK:- ====UICollectionViewDataSource,UICollectionViewDelegate=====
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

//每个分区有多少个数据
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 7;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FMTravelCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.backgroundColor = kColorWithRGB(242, 242, 242);
    cell.containerView.hidden = NO;
    cell.linerView.hidden = YES;
    [self updateCollectionViewHeight:self.collectionView.collectionViewLayout.collectionViewContentSize.height+self.headerHeight];
    return cell;
}

/// 点击collectionViewCell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectItemAtIndexPath:withContent:)]) {
        [self.delegate didSelectItemAtIndexPath:indexPath withContent:@"网友点评"];
    }
}

//布局协议对应的方法实现
#pragma mark - UICollectionViewDelegateFlowLayout
//设置每个一个Item（cell）的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat item = 3;
    CGFloat spacing = 5.0*2;
    CGFloat width = (kScreenWidth-121-IPHONE6_W(spacing))/item;
    return CGSizeMake(width, width);
}

//设置所有的cell组成的视图与section 上、左、下、右的间隔
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(0,0,0,0);
}

- (void) initViewConstraints{
    [self.linerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(54));
        make.width.equalTo(@(0.6));
        make.bottom.top.equalTo(self);
    }];
    [self.dotView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.linerView);
        make.width.height.equalTo(@(3));
        make.top.equalTo(@(28));
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(0));
        make.right.centerY.equalTo(self.dotView);
    }];
    [self.imagesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dotView.mas_right).offset(14);
        make.centerY.equalTo(self.dotView);
    }];
    [self.subtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imagesView.mas_right).offset(13);
        make.centerY.equalTo(self.imagesView);
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.subtitleLabel);
        make.top.equalTo(self.dotView.mas_bottom).offset(8);
    }];
    [self.remarkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.timeLabel.mas_right).offset(7);
        make.centerY.equalTo(self.timeLabel);
    }];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-15);
        make.centerY.equalTo(self.titleLabel);
    }];
    
//    NSInteger idxs = (int)ceilf(5);
//    CGFloat collectionHeight = idxs*97+(5*idxs-1);
//    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.subtitleLabel);
//        make.top.equalTo(self.timeLabel.mas_bottom).offset(14);
//        make.height.equalTo(@(collectionHeight));
//        make.bottom.equalTo(self.mas_bottom).offset(-14);
//    }];
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
        [_collectionView registerClass:[FMTravelCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.bounces = YES;
    }
    return _collectionView;
}


- (UIView *)linerView{
    if (!_linerView) {
        _linerView = [UIView lz_viewWithColor:HexString(@"#FFEFF1")];
    }
    return _linerView;
}

- (UIView *)dotView{
    if (!_dotView) {
        _dotView = [UIView lz_viewWithColor:HexString(@"#FF4163")];
        [_dotView lz_setCornerRadius:1.5];
    }
    return _dotView;
}

- (UIImageView *)imagesView{
    if (!_imagesView) {
        _imagesView = [[UIImageView alloc] init];
    }
    return _imagesView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel lz_labelWithTitle:@"" color:HexString(@"#666666") font:kFontSizeMedium12];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}
- (UILabel *)subtitleLabel{
    if (!_subtitleLabel) {
        _subtitleLabel = [UILabel lz_labelWithTitle:@"" color:HexString(@"#333333") font:kFontSizeMedium14];
    }
    return _subtitleLabel;
}

- (UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [UILabel lz_labelWithTitle:@"" color:HexString(@"#999999") font:kFontSizeMedium12];
    }
    return _timeLabel;
}

- (UILabel *)remarkLabel{
    if (!_remarkLabel) {
        _remarkLabel = [UILabel lz_labelWithTitle:@"" color:HexString(@"#999999") font:kFontSizeMedium12];
    }
    return _remarkLabel;
}

- (UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel = [UILabel lz_labelWithTitle:@"" color:HexString(@"#FF4163") font:kFontSizeMedium14];
    }
    return _priceLabel;
}

@end
