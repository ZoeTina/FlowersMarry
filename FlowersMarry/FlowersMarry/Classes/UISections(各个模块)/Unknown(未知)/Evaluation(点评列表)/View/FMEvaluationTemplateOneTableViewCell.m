//
//  FMEvaluationTemplateOneTableViewCell.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/8/22.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMEvaluationTemplateOneTableViewCell.h"

@implementation FMEvaluationTemplateOneTableViewCell

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
    }
    return self;
}

- (void)setEvaluationModel:(BusinessComment *)evaluationModel{
    _evaluationModel = evaluationModel;
    [self initView];
    [self initConstraint];
    [self.imagesView sd_setImageWithURL:kGetVideoURL(self.evaluationModel.avatar) placeholderImage:kGetImage(imagePlaceholder)];
    self.nicknameLabel.text = self.evaluationModel.user_name;
    self.datetimeLabel.text = self.evaluationModel.ct_add_time;
//    self.startRating.currentScore = [self.evaluationModel.ct_level floatValue];
    self.titleLabel.text = self.evaluationModel.ct_content;
}

- (void) initView{
    [self addSubview:self.imagesView];
    [self addSubview:self.nicknameLabel];
    [self addSubview:self.datetimeLabel];
    [self addSubview:self.titleLabel];
    [self addSubview:self.startRating];
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
        make.bottom.equalTo(self.mas_bottom).offset(-15);
    }];
    
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
@end
