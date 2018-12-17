//
//  FMMarriedBooksTextTableViewCell.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/9/28.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMMarriedBooksTextTableViewCell.h"

@implementation FMMarriedBooksTextTableViewCell

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
        self.titleLabel.text = @"婚照";
        self.subtitleLabel.text = @"婚照";
        self.timeLabel.text = @"2018-08-03";
        self.remarkLabel.text = @"婚纱摄影";
        self.priceLabel.text = @"￥5600";
        self.imagesView.image = kGetImage(@"tools_img_hunzhao");
    }
    return self;
}

- (void) initView{
    [self addSubview:self.linerView];
    [self addSubview:self.dotView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.imagesView];
    [self addSubview:self.subtitleLabel];
    [self addSubview:self.timeLabel];
    [self addSubview:self.remarkLabel];
    [self addSubview:self.priceLabel];
    [self.linerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(54));
        make.width.equalTo(@(1));
        make.bottom.top.equalTo(self);
    }];
    [self.dotView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.linerView);
        make.width.height.equalTo(@(3));
        make.top.equalTo(@(28));
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(0));
        make.right.centerY.equalTo(self.dotView);
    }];
    [self.imagesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dotView.mas_right).offset(14);
        make.centerY.equalTo(self.dotView);
    }];
    [self.subtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imagesView.mas_right).offset(13);
        make.centerY.equalTo(self.imagesView);
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.subtitleLabel);
        make.top.equalTo(self.dotView.mas_bottom).offset(8);
    }];
    [self.remarkLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.timeLabel.mas_right).offset(7);
        make.centerY.equalTo(self.timeLabel);
    }];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-15);
        make.centerY.equalTo(self.titleLabel);
    }];
}

- (UIView *)linerView{
    if (!_linerView) {
        _linerView = [UIView lz_viewWithColor:HexString(@"#FFEFF1")];
    }
    return _linerView;
}

- (UIView *)dotView{
    if (!_dotView) {
        _dotView = [UIView lz_viewWithColor:HexString(@"#FF4163")];
        [_dotView lz_setCornerRadius:1.5];
    }
    return _dotView;
}

- (UIImageView *)imagesView{
    if (!_imagesView) {
        _imagesView = [[UIImageView alloc] init];
    }
    return _imagesView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel lz_labelWithTitle:@"" color:HexString(@"#666666") font:kFontSizeMedium12];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}
- (UILabel *)subtitleLabel{
    if (!_subtitleLabel) {
        _subtitleLabel = [UILabel lz_labelWithTitle:@"" color:HexString(@"#333333") font:kFontSizeMedium14];
    }
    return _subtitleLabel;
}

- (UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [UILabel lz_labelWithTitle:@"" color:HexString(@"#999999") font:kFontSizeMedium12];
    }
    return _timeLabel;
}

- (UILabel *)remarkLabel{
    if (!_remarkLabel) {
        _remarkLabel = [UILabel lz_labelWithTitle:@"" color:HexString(@"#999999") font:kFontSizeMedium12];
    }
    return _remarkLabel;
}

- (UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel = [UILabel lz_labelWithTitle:@"" color:HexString(@"#FF4163") font:kFontSizeMedium14];
    }
    return _priceLabel;
}

@end
