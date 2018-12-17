//
//  FMTemplateOneTableViewCell.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/6.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMTemplateOneTableViewCell.h"

@implementation FMTemplateOneTableViewCell

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
    }
    return self;
}

- (void)setCasesModel:(BusinessCasesModel *)casesModel{
    _casesModel = casesModel;
    self.titleLabel.text = self.casesModel.case_title;
    self.subtitleLabel.text = self.casesModel.case_content;
    self.scenarioLabel.text = [NSString stringWithFormat:@"场景:%@",self.casesModel.case_location];
    if (self.casesModel.case_fg.count>0) {
        NSString *printStr = @"";
        for (int i=0; i<self.casesModel.case_fg.count; i++) {
            BusinessCasesStyleModel *model = self.casesModel.case_fg[i];
            if (i!=0) {
                printStr = [printStr stringByAppendingFormat:@",%@", model.fg_name];
            }else{
                printStr = [printStr stringByAppendingFormat:@"%@", model.fg_name];
            }
        }
        self.styleLabel.text = [NSString stringWithFormat:@"风格:%@",printStr];
    }
    TTLog(@"self.casesModel.taoxi.tx_price --- %@",self.casesModel.taoxi.tx_price);
    self.priceLabel.text = [NSString stringWithFormat:@"￥%@",([NSObject sc_isNullOrNilWithObject:self.casesModel.taoxi]) ? @"0" : self.casesModel.taoxi.tx_price];
    self.priceTextLabel.text = @"参考价";
    [self initView];
    
    NSAttributedString *commentAttr = [SCSmallTools sc_initBrowseImageWithText:self.casesModel.case_hits];
    self.browseLabel.attributedText = commentAttr;
}

- (void) initView{
    
    [self addSubview:self.titleLabel];
    [self addSubview:self.subtitleLabel];
    [self addSubview:self.scenarioLabel];
    [self addSubview:self.styleLabel];
    [self addSubview:self.priceTextLabel];
    [self addSubview:self.priceLabel];
    [self addSubview:self.browseLabel];

    [self addSubview:self.linerView];
    [self setConstraint];
}

- (void) setConstraint{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(@(IPHONE6_W(15)));
        make.right.equalTo(self.mas_right).offset(IPHONE6_W(-15));
    }];
    [self.subtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(IPHONE6_W(10));
    }];
    [self.scenarioLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.subtitleLabel.mas_bottom).offset(IPHONE6_W(10));
    }];
    [self.styleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scenarioLabel.mas_right).offset(IPHONE6_W(15));
        make.centerY.equalTo(self.scenarioLabel);
    }];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.height.equalTo(@(15));
        make.top.equalTo(self.scenarioLabel.mas_bottom).offset(IPHONE6_W(10));
        make.bottom.equalTo(self.mas_bottom).offset(IPHONE6_W(-15));
    }];
    
    [self.priceTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.priceLabel);
        make.left.equalTo(self.priceLabel.mas_right).offset(IPHONE6_W(4));
    }];
    [self.browseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(IPHONE6_W(-15));
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
    }
    return _subtitleLabel;
}

- (UILabel *)scenarioLabel{
    if (!_scenarioLabel) {
        _scenarioLabel = [UILabel lz_labelWithTitle:@"" color:kTextColor136 font:kFontSizeMedium12];
    }
    return _scenarioLabel;
}

- (UILabel *)styleLabel{
    if (!_styleLabel) {
        _styleLabel = [UILabel lz_labelWithTitle:@"" color:kTextColor136 font:kFontSizeMedium12];
    }
    return _styleLabel;
}

- (UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel = [UILabel lz_labelWithTitle:@"" color:HexString(@"#FF4163") font:kFontSizeMedium15];
    }
    return _priceLabel;
}
- (UILabel *)priceTextLabel{
    if (!_priceTextLabel) {
        _priceTextLabel = [UILabel lz_labelWithTitle:@"" color:kTextColor136 font:kFontSizeMedium12];
    }
    return _priceTextLabel;
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
