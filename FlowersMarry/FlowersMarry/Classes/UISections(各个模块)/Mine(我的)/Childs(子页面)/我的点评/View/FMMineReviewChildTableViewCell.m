//
//  FMMineReviewChildTableViewCell.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/16.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMMineReviewChildTableViewCell.h"

@implementation FMMineReviewChildTableViewCell

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
        self.contentView.backgroundColor = kColorWithRGB(244, 248, 251);
        [self initView];
    }
    return self;
}

- (void)setModel:(MineReviewListModel *)model{
    _model = model;
    MV(weakSelf)
    self.startRating.currentScoreChangeBlock = ^(CGFloat score){
//        weakSelf.scoreLabel.text = [NSString stringWithFormat:@"%.1f 星",score];
    };
    
    // 请在设置完成最大最小的分数后再设置当前分数
//    self.startRating.currentScore = model.score;
    
    self.titleLabel.text = model.cp_fullname;
    [self.imagesView sd_setImageWithURL:kGetImageURL(model.cp_logo) placeholderImage:kGetImage(imagePlaceholder)];
    ///  (0:否 1:是)
    if (model.auth.qy == 1) {
        self.enterpriseImages.image = kGetImage(@"business_qi");
    }else if(model.auth.gt == 1){
        self.enterpriseImages.image = kGetImage(@"business_ge");
    }
    
    self.enterpriseImages.hidden = (model.auth.gt==0&&model.auth.qy==0)?YES:NO;
    self.baoImages.hidden = model.auth.xb==0?YES:NO;
    self.recommendImages.hidden = model.auth.isavip==0?YES:NO;
    self.tagLabel.text = model.channel_name;
}

- (void) initView{

    [self addSubview:self.titleLabel];
    [self addSubview:self.imagesView];
    [self addSubview:self.scoreLabel];
    [self addSubview:self.baoImages];
    [self addSubview:self.enterpriseImages];
    [self addSubview:self.recommendImages];
    [self addSubview:self.tagLabel];
    [self addSubview:self.startRating];
    [self addSubview:self.scoreLabel];

    [self setConstraint];
    
}

- (void) setConstraint{
    CGFloat left = IPHONE6_W(10);
    [self.imagesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(@(left));
        make.height.width.equalTo(@50);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imagesView.mas_top);
        make.height.equalTo(@(IPHONE6_W(14)));
        make.left.equalTo(self.imagesView.mas_right).offset(left);
        make.right.equalTo(self.mas_right).offset(left);
    }];
    
    [self.startRating mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.centerY.equalTo(self.imagesView);
        make.height.equalTo(@20);
    }];
    
    [self.scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imagesView.mas_right).offset(92);
        make.centerY.equalTo(self.startRating);
    }];
    
    [self.baoImages mas_makeConstraints:^(MASConstraintMaker *make) {
        CGFloat left = 7;
        if (self.baoImages.hidden) {
            make.width.equalTo(@0);
            left = 3;
        }
        make.left.equalTo(self.scoreLabel.mas_right).offset(left);
        make.centerY.equalTo(self.scoreLabel);

    }];
    [self.enterpriseImages mas_makeConstraints:^(MASConstraintMaker *make) {
        CGFloat left = 7;
        if (self.enterpriseImages.hidden) {
            make.width.equalTo(@0);
            left = 0;
        }
        make.left.equalTo(self.baoImages.mas_right).offset(left);
        make.centerY.equalTo(self.scoreLabel);
    }];
    [self.recommendImages mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.enterpriseImages.mas_right).offset(4);
        make.centerY.equalTo(self.scoreLabel);
    }];
    
    [self.tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.bottom.equalTo(self.imagesView.mas_bottom);
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
        _imagesView.borderWidth = 0.7;
        _imagesView.borderColor = kTextColor238;
        [_imagesView lz_setCornerRadius:2.0];
    }
    return _imagesView;
}

- (UIImageView *)baoImages{
    if (!_baoImages) {
        _baoImages = [[UIImageView alloc] init];
        _baoImages.image = kGetImage(@"business_bao");
        _baoImages.hidden = YES;
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
        _recommendImages.image = kGetImage(@"business_tuijian");
        _recommendImages.hidden = YES;
    }
    return _recommendImages;
}

- (SCCustomMarginLabel *)tagLabel{
    if (!_tagLabel) {
        _tagLabel = [[SCCustomMarginLabel alloc] init];
        _tagLabel.textAlignment = NSTextAlignmentCenter;
        _tagLabel.textColor = kTextColor136;
        _tagLabel.font = kFontSizeMedium10;
        _tagLabel.edgeInsets    = UIEdgeInsetsMake(1.0f, 2.f, 1.0f, 2.f); // 设置左内边距
        _tagLabel.borderColor = kColorWithRGB(102, 102, 102);
        _tagLabel.borderWidth = 0.7;
        [_tagLabel lz_setCornerRadius:2.0];
        [_tagLabel sizeToFit]; // 重新计算尺寸
    }
    return _tagLabel;
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
