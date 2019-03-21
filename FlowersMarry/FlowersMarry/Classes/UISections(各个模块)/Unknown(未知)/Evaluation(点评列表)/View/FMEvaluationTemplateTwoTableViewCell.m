//
//  FMEvaluationTemplateTwoTableViewCell.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/8/22.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMEvaluationTemplateTwoTableViewCell.h"

#import "FMTravelCollectionViewCell.h"

static NSString * const reuseIdentifier = @"FMTravelCollectionViewCell";
@interface FMEvaluationTemplateTwoTableViewCell()<UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation FMEvaluationTemplateTwoTableViewCell

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
        self.contentView.backgroundColor = kWhiteColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initView];
        [self initConstraint];
//        [self initialValue];
    }
    return self;
}

/// 设置初始值
- (void) initialValue{
    self.imagesView.image = kGetImage(@"user1");
    self.nicknameLabel.text = @"网友2659996";
    self.datetimeLabel.text = @"2017-06-18";
//    self.startRating.currentScore = 4.0;
    self.titleLabel.text = self.evaluationModel.ct_content;
    
    if (self.evaluationModel.ct_re_content.length>0) {
        NSString *str = @"回复：感谢您的选择和信任，我们会一如既往地为更多人服务!";
        NSString *replyStr = self.evaluationModel.ct_re_content;
        NSString *replyTime = @"22分钟前";
        NSString *replyContent = [NSString stringWithFormat:@"%@%@%@",str,replyStr,replyTime];
        
        NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:replyContent];
        /// 中间文字颜色
        [attributedStr addAttribute:NSForegroundColorAttributeName
                              value:kTextColor51
                              range:NSMakeRange(str.length, replyContent.length - replyTime.length - str.length)];
        
        self.replyLabel.attributedText = attributedStr;
    }
    
    [self.collectionView reloadData];
}

#pragma mark ---- UICollectionViewDataSource
// MARK:- ====UICollectionViewDataSource,UICollectionViewDelegate=====
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

//每个分区有多少个数据
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.evaluationModel.photo.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FMTravelCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.backgroundColor = kColorWithRGB(242, 242, 242);
    cell.containerView.hidden = NO;
    cell.linerView.hidden = YES;
    BusinessCasesPhotoModel *model = self.evaluationModel.photo[indexPath.row];
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

- (void) initConstraint{
    [self.imagesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.equalTo(@(IPHONE6_W(33)));
        make.left.top.equalTo(@15);
    }];
    
    [self.nicknameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imagesView.mas_top).offset(3);
        make.left.equalTo(self.imagesView.mas_right).offset(10);
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
        make.top.equalTo(self.imagesView.mas_bottom).offset(10);
        make.right.equalTo(self.mas_right).offset(-15);
        make.bottom.equalTo(self.collectionView.mas_top).offset(-10);
    }];
    
    CGFloat idx = self.evaluationModel.photo.count/3.0;
    NSInteger idxs = (int)ceilf(idx);
    CGFloat collectionHeight = idxs*97+(5*idxs-1);
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.titleLabel);
        make.height.equalTo(@(IPHONE6_W(collectionHeight)));
        make.bottom.equalTo(self.replyView.mas_top).offset(-10);
    }];
    
    [self.replyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.replyView.mas_left).offset(9);
        make.top.equalTo(@(10));
        make.right.equalTo(self.replyView.mas_right).offset(-9);
        make.bottom.equalTo(self.replyView.mas_bottom).offset(-10);
    }];
    
    [self.replyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.titleLabel);
        make.bottom.equalTo(self.mas_bottom).offset(-15);
    }];
    //    [self.replyImagesView mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.left.equalTo(@9);
    //        make.height.width.equalTo(@(IPHONE6_W(11)));
    //        make.top.equalTo(self.replyLabel.mas_top).offset(4);
    //    }];
}

#pragma mark ---- setter/getter
- (FLAnimatedImageView *)imagesView{
    if (!_imagesView) {
        _imagesView = [[FLAnimatedImageView alloc] init];
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
