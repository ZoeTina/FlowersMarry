//
//  TTTemplateChildTableViewCell.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/12/12.
//  Copyright © 2018 宁小陌. All rights reserved.
//

#import "TTTemplateChildTableViewCell.h"
#import "TTTemplateChildCollectionViewCell.h"

static NSString * const reuseIdentifier = @"TTTemplateChildCollectionViewCell";
@interface TTTemplateChildTableViewCell()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) UICollectionView * collectionView;

/// 记录最后的height
@property (nonatomic, assign) CGFloat endHeight;

//@property (nonatomic, strong) SCStartRating *stratingView;

@end

@implementation TTTemplateChildTableViewCell

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
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.commentCountLabel];
    [self.contentView addSubview:self.styleLabel];
    [self.contentView addSubview:self.priceLabel];
    [self.contentView addSubview:self.collectionView];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(15));
        make.top.equalTo(@(IPHONE6_W(20)));
        make.right.equalTo(self.contentView.mas_right).offset(-15);
    }];
    
    [self.commentCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(15));
        make.top.equalTo(self.titleLabel.mas_bottom).offset(IPHONE6_W(10));
    }];
    [self.styleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.commentCountLabel.mas_right).offset(15);
        make.centerY.equalTo(self.commentCountLabel);
    }];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.styleLabel.mas_right).offset(15);
        make.centerY.equalTo(self.styleLabel);
    }];
    CGFloat height = (kScreenWidth - 30 - 6)/3;
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.commentCountLabel.mas_bottom).offset(IPHONE6_W(10));
        make.left.right.equalTo(self.contentView);
        make.height.equalTo(@(height));
    }];
}

#pragma mark ---- UICollectionViewDataSource
// MARK:- ====UICollectionViewDataSource,UICollectionViewDelegate=====
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

//每个分区有多少个数据
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 3;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TTTemplateChildCollectionViewCell *tools = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    tools.imagesView.image = kGetImage(@"图层39");
    return tools;
}

/// 点击collectionViewCell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectChildItemAtIndexPath:withCasesModel:)]) {
//        [self.delegate didSelectChildItemAtIndexPath:self.indexPath withCasesModel:self.businessModel.cases[indexPath.row]];
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
        [_collectionView registerClass:[TTTemplateChildCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.bounces = YES;
    }
    return _collectionView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel lz_labelWithTitle:@"" color:kTextColor18 font:kFontSizeScBold14];
    }
    return _titleLabel;
}

- (UILabel *)commentCountLabel{
    if (!_commentCountLabel) {
        _commentCountLabel = [UILabel lz_labelWithTitle:@"" color:kTextColor112 font:kFontSizeMedium12];
    }
    return _commentCountLabel;
}

- (UILabel *)styleLabel{
    if (!_styleLabel) {
        _styleLabel = [UILabel lz_labelWithTitle:@"" color:kTextColor112 font:kFontSizeMedium12];
    }
    return _styleLabel;
}

- (UILabel *)priceLabel {
    if (!_priceLabel) {
        _priceLabel = [UILabel lz_labelWithTitle:@"" color:kTextColor112 font:kFontSizeMedium12];
    }
    return _priceLabel;
}
@end
