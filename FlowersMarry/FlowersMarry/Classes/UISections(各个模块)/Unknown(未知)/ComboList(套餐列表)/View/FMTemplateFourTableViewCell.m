//
//  FMTemplateFourTableViewCell.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/12.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMTemplateFourTableViewCell.h"

@implementation FMTemplateFourTableViewCell

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
    }
    return self;
}

- (void)setBusinessModel:(BusinessModel *)businessModel{
    _businessModel = businessModel;
    [self initView];
}


- (void) initView{
    
    self.titleLabel.text = self.businessModel.cp_fullname;
    [self.imagesView sd_setImageWithURL:kGetImageURL(self.businessModel.cp_logo) placeholderImage:kGetImage(imagePlaceholder)];
    BusinessAuthModel *authModel= self.businessModel.auth;
    self.baoImagesView.hidden = (authModel.xb==0) ? YES : NO;
    self.qiImagesView.hidden = ((authModel.qy==0) && (authModel.gt == 0)) ? YES :NO;
    self.recommendedImagesView.hidden = (authModel.isavip==0) ? YES : NO;
    
    if (!self.baoImagesView.hidden) {
        self.baoImagesView.image = kGetImage(@"business_bao");
    }
    
    if (authModel.qy==1) {
        self.qiImagesView.image = kGetImage(@"business_qi");
    }else if (authModel.gt==1){
        self.qiImagesView.image = kGetImage(@"business_ge");
    }
    
    MV(weakSelf)
    self.startRating.currentScoreChangeBlock = ^(CGFloat score){
//        weakSelf.scoreLabel.text = [NSString stringWithFormat:@"%.1f 星",score];
    };
    
    // 请在设置完成最大最小的分数后再设置当前分数
//    self.startRating.currentScore = 0.0f;
    
    [self addSubview:self.titleLabel];
    [self addSubview:self.imagesView];
    [self addSubview:self.baoImagesView];
    [self addSubview:self.qiImagesView];
    [self addSubview:self.recommendedImagesView];
    [self addSubview:self.startRating];
    [self addSubview:self.scoreLabel];
    
    [self initConstraints];
}

- (void)initConstraints{
    
    [self.imagesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(8);
        make.centerY.mas_equalTo(self);
        make.width.height.mas_equalTo(60);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.imagesView.mas_right).mas_offset(10);
        make.height.mas_equalTo(20);
        make.top.mas_equalTo(self.imagesView.mas_top).mas_offset(12);
    }];
    
    [self.startRating mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel).offset(-3);
        make.bottom.equalTo(self.imagesView.mas_bottom).offset(-8);
        make.height.equalTo(@20);
    }];
    
    [self.scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.imagesView.mas_right).mas_offset(92);
        make.centerY.mas_equalTo(self.startRating);
    }];
    
    [self.baoImagesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.scoreLabel.mas_right).mas_offset(5);
        make.centerY.mas_equalTo(self.scoreLabel);
    }];

    [self.qiImagesView mas_makeConstraints:^(MASConstraintMaker *make) {
        CGFloat left=3.0;
//        if (self.baoImagesView.hidden) {
//            left = 5.0;
//        }
        make.left.mas_equalTo(self.baoImagesView.mas_right).mas_offset(left);
        make.centerY.mas_equalTo(self.scoreLabel);
    }];
    [self.recommendedImagesView mas_makeConstraints:^(MASConstraintMaker *make) {
        CGFloat left=3.0;
//        if (self.baoImagesView.hidden&&self.qiImagesView.hidden) {
//            left = 5.0;
//        }else if(self.qiImagesView.hidden){
//            left = 0.0;
//        }
        make.left.mas_equalTo(self.qiImagesView.mas_right).mas_offset(left);
        make.centerY.mas_equalTo(self.scoreLabel);
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

@end
