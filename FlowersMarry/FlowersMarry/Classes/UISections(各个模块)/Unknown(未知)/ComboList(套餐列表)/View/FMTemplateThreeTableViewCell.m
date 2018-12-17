//
//  FMTemplateThreeTableViewCell.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/12.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMTemplateThreeTableViewCell.h"

@implementation FMTemplateThreeTableViewCell

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
        
    }
    return self;
}


- (void)setTaoxiModel:(BusinessTaoxiModel *)taoxiModel{
    _taoxiModel = taoxiModel;
    [self initView];
}

- (void) initView{
    
    self.titleLabel.text = self.taoxiModel.tx_title;
    self.subtitleLabel.text = self.taoxiModel.tx_subtitle;
    self.priceLabel.text = [self setPirceValue:self.taoxiModel.tx_price];
    self.oldPriceLabel.text = [self setPirceValue:self.taoxiModel.tx_first_price];
    
    NSAttributedString *commentAttr = [SCSmallTools sc_initBrowseImageWithText:self.taoxiModel.tx_hits];
    self.browseLabel.attributedText = commentAttr;
    
    [self addSubview:self.titleLabel];
    [self addSubview:self.subtitleLabel];
    [self addSubview:self.oldPriceLabel];
    [self addSubview:self.priceLabel];
    [self addSubview:self.browseLabel];
    [self addSubview:self.linerView];
    
    
    [self setConstraint];
    
}

- (NSString *) setPirceValue:(NSString *) price{
    return [NSString stringWithFormat:@"￥%@",price];
}


- (void) setConstraint{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(@(10));
        make.height.equalTo(@(22));
        make.right.equalTo(self.mas_right).offset(IPHONE6_W(-15));
    }];
    [self.subtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.titleLabel);
//        make.height.equalTo(@(sub_height));
        make.top.equalTo(self.titleLabel.mas_bottom).offset(5);
    }];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.height.equalTo(@(15));
        make.top.equalTo(self.subtitleLabel.mas_bottom).offset(5);
        make.bottom.equalTo(self.mas_bottom).offset(-10);
    }];
    
    [self.oldPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.priceLabel);
        make.left.mas_equalTo(self.priceLabel.mas_right).offset(IPHONE6_W(4));
    }];
    [self.browseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.titleLabel);
        make.centerY.equalTo(self.priceLabel);
    }];
    [self.linerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom);
        make.left.right.equalTo(self);
        make.height.equalTo(@(kLinerViewHeight));
    }];
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel lz_labelWithTitle:@"" color:kTextColor34 font:kFontSizeScBold20];
    }
    return _titleLabel;
}

- (UILabel *)subtitleLabel{
    if (!_subtitleLabel) {
        _subtitleLabel = [UILabel lz_labelWithTitle:@"" color:kTextColor136 font:kFontSizeMedium12];
        _subtitleLabel.numberOfLines = 0;
    }
    return _subtitleLabel;
}

- (UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel = [UILabel lz_labelWithTitle:@"" color:kColorWithRGB(255, 65, 99) font:kFontSizeMedium12];
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

- (UIView *)linerView{
    if (!_linerView) {
        _linerView = [UIView lz_viewWithColor:kLinerViewColor];
    }
    return _linerView;
}

@end
