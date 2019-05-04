//
//  FMComboListTableViewCell.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/2.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMComboListTableViewCell.h"

@implementation FMComboListTableViewCell

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
        [self setData];
    }
    return self;
}

- (void)setData{
    
    self.imagesView.image = kGetImage(@"base_image_tu63");
    self.titleLabel.text = @"【限时特惠】2999享8服8造最";
    self.subtitleLabel.text = @"仅预约报名享受，直接到店不享受";
    self.priceLabel.text = @"¥3999";
    self.oldPriceLabel.text = @"¥5999";
    
    NSAttributedString *commentAttr = [SCSmallTools sc_initBrowseImageWithText:@"1326"];
    self.browseLabel.attributedText = commentAttr;
}

- (void) initView{
    
    [self addSubview:self.imagesView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.subtitleLabel];
    [self addSubview:self.priceLabel];
    [self addSubview:self.oldPriceLabel];
    [self addSubview:self.browseLabel];
    [self addSubview:self.linerViewCell];

    [self setConstraint];

}

- (void) setConstraint{
    [self.imagesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(15));
        make.height.mas_equalTo(IPHONE6_W(102));
        make.width.mas_equalTo(IPHONE6_W(152));
        make.centerY.equalTo(self);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imagesView.mas_right).offset(13);
        make.right.equalTo(self.mas_right).offset(-15);
        make.top.equalTo(self.imagesView.mas_top);
    }];
    [self.browseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.bottom.equalTo(self.imagesView);
    }];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.bottom.equalTo(self.browseLabel.mas_top).offset(-5);
    }];
    [self.oldPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.priceLabel.mas_right).offset(10);
        make.centerY.equalTo(self.priceLabel);
    }];
    [self.subtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.bottom.equalTo(self.priceLabel.mas_top).offset(-5);
        make.right.equalTo(self.mas_right).offset(-15);
        make.height.equalTo(@(12));
    }];
    [self.linerViewCell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.equalTo(@(kLinerViewHeight));
    }];
}

- (UIImageView *)imagesView{
    if (!_imagesView) {
        _imagesView = [[UIImageView alloc] init];
        [_imagesView lz_setCornerRadius:3.0];
    }
    return _imagesView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel lz_labelWithTitle:@"" color:kTextColor51 font:kFontSizeScBold14];
        _titleLabel.numberOfLines = 2;
    }
    return _titleLabel;
}
- (UILabel *)subtitleLabel{
    if (!_subtitleLabel) {
        _subtitleLabel = [UILabel lz_labelWithTitle:@"" color:kTextColor136 font:kFontSizeMedium12];
        _subtitleLabel.numberOfLines = 1;
    }
    return _subtitleLabel;
}
- (UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel = [UILabel lz_labelWithTitle:@"" color:kColorWithRGB(255, 65, 99) font:kFontSizeMedium13];
    }
    return _priceLabel;
}
- (SCDeleteLineLabel *)oldPriceLabel{
    if (!_oldPriceLabel) {
        /// 不能使用快捷方式创建
        _oldPriceLabel = [[SCDeleteLineLabel alloc] init];
        _oldPriceLabel.textColor = kTextColor136;
        _oldPriceLabel.font = kFontSizeMedium12;
        [_oldPriceLabel sizeToFit];
    }
    return _oldPriceLabel;
}

- (UILabel *)browseLabel{
    if (!_browseLabel) {
        _browseLabel = [UILabel lz_labelWithTitle:@"" color:kTextColor136 font:kFontSizeMedium12];
    }
    return _browseLabel;
}

- (UIView *)linerViewCell{
    if (!_linerViewCell) {
        _linerViewCell = [UIView lz_viewWithColor:kLinerViewColor];
        _linerViewCell.hidden = YES;
    }
    return _linerViewCell;
}

@end
