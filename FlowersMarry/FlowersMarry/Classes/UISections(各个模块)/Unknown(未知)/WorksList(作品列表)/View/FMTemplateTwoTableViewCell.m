//
//  FMTemplateTwoTableViewCell.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/6.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMTemplateTwoTableViewCell.h"
#import "SCStartRating.h"

@implementation FMTemplateTwoTableViewCell

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

- (void)setBusinessModel:(BusinessModel *)businessModel{
    _businessModel = businessModel;
    
    MV(weakSelf)
    self.startRating.currentScoreChangeBlock = ^(CGFloat score){
//        weakSelf.scoreLabel.text = [NSString stringWithFormat:@"%.1f 星",score];
    };
    TTLog(@"businessModel.cp_fullname --- %@",businessModel.channel_name);
    // 请在设置完成最大最小的分数后再设置当前分数
//    self.startRating.currentScore = businessModel.cp_score;
    self.titleLabel.text = businessModel.cp_fullname;
    self.tagLabel.text = businessModel.channel_name;
    [self.imagesView sd_setImageWithURL:kGetImageURL(businessModel.cp_logo)
                       placeholderImage:kGetImage(imagePlaceholder)];
    
    BusinessAuthModel *authModel= self.businessModel.auth;
    self.baoImages.hidden = (authModel.xb == 0) ? YES :NO;
    self.enterpriseImages.hidden = ((authModel.qy==0) && (authModel.gt == 0)) ? YES :NO;
    self.recommendImages.hidden = (authModel.isavip == 0) ? YES :NO;
    
    if (!self.baoImages.hidden) {
        self.baoImages.image = kGetImage(@"business_bao");
    }
    
    if (authModel.qy==1) {
        self.enterpriseImages.image = kGetImage(@"business_qi");
    }else if (authModel.gt==1){
        self.enterpriseImages.image = kGetImage(@"business_ge");
    }
}

- (void) initView{
    
    [self addSubview:self.titleLabel];
    [self addSubview:self.imagesView];
    [self addSubview:self.scoreLabel];
    [self addSubview:self.baoImages];
    [self addSubview:self.enterpriseImages];
    [self addSubview:self.recommendImages];
    [self addSubview:self.tagLabel];
    [self addSubview:self.guanzhuButton];
    [self addSubview:self.startRating];
    [self addSubview:self.scoreLabel];
    [self setConstraint];
    
}

- (void) setConstraint{
    [self.imagesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(IPHONE6_W(15));
        make.height.width.mas_equalTo(IPHONE6_W(50));
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imagesView.mas_top);
        make.left.mas_equalTo(self.imagesView.mas_right).mas_offset(IPHONE6_W(10));
    }];
    
    [self.startRating mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel);
        make.centerY.equalTo(self.imagesView);
        make.height.equalTo(@(20));
    }];
    
    [self.scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.imagesView.mas_right).mas_offset(92);
        make.centerY.mas_equalTo(self.startRating);
    }];
    
    [self.baoImages mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.scoreLabel.mas_right).mas_offset(5);
        make.centerY.mas_equalTo(self.scoreLabel);
    }];
    [self.enterpriseImages mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.baoImages.mas_right).mas_offset(3);
        make.centerY.mas_equalTo(self.scoreLabel);
    }];
    [self.recommendImages mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.enterpriseImages.mas_right).mas_offset(3);
        make.centerY.mas_equalTo(self.scoreLabel);
    }];
    
    [self.tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel);
        make.bottom.mas_equalTo(self.imagesView.mas_bottom);
    }];
    
    [self.guanzhuButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).mas_offset(IPHONE6_W(-15));
        make.centerY.mas_equalTo(self);
        make.width.mas_equalTo(IPHONE6_W(55));
        make.height.mas_equalTo(IPHONE6_W(26));
    }];
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel lz_labelWithTitle:@"" color:kTextColor34 font:kFontSizeMedium15];
    }
    return _titleLabel;
}

- (UILabel *)scoreLabel{
    if (!_scoreLabel) {
        _scoreLabel = [UILabel lz_labelWithTitle:@"" color:kTextColor136 font:kFontSizeMedium11];
    }
    return _scoreLabel;
}

- (UIImageView *)imagesView{
    if (!_imagesView) {
        _imagesView = [[UIImageView alloc] init];
        _imagesView.borderWidth = kLinerViewHeight;
        _imagesView.borderColor = kTextColor238;
        [_imagesView lz_setCornerRadius:2.0];
    }
    return _imagesView;
}

- (UIImageView *)baoImages{
    if (!_baoImages) {
        _baoImages = [[UIImageView alloc] init];
    }
    return _baoImages;
}
- (UIImageView *)enterpriseImages{
    if (!_enterpriseImages) {
        _enterpriseImages = [[UIImageView alloc] init];
    }
    return _enterpriseImages;
}
- (UIImageView *)recommendImages{
    if (!_recommendImages) {
        _recommendImages = [[UIImageView alloc] init];
    }
    return _recommendImages;
}


- (SCCustomMarginLabel *)tagLabel{
    if (!_tagLabel) {
        _tagLabel = [[SCCustomMarginLabel alloc] init];
        _tagLabel.textAlignment = NSTextAlignmentCenter;
        _tagLabel.textColor = kTextColor136;
        _tagLabel.font = kFontSizeMedium10;
        _tagLabel.edgeInsets    = UIEdgeInsetsMake(1.5f, 3.f, 1.5f, 3.f); // 设置左内边距
        _tagLabel.borderColor = kColorWithRGB(102, 102, 102);
        _tagLabel.borderWidth = kLinerViewHeight;
        [_tagLabel lz_setCornerRadius:2.0];
        [_tagLabel sizeToFit]; // 重新计算尺寸
    }
    return _tagLabel;
}

- (UIButton *)guanzhuButton{
    if (!_guanzhuButton) {
        _guanzhuButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_guanzhuButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [_guanzhuButton setTitleColor:kTextColor153 forState:UIControlStateSelected];
        _guanzhuButton.titleLabel.font = kFontSizeMedium12;
        [_guanzhuButton lz_setCornerRadius:4.0];
        [_guanzhuButton setTitle:@"关注" forState:UIControlStateNormal];
        [_guanzhuButton setTitle:@"已关注" forState:UIControlStateSelected];
        [_guanzhuButton setBackgroundImage:imageColor(kTextColor238) forState:UIControlStateSelected];
        [_guanzhuButton setBackgroundImage:[UIImage lz_imageWithColor:[UIColor lz_colorWithHexString:@"#F85A59"]] forState:UIControlStateNormal];
        _guanzhuButton.selected = YES;
    }
    return _guanzhuButton;
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
@end
