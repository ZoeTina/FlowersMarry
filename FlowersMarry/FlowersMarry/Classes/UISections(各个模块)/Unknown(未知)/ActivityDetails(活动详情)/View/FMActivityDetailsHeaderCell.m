//
//  FMActivityDetailsHeaderCell.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/11.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMActivityDetailsHeaderCell.h"

@implementation FMActivityDetailsHeaderCell

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

- (void)setHuodongModel:(BusinessHuodongModel *)huodongModel{
    _huodongModel = huodongModel;
    [self initView];

}

- (void) initView{

    self.titleLabel.text = self.huodongModel.hd_title;
    NSAttributedString *commentAttr = [SCSmallTools sc_initBrowseImageWithText:self.huodongModel.hd_hits];
    self.browseLabel.attributedText = commentAttr;

    [self addSubview:self.titleLabel];
    [self addSubview:self.timeimages];
    [self addSubview:self.timeLabel];
    [self addSubview:self.browseLabel];
    [self addSubview:self.linesView];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(IPHONE6_W(15)));
        make.top.equalTo(@(IPHONE6_W(19)));
        make.right.equalTo(self.mas_right).offset(IPHONE6_W(-15));
        make.bottom.equalTo(self.timeimages.mas_top).offset(IPHONE6_W(-15));
    }];
    
    [self.timeimages mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(IPHONE6_W(15)));
        make.bottom.equalTo(self.mas_bottom).offset(IPHONE6_W(-17));
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.timeimages.mas_right).offset(IPHONE6_W(6));
        make.centerY.equalTo(self.timeimages);
    }];
    [self.browseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.timeimages);
        make.right.equalTo(self.mas_right).offset(IPHONE6_W(-15));
    }];
    [self.linesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self);
        make.height.equalTo(@(kLinerViewHeight));
    }];
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel lz_labelWithTitle:@"" color:kTextColor34 font:kFontSizeScBold20];
        _titleLabel.numberOfLines = 2;
    }
    return _titleLabel;
}

- (UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [UILabel lz_labelWithTitle:@"" color:kTextColor136 font:kFontSizeMedium12];
    }
    return _timeLabel;
}

- (UILabel *)browseLabel{
    if (!_browseLabel) {
        _browseLabel = [UILabel lz_labelWithTitle:@"" color:kTextColor136 font:kFontSizeMedium12];
    }
    return _browseLabel;
}

- (UIImageView *)timeimages{
    if (!_timeimages) {
        _timeimages = [[UIImageView alloc] init];
        _timeimages.image = kGetImage(@"live_btn_time");
    }
    return _timeimages;
}

- (UIView *)linesView{
    if (!_linesView) {
        _linesView = [UIView lz_viewWithColor:kColorWithRGB(221, 221, 221)];
    }
    return _linesView;
}
@end
