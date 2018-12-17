//
//  FMPictureWithTextCellRecommended.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/6/29.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMPictureWithTextCellRecommended.h"

static NSString* resuFMRecommendedCollectionViewCell = @"FMRecommendedCollectionViewCell";

@interface FMPictureWithTextCellRecommended ()<UICollectionViewDelegate, UICollectionViewDataSource>{
@private
    UICollectionView * _collectionView;
    UIImageView * _iconImageView;
    UILabel * _titleLabel;
}
@property(nonatomic,strong,readonly)UICollectionView * collectionView;
@property(nonatomic,strong,readonly)UIImageView * iconImageView;
@property(nonatomic,strong,readonly)UILabel * titleLabel;
@property(nonatomic,assign)BOOL isHistory;
@end

@implementation FMPictureWithTextCellRecommended

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

        [self initView];
    }
    return self;
}

- (void)setDataArray:(NSMutableArray<DynamicModel *> *)dataArray{
    _dataArray = dataArray;
    [self.collectionView reloadData];
}

- (void) initView{
    [self addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.centerY.right.mas_equalTo(self);
        make.height.mas_equalTo(185);
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
    FMRecommendedCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:resuFMRecommendedCollectionViewCell forIndexPath:indexPath];
    DynamicModel *model = self.dataArray[indexPath.row];
    cell.titleLabel.text = model.title;
    [cell.imagesView sd_setImageWithURL:kGetImageURL(model.thumb1) placeholderImage:kGetImage(imagePlaceholder)];
    cell.likeLabel.text = model.collect_num;
    NSString *imagesCount = [NSString stringWithFormat:@"%@图",model.gallery_num];
    [cell.imagesCountButton setTitle:imagesCount forState:UIControlStateNormal];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

}

/// 同一行的cell的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 3;
}

//布局协议对应的方法实现
#pragma mark - UICollectionViewDelegateFlowLayout
//设置每个一个Item（cell）的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(170, 185);
}

//设置所有的cell组成的视图与section 上、左、下、右的间隔
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0,15,0,15);
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
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        //设置行间距
        flowLayout.minimumLineSpacing = 5;
        //设置列间距
        flowLayout.minimumInteritemSpacing = 5;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[FMRecommendedCollectionViewCell class] forCellWithReuseIdentifier:resuFMRecommendedCollectionViewCell];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.bounces = YES;
    }
    return _collectionView;
}
@end


#pragma mark
@interface FMRecommendedCollectionViewCell ()
{
@private
    UIImageView * _imagesView;
    UILabel * _titleLabel;
    UIButton * _likeButton;
    UIButton * _imagesCountButton;
}

@end
@implementation FMRecommendedCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        self.contentView.backgroundColor = [UIColor clearColor];
        [self setupUI];
    }
    return self;
}

- (void)setupUI {


    [self lz_setCornerRadius:4.0];
    [self setBorderColor:kTextColor221];
    [self setBorderWidth:0.7];
    [self addSubview:self.imagesView];
    [self addSubview:self.titleLabel];
//    [self addSubview:self.likeButton];
    [self addSubview:self.likeImageViews];
    [self addSubview:self.likeLabel];
    [self.imagesView addSubview:self.imagesCountButton];
    [self.imagesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.height.mas_equalTo(105);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(self.mas_right).mas_offset(-10);
        make.top.equalTo(self.imagesView.mas_bottom).offset(6);
    }];
    
    [self.imagesCountButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.imagesView.mas_right).offset(-10);
        make.bottom.equalTo(self.imagesView.mas_bottom).offset(-10);
        make.width.equalTo(@46);
        make.height.equalTo(@20);
    }];
    
    [self.likeImageViews mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.bottom.equalTo(self.mas_bottom).offset(-10);
    }];
    [self.likeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.likeImageViews.mas_right).offset(3);
        make.centerY.equalTo(self.likeImageViews);
    }];
//    [self.likeButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_offset(10);
//        make.bottom.equalTo(self.mas_bottom).offset(-10);
//    }];
}

#pragma mark -- setter getter
- (UIImageView *)imagesView{
    if (!_imagesView) {
        _imagesView = [[UIImageView alloc] init];
        _imagesView.backgroundColor = [UIColor clearColor];
    }
    return _imagesView;
}

- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [UILabel lz_labelWithTitle:@"" color:kTextColor51
                                            font:kFontWithNameSc12];
        _titleLabel.font = [UIFont boldSystemFontOfSize:12.0];
        _titleLabel.numberOfLines = 2;
    }
    return _titleLabel;
}

- (UIButton *)likeButton{
    if (!_likeButton) {
        _likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_likeButton setTitleColor:kTextColor153 forState:UIControlStateNormal];
        _likeButton.titleLabel.font = kFontSizeMedium12;
        [_likeButton setImage:kGetImage(@"base_aixin") forState:UIControlStateNormal];
        CGFloat spacing = 4;
        //image在左，文字在右，default
        [Utils lz_setButtonTitleWithImageEdgeInsets:_likeButton postition:kMVImagePositionLeft spacing:spacing];
    }
    return _likeButton;
}

- (UILabel *)likeLabel{
    if (!_likeLabel) {
        _likeLabel = [UILabel lz_labelWithTitle:@"" color:kTextColor153 font:kFontSizeMedium12];
    }
    return _likeLabel;
}

- (UIImageView *)likeImageViews{
    if (!_likeImageViews) {
        _likeImageViews = [[UIImageView alloc] init];
        _likeImageViews.image = kGetImage(@"base_aixin");
    }
    return _likeImageViews;
}

- (UIButton *)imagesCountButton{
    if (!_imagesCountButton) {
        _imagesCountButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_imagesCountButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
        _imagesCountButton.titleLabel.font = kFontSizeMedium10;
        [_imagesCountButton setImage:kGetImage(@"base_tujitubiao") forState:UIControlStateNormal];
        CGFloat spacing = 5;
        //image在左，文字在右，default
        [Utils lz_setButtonTitleWithImageEdgeInsets:_imagesCountButton postition:kMVImagePositionLeft spacing:spacing];
        [_imagesCountButton setBackgroundColor:kColorWithRGBA(0, 0, 0, 0.6)];
        [_imagesCountButton lz_setCornerRadius:10.0];
    }
    return _imagesCountButton;
}
@end
