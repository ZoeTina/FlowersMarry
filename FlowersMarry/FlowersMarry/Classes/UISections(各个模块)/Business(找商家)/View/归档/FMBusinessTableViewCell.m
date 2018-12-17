//
//  FMBusinessTableViewCell.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/6/27.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMBusinessTableViewCell.h"


@implementation FMBusinessTableViewCell

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
    }
    return self;
}

- (void) initView{
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.baoImagesView];
    [self.contentView addSubview:self.qiImagesView];
    [self.contentView addSubview:self.recommendedImagesView];
    [self.contentView addSubview:self.giftImagesView];
    [self.contentView addSubview:self.contentLabel];
    
    [self.contentView addSubview:self.areaLabel];
    
    [self.contentView addSubview:self.stratingView];
    [self.contentView addSubview:self.imageContainerView];
    MV(weakSelf)
    self.stratingView.currentScoreChangeBlock = ^(CGFloat score){
        
        weakSelf.scoreLabel.text = [NSString stringWithFormat:@"%.1f 星",score];
    };
    
    // 请在设置完成最大最小的分数后再设置当前分数
    self.stratingView.currentScore = 4.0f;
    [self.contentView addSubview:self.scoreLabel];

    [self initConstraints];
}

- (void) initConstraints{
    
    CGFloat margin = 15.0;
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(IPHONE6_W(margin));
        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(IPHONE6_W(-15));
        make.top.mas_equalTo(20);
        make.bottom.mas_equalTo(self.stratingView.mas_top).mas_offset(IPHONE6_W(-7));
    }];
    [self.areaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.titleLabel);
        make.right.mas_equalTo(self.contentView.mas_right).mas_offset(IPHONE6_W(-margin));
    }];
    
    [self.stratingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(IPHONE6_W(margin-3));
        make.width.mas_equalTo(IPHONE6_W(70));
        make.bottom.mas_equalTo(self.giftImagesView.mas_top).offset(IPHONE6_W(-7));
        make.height.mas_equalTo(14);
    }];
    
    [self.scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.stratingView.mas_right).mas_offset(IPHONE6_W(7));
        make.centerY.mas_equalTo(self.stratingView);
    }];
    
    [self.baoImagesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.scoreLabel.mas_right).offset(IPHONE6_W(7));
        make.centerY.mas_equalTo(self.scoreLabel);
    }];
    [self.qiImagesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.baoImagesView.mas_right).offset(IPHONE6_W(3));
        make.centerY.mas_equalTo(self.scoreLabel);
    }];
    [self.recommendedImagesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.qiImagesView.mas_right).offset(IPHONE6_W(3));
        make.centerY.mas_equalTo(self.scoreLabel);
    }];

    [self.giftImagesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(IPHONE6_W(margin));
        make.bottom.mas_equalTo(self.imageContainerView.mas_top).mas_offset(IPHONE6_W(-10));
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.giftImagesView.mas_right).offset(5);
        make.centerY.equalTo(self.giftImagesView);
    }];
    
    
    /// 进位法，得到有多少列
    //    YYLog(@"---- %d---- %d",(int)ceilf(0.33333333),(int)ceilf(idx));
    CGFloat item = 3;
    CGFloat spacing = 3.0*2;
    CGFloat margin_c = 15.0*2;
    CGFloat height = (kScreenWidth-IPHONE6_W(margin_c)-IPHONE6_W(spacing))/item;
    
    for (int i=0; i<3; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.image = kGetImage(@"图层 18");
        imageView.frame = CGRectMake((i*3)+i*height, 95, height, height);
        [self.imageContainerView addSubview:imageView];
        
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo((i*3)+i*height);
            make.height.width.mas_equalTo(height);
            make.top.mas_equalTo(self.imageContainerView);
        }];
        [self.imageContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(IPHONE6_W(margin));
            make.right.mas_equalTo(self.contentView.mas_right).mas_offset(IPHONE6_W(-margin));
            make.height.mas_equalTo(height);
            make.bottom.mas_equalTo(self.contentView.mas_bottom).mas_offset(-10);
        }];
        UILabel *priceLabel = [UILabel lz_labelWithTitle:@"￥3999" color:[UIColor whiteColor] font:kFontSizeMedium12];
        priceLabel.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
        [imageView addSubview:priceLabel];
        [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.equalTo(imageView);
            make.width.equalTo(@43);
            make.height.equalTo(@15);
        }];
    }
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
        _baoImagesView.image = kGetImage(@"business_bao");
    }
    return _baoImagesView;
}

- (UIImageView *)qiImagesView{
    if (!_qiImagesView) {
        _qiImagesView = [[UIImageView alloc] init];
        _qiImagesView.image = kGetImage(@"business_qi");
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
        _giftImagesView.image = kGetImage(@"business_gift");
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

- (UIView *)imageContainerView{
    if (!_imageContainerView) {
        _imageContainerView = [UIView lz_viewWithColor:kWhiteColor];
    }
    return _imageContainerView;
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
