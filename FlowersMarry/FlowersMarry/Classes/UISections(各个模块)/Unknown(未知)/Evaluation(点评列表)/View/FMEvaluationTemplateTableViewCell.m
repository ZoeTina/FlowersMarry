//
//  FMEvaluationTemplateTableViewCell.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/20.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMEvaluationTemplateTableViewCell.h"
#import "FMTravelCollectionViewCell.h"

static NSString * const reuseIdentifier = @"FMTravelCollectionViewCell";

@interface FMEvaluationTemplateTableViewCell()<UICollectionViewDelegate,UICollectionViewDataSource>
@end
@implementation FMEvaluationTemplateTableViewCell

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
        self.contentView.backgroundColor = kWhiteColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setModel:(EvaluationModel *)model{
    _model = model;
    [self initView];
    [self.imagesView sd_setImageWithURL:kGetVideoURL(self.model.avatar) placeholderImage:kGetImage(imagePlaceholder)];
    self.nicknameLabel.text = self.model.user_name;
    self.datetimeLabel.text = self.model.add_time_tips;
    self.startRating.currentScore = self.model.ct_level;
    self.titleLabel.text = self.model.ct_content;
    if (self.model.ct_re_content.length>0) {
        NSString *str = @"回复：";
        NSString *replyStr = self.model.ct_re_content;
        NSString *replyTime = [NSString stringWithFormat:@" %@",self.model.re_time_tips];
        NSString *replyContent = [NSString stringWithFormat:@"%@%@%@",str,replyStr,replyTime];
        
        NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:replyContent];
        /// 中间文字颜色
        [attributedStr addAttribute:NSForegroundColorAttributeName
                              value:kTextColor51
                              range:NSMakeRange(str.length, replyContent.length - replyTime.length - str.length)];
        
        self.replyLabel.attributedText = attributedStr;
    }
    _imagesCount = self.model.photo.count;
    /// 0:评论 1:评论+回复 2:评论+图片 3:评论+图片+回复
    if (self.model.ct_re_content.length>0 && self.model.photo.count==0) {/// 有回复
        self.idx = 1;
    }else if (self.model.photo.count>0 && self.model.ct_re_content.length==0){/// 有图片
        self.idx = 2;
    }else if (self.model.ct_re_content.length>0&&self.model.photo.count>0){/// 有回复和图片
        self.idx = 3;
    }else{  /// 纯文字
        self.idx = 0;
    }
    [self.collectionView reloadData];
    [self initConstraint];
}

- (void) initView{
    
    [self addSubview:self.imagesView];
    [self addSubview:self.nicknameLabel];
    [self addSubview:self.datetimeLabel];
    [self addSubview:self.titleLabel];
    [self addSubview:self.startRating];
    
    [self addSubview:self.collectionView];
    
    [self addSubview:self.replyView];
    [self.replyView addSubview:self.replyLabel];
    [self.replyView addSubview:self.replyImagesView];
}

#pragma mark ---- UICollectionViewDataSource
// MARK:- ====UICollectionViewDataSource,UICollectionViewDelegate=====
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

//每个分区有多少个数据
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.model.photo.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FMTravelCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.backgroundColor = kColorWithRGB(242, 242, 242);
    cell.containerView.hidden = NO;
    cell.linerView.hidden = YES;
    EvaluationPhotoModel *model = self.model.photo[indexPath.row];
    [cell.imagesView sd_setImageWithURL:kGetImageURL(model.p_filename) placeholderImage:kGetImage(imagePlaceholder)];
    return cell;
}

/// 点击collectionViewCell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectItemAtIndexPath:withContent:)]) {
//        [self.delegate didSelectItemAtIndexPath:indexPath withContent:self.dataArray[indexPath.section][indexPath.row]];
        [self.delegate didSelectItemAtIndexPath:indexPath withContent:@"网友点评"];
    }
}

//布局协议对应的方法实现
#pragma mark - UICollectionViewDelegateFlowLayout
//设置每个一个Item（cell）的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat item = 3;
    CGFloat spacing = 5.0*2;
    CGFloat width = (kScreenWidth-IPHONE6_W(75)-IPHONE6_W(spacing))/item;
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


- (void) initConstraint{
    
    /// 根据类型设置距离底部的位置
    CGFloat titleMargin = 0.0;  /// title边距
    CGFloat replyMargin = 0.0;  /// 回复View边距
    CGFloat picViewMargin = 0.0;/// 图片View边距
    CGFloat replySpace = 0.0;   /// 回复内容文字边距
    CGFloat collectionHeight = 0;
    CGFloat iconHeight = 0.0;   /// 回复icon高度
    
    CGFloat idx = _imagesCount/3.0;
    /// 进位法，得到有多少列
    //    TTLog(@"---- %d---- %d",(int)ceilf(0.33333333),(int)ceilf(idx));
    //    self.collectionViewHeight = (int)ceilf(idx)*97+5*2;
    /// 0:评论 1:评论+回复 2:评论+图片 3:评论+图片+回复

    if (self.idx==0) {
        titleMargin = 10.0;
        replyMargin = 0.0;
        replySpace = 0.0;
    }else if (self.idx==1) {
        titleMargin = 10.0;
        replyMargin = 10.0;
        replySpace = 10.0;
        iconHeight = 11.0;
    }else if (self.idx==2) {
        titleMargin = 10.0;
        replyMargin = 0.0;
        picViewMargin = 10.0;
        replySpace = 0.0;
    }else{
        titleMargin = 10.0;
        replyMargin = 10.0;
        picViewMargin = 10.0;
        replySpace = 10.0;
        iconHeight = 11.0;
    }
    NSInteger idxs = (int)ceilf(idx);
    collectionHeight = idxs*97+(5*idxs-1);

    [self.imagesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.equalTo(@(IPHONE6_W(33)));
        make.left.top.equalTo(@15);
    }];

    [self.nicknameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imagesView.mas_top).offset(IPHONE6_W(3));
        make.left.equalTo(self.imagesView.mas_right).offset(IPHONE6_W(10));
        make.height.equalTo(@(IPHONE6_W(12)));
    }];
    [self.startRating mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nicknameLabel).offset(-3);
        make.bottom.equalTo(self.imagesView.mas_bottom).offset(-7);
    }];
    [self.datetimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.nicknameLabel);
        make.height.equalTo(@(IPHONE6_W(12)));
        make.right.equalTo(self.mas_right).offset(-15);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nicknameLabel);
        make.top.equalTo(self.imagesView.mas_bottom).offset(IPHONE6_W(10));
        make.right.equalTo(self.mas_right).offset(-15);
        make.bottom.equalTo(self.collectionView.mas_top).offset(IPHONE6_W(-titleMargin));
    }];

    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.titleLabel);
        make.height.equalTo(@(IPHONE6_W(collectionHeight)));
        make.bottom.equalTo(self.replyView.mas_top).offset(IPHONE6_W(-picViewMargin));
    }];
    
    [self.replyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.replyImagesView.mas_right).offset(4);
        make.top.equalTo(@(replySpace));
        make.right.equalTo(self.replyView.mas_right).offset(-9);
        make.bottom.equalTo(self.replyView.mas_bottom).offset(-replySpace);
    }];
    
    [self.replyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.titleLabel);
        make.bottom.equalTo(self.mas_bottom).offset(IPHONE6_W(-replyMargin));
    }];
    [self.replyImagesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@9);
        make.height.width.equalTo(@(IPHONE6_W(iconHeight)));
        make.top.equalTo(self.replyLabel.mas_top).offset(4);
    }];
}


#pragma mark ---- setter/getter
- (UIImageView *)imagesView{
    if (!_imagesView) {
        _imagesView = [[UIImageView alloc] init];
        [_imagesView lz_setCornerRadius:IPHONE6_W(33.0)/2];
    }
    return _imagesView;
}

- (UILabel *)nicknameLabel{
    if (!_nicknameLabel) {
        _nicknameLabel = [UILabel lz_labelWithTitle:@"" color:kTextColor102 font:kFontSizeMedium12];
    }
    return _nicknameLabel;
}

- (UILabel *)datetimeLabel{
    if (!_datetimeLabel) {
        _datetimeLabel = [UILabel lz_labelWithTitle:@"" color:kTextColor153 font:kFontSizeMedium12];
    }
    return _datetimeLabel;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel lz_labelWithTitle:@"" color:kTextColor34 font:kFontSizeMedium13];
    }
    return _titleLabel;
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

- (UIImageView *)replyImagesView{
    if (!_replyImagesView) {
        _replyImagesView = [[UIImageView alloc] init];
        _replyImagesView.image = kGetImage(@"mine_btn_reply");
    }
    return _replyImagesView;
}

- (UIView *)replyView{
    if (!_replyView) {
        _replyView = [UIView lz_viewWithColor:kColorWithRGB(244, 248, 251)];
        [_replyView lz_setCornerRadius:4.0];
    }
    return _replyView;
}

- (UILabel *)replyLabel{
    if (!_replyLabel) {
        _replyLabel = [[UILabel alloc] init];
        _replyLabel.textColor = kTextColor153;;
        _replyLabel.font = kFontSizeMedium13;
        _replyLabel.numberOfLines = 0;
//        _replyLabel.edgeInsets = UIEdgeInsetsMake(0, 10, 10, 10);
    }
    return _replyLabel;
}
@end
