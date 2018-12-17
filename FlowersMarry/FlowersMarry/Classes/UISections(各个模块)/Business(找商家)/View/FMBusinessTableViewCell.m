//
//  FMBusinessTableViewCell.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/6/27.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMBusinessTableViewCell.h"

#import "SCStartRating.h"
#import "FMBusinessCollectionViewCell.h"
#import "FMMineReviewModel.h"

static NSString * const reuseIdentifier = @"FMBusinessCollectionViewCell";

@interface FMBusinessTableViewCell()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) UICollectionView * collectionView;

/// 记录最后的height
@property (nonatomic, assign) CGFloat endHeight;

@property (nonatomic, strong) SCStartRating *stratingView;

@end
@implementation FMBusinessTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self addLayoutSubViews];
    }
    return self;
}

- (void) addLayoutSubViews{
    [self addSubview:self.titleLabel];
    [self addSubview:self.baoImagesView];
    [self addSubview:self.qiImagesView];
    [self addSubview:self.recommendedImagesView];
    [self addSubview:self.giftImagesView];
    [self addSubview:self.contentLabel];
    
    [self addSubview:self.areaLabel];
    
    [self addSubview:self.collectionView];
    /// 设置约束
    [self initConstraints];
}


- (void)updateLayoutSubViews {
    CGFloat margin = IPHONE6_W(15.0);
    if (self.baoImagesView.hidden) {
        [self.qiImagesView mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(@(margin));
            make.left.equalTo(self.baoImagesView.mas_left).priorityHigh();
        }];
    }
    
    if (self.baoImagesView.hidden && self.qiImagesView.hidden) {
        [self.recommendedImagesView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(margin));
        }];
    }
    
    if (self.businessModel.youhui.gift.title.length<=0) {
        [self.contentLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(@(margin));
        }];
    }
    
    /// 进位法，得到有多少列
    //    TTLog(@"---- %d---- %d",(int)ceilf(0.33333333),(int)ceilf(idx));
    CGFloat item = 3;
    CGFloat spacing = 3.0*2;
    CGFloat margin_c = 15.0*2;
    CGFloat height = 0;
    if (self.businessModel.cases.count>0) {
        height = (kScreenWidth-IPHONE6_W(margin_c)-IPHONE6_W(spacing))/item;
    }
    
    [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(height));
    }];
    [self setNeedsLayout];
    [self layoutIfNeeded];
}

- (void)setBusinessModel:(BusinessModel *)businessModel{
    _businessModel = businessModel;
    self.areaLabel.text = self.businessModel.qu_name;
    self.titleLabel.text = self.businessModel.cp_fullname;
    
    BusinessYouHuiModel *model = self.businessModel.youhui;
    self.contentLabel.text = model.gift.title;
    
    self.giftImagesView.hidden = (model.gift.title.length == 0) ? YES : NO;
    BusinessAuthModel *authModel= self.businessModel.auth;
    self.baoImagesView.hidden = (authModel.xb == 0) ? YES :NO;
    self.qiImagesView.hidden = ((authModel.qy==0) && (authModel.gt == 0)) ? YES :NO;
    self.recommendedImagesView.hidden = (authModel.isavip == 0) ? YES :NO;
    
    if (!self.baoImagesView.hidden) {
        self.baoImagesView.image = kGetImage(@"business_bao");
    }
    
    if (authModel.qy==1) {
        self.qiImagesView.image = kGetImage(@"business_qi");
    }else if (authModel.gt==1){
        self.qiImagesView.image = kGetImage(@"business_ge");
    }
    [self updateLayoutSubViews];
    [self.collectionView reloadData];
}

#pragma mark ---- UICollectionViewDataSource
// MARK:- ====UICollectionViewDataSource,UICollectionViewDelegate=====
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

//每个分区有多少个数据
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.businessModel.cases.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FMBusinessCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    BusinessCasesModel *model = self.businessModel.cases[indexPath.row];
    cell.model = model;
    return cell;
}

/// 点击collectionViewCell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectItemAtIndexPath:withCasesModel:)]) {
        [self.delegate didSelectItemAtIndexPath:self.indexPath withCasesModel:self.businessModel.cases[indexPath.row]];
    }
}

//布局协议对应的方法实现
#pragma mark - UICollectionViewDelegateFlowLayout
//设置每个一个Item（cell）的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat item = 3;
    CGFloat spacing = 3.0*2;
    CGFloat margin = 15.0*2;
    CGFloat width = (kScreenWidth-IPHONE6_W(margin)-IPHONE6_W(spacing))/item;
    return CGSizeMake(width, width);
}

//设置所有的cell组成的视图与section 上、左、下、右的间隔
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(0,0,0,0);
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
        [_collectionView registerClass:[FMBusinessCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.bounces = YES;
    }
    return _collectionView;
}

- (void) initConstraints{
    
    CGFloat margin = IPHONE6_W(15.0);
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(margin));
        make.right.equalTo(self.mas_right).offset(IPHONE6_W(-margin));
        make.top.equalTo(@20);
        make.bottom.equalTo(self.qiImagesView.mas_top).offset(IPHONE6_W(-7));
    }];
    [self.areaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.titleLabel);
        make.right.equalTo(self.mas_right).offset(IPHONE6_W(-margin));
    }];
    
    [self.baoImagesView mas_makeConstraints:^(MASConstraintMaker *make) {
        CGFloat left = 7;
        make.left.equalTo(@(margin));
        make.bottom.equalTo(self.giftImagesView.mas_top).offset(IPHONE6_W(-left));
    }];

    [self.qiImagesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.baoImagesView.mas_right).offset(4);
        make.bottom.equalTo(self.giftImagesView.mas_top).offset(IPHONE6_W(-7));
    }];
    [self.recommendedImagesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.qiImagesView.mas_right).offset(4);
        make.bottom.equalTo(self.giftImagesView.mas_top).offset(IPHONE6_W(-7));
    }];
    
    [self.giftImagesView mas_makeConstraints:^(MASConstraintMaker *make) {
        BusinessYouHuiModel *model = self.businessModel.youhui;
        make.left.equalTo(@(margin));
        CGFloat bottom = 10;
        make.bottom.equalTo(self.collectionView.mas_top).offset(IPHONE6_W(-bottom));

    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.giftImagesView.mas_right).offset(5);
        make.centerY.equalTo(self.giftImagesView);
        make.bottom.equalTo(self.collectionView.mas_top).offset(IPHONE6_W(-7));
    }];
    
    /// 进位法，得到有多少列
    //    TTLog(@"---- %d---- %d",(int)ceilf(0.33333333),(int)ceilf(idx));
    CGFloat item = 3;
    CGFloat spacing = 3.0*2;
    CGFloat margin_c = 15.0*2;
    CGFloat height = 0;
    if (self.businessModel.cases.count>0) {
        height = (kScreenWidth-IPHONE6_W(margin_c)-IPHONE6_W(spacing))/item;
    }
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(margin));
        make.right.equalTo(self.mas_right).offset(IPHONE6_W(-margin));
        make.height.equalTo(@(height));
        make.bottom.equalTo(self.mas_bottom).offset(IPHONE6_W(-10));
    }];
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel lz_labelWithTitle:@"" color:kTextColor51 font:kFontSizeScBold15];
    }
    return _titleLabel;
}

- (UIImageView *)baoImagesView{
    if (!_baoImagesView) {
        _baoImagesView = [[UIImageView alloc] init];
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

- (UIImageView *)giftImagesView{
    if (!_giftImagesView) {
        _giftImagesView = [[UIImageView alloc] init];
        _giftImagesView.image = kGetImage(@"base_merchant_gift");
    }
    return _giftImagesView;
}

- (UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [UILabel lz_labelWithTitle:@"" color:kTextColor136 font:kFontSizeMedium12];
    }
    return _contentLabel;
}

- (UILabel *)scoreLabel{
    if (!_scoreLabel) {
        _scoreLabel = [UILabel lz_labelWithTitle:@"" color:kTextColor135 font:kFontSizeMedium11];
    }
    return _scoreLabel;
}

- (UILabel *)areaLabel{
    if (!_areaLabel) {
        _areaLabel = [UILabel lz_labelWithTitle:@"" color:kTextColor136 font:kFontSizeMedium12];
    }
    return _areaLabel;
}

- (SCStartRating *)stratingView{
    if (!_stratingView) {
        _stratingView = [[SCStartRating alloc] initWithFrame:CGRectMake(0, 0, 80, 0) Count:5];
        _stratingView.spacing = 5.0f;
        _stratingView.checkedImage = kGetImage(@"business_shixing");
        _stratingView.uncheckedImage = kGetImage(@"business_kongxing");
        _stratingView.type = SCRatingTypeHalf;
        _stratingView.touchEnabled = YES;
        _stratingView.slideEnabled = YES;
        _stratingView.maximumScore = 5.0f;
        _stratingView.minimumScore = 0.0f;
    }
    return _stratingView;
}

@end
