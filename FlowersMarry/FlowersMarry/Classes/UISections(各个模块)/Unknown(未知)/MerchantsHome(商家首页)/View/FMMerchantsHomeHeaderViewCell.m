//
//  FMMerchantsHomeHeaderViewCell.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/2.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMMerchantsHomeHeaderViewCell.h"
#import "SCStartRating.h"
#import "FMConsumerProtectionCollectionViewCell.h"


static NSString* reuseIdentifier = @"FMConsumerProtectionCollectionViewCell";
@interface FMMerchantsHomeHeaderViewCell()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) NSArray   *titles;
@property (nonatomic, strong) UIImageView    *imagesViewArrow;
/// 星星控件
@property (nonatomic, strong) SCStartRating *startRating;



@property(nonatomic,strong)UICollectionView * collectionView;
@property(nonatomic,strong)NSArray *dataArray;
@end
@implementation FMMerchantsHomeHeaderViewCell

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

- (void)setBusinessModel:(BusinessModel *)businessModel{
    _businessModel = businessModel;
    if (self.businessModel.xblist.count>0) {
        self.imagesViewArrow.hidden = NO;
    }
    [self.collectionView reloadData];
    self.titleLabel.text = self.businessModel.cp_fullname;
    [self.imagesView sd_setImageWithURL:kGetImageURL(self.businessModel.cp_logo) placeholderImage:kGetImage(imagePlaceholder)];

    BusinessAuthModel *authModel = self.businessModel.auth;
    self.baoImagesView.hidden = (authModel.xb==0) ? YES : NO;
    self.qiImagesView.hidden = ((authModel.qy==0) && (authModel.gt == 0)) ? YES :NO;
    self.recommendedImagesView.hidden = (authModel.isavip==0) ? YES : NO;

//    MV(weakSelf)
//    self.startRating.currentScoreChangeBlock = ^(CGFloat score){
//        weakSelf.scoreLabel.text = [NSString stringWithFormat:@"%.1f 星",score];
//    };
//    
//    // 请在设置完成最大最小的分数后再设置当前分数
//    self.startRating.currentScore = self.businessModel.cp_rank;

    if (authModel.qy==1) {
        self.qiImagesView.image = kGetImage(@"business_qi");
    }else if (authModel.gt==1){
        self.qiImagesView.image = kGetImage(@"business_ge");
    }
    
    [self initConstraints];
}

- (void) initView{
    
    [self.contentView addSubview:self.collectionView];

//    NSArray *tags = [self.model copy];//@[@"不满意重拍",@"1对1服务",@"7天内选片",@"15天出精修",@"无隐费消费",@"免费送照上门",@"所有底片全送",@"婚纱礼服任选",@"产品1年包换"];
    
    [self addSubview:self.titleLabel];
    [self addSubview:self.imagesView];
    [self addSubview:self.baoImagesView];
    [self addSubview:self.qiImagesView];
    [self addSubview:self.recommendedImagesView];
    [self addSubview:self.startRating];
    [self addSubview:self.scoreLabel];
    
    [self addSubview:self.imagesViewArrow];
    
}


// MARK:- ====UICollectionViewDataSource,UICollectionViewDelegate=====
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

//每个分区有多少个数据
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.businessModel.xblist.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FMConsumerProtectionCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.titleLabel.text = self.businessModel.xblist[indexPath.row];
    [cell.imagesView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
    }];
    return cell;
}

/// 点击collectionViewCell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectSecurityItemAtIndexPath:withContent:)]) {
        [self.delegate didSelectSecurityItemAtIndexPath:indexPath withContent:self.dataArray[indexPath.row]];
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
    return CGSizeMake((kScreenWidth-40)/4, 44);
}

//设置所有的cell组成的视图与section 上、左、下、右的间隔
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0,0,0,0);
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
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        //        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        //设置行间距
        flowLayout.minimumLineSpacing = 0;
        //设置列间距
        flowLayout.minimumInteritemSpacing = 0;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:[FMConsumerProtectionCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.scrollEnabled = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.bounces = YES;
    }
    return _collectionView;
}

#pragma mark ----- 约束 -----
- (void)initConstraints{
    [self.imagesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@8);
        make.top.equalTo(@10);
        make.width.height.equalTo(@60);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imagesView.mas_right).offset(10);
        make.height.equalTo(@20);
        make.top.equalTo(self.imagesView.mas_top).offset(12);
    }];
    
    [self.startRating mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel).offset(-3);
        make.bottom.equalTo(self.imagesView.mas_bottom).offset(-8);
        make.height.equalTo(@20);
    }];
    
    [self.scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imagesView.mas_right).offset(92);
        make.centerY.equalTo(self.startRating);
    }];
    
    [self.baoImagesView mas_makeConstraints:^(MASConstraintMaker *make) {
        CGFloat left;
        if (self.baoImagesView.hidden) {
            make.width.equalTo(@0);
            left = 3;
        }else{
            left = 7;
        }
        make.left.equalTo(self.scoreLabel.mas_right).offset(left);
        make.centerY.equalTo(self.scoreLabel);
    }];
    [self.qiImagesView mas_makeConstraints:^(MASConstraintMaker *make) {
        CGFloat left;
        if (self.qiImagesView.hidden) {
            make.width.equalTo(@0);
            left = 0;
        }else{
            left = 4;
        }
        make.left.equalTo(self.baoImagesView.mas_right).offset(left);
        make.centerY.equalTo(self.scoreLabel);
    }];
    [self.recommendedImagesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.qiImagesView.mas_right).offset(4);
        make.centerY.equalTo(self.scoreLabel);
    }];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imagesView.mas_bottom).offset(10);
        make.left.equalTo(self.contentView);
        make.right.equalTo(self.contentView.mas_right).offset(-40);
        make.height.equalTo(@44);
    }];
    
    [self.imagesViewArrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.centerY.equalTo(self.collectionView);
    }];
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel lz_labelWithTitle:@"" color:kTextColor34 font:kFontSizeScBold20];
    }
    return _titleLabel;
}

- (UIImageView *)imagesView{
    if (!_imagesView) {
        _imagesView = [[UIImageView alloc] init];
    }
    return _imagesView;
}

- (UIImageView *)baoImagesView{
    if (!_baoImagesView) {
        _baoImagesView = [[UIImageView alloc] init];
        _baoImagesView.image = kGetImage(@"business_bao");
    }
    return _baoImagesView;
}

- (UIImageView *)qiImagesView{
    if (!_qiImagesView) {
        _qiImagesView = [[UIImageView alloc] init];
    }
    return _qiImagesView;
}

- (UIImageView *)recommendedImagesView{
    if (!_recommendedImagesView) {
        _recommendedImagesView = [[UIImageView alloc] init];
        _recommendedImagesView.image = kGetImage(@"business_tuijian");
    }
    return _recommendedImagesView;
}

- (UILabel *)scoreLabel{
    if (!_scoreLabel) {
        _scoreLabel = [UILabel lz_labelWithTitle:@"" color:kTextColor136 font:kFontSizeMedium11];
    }
    return _scoreLabel;
}

- (SCStartRating *)startRating{
    if (!_startRating) {
        _startRating = [[SCStartRating alloc] initWithFrame:CGRectMake(0, 0, 80, 0) Count:5];
        _startRating.spacing = 5.0f;
        _startRating.checkedImage = kGetImage(@"business_shixing");
        _startRating.uncheckedImage = kGetImage(@"business_kongxing");
        _startRating.type = SCRatingTypeHalf;
        _startRating.touchEnabled = YES;
        _startRating.slideEnabled = YES;
        _startRating.maximumScore = 5.0f;
        _startRating.minimumScore = 0.0f;
    }
    return _startRating;
}

- (UIImageView *)imagesViewArrow{
    if (!_imagesViewArrow) {
        _imagesViewArrow = [[UIImageView alloc] init];
        _imagesViewArrow.image = kGetImage(@"right_arrow");
        _imagesViewArrow.hidden = YES;
    }
    return _imagesViewArrow;
}

- (NSArray *)dataArray{
    if (!_dataArray) {
        _dataArray = @[@"不满意退款",@"1对1服务",@"7天内选片",@"15天出精修",@"无隐形消费",@"免费送照上门",@"所有底片全送",@"婚纱礼服任选",@"产品1年包换"];
    }
    return _dataArray;
}

@end
