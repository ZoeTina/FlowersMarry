//
//  FMMerchantsHomeInSectionCell.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/3.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMMerchantsHomeInSectionCell.h"

@implementation FMMerchantsHomeInSectionCell

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
    [self addSubview:self.lineView];
//    [self addSubview:self.linesView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.subtitleLabel];
    [self addSubview:self.arrowImageView];
//    [self.linesView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(@(kLinerViewHeight));
//        make.width.mas_equalTo(self);
//        make.bottom.mas_equalTo(self.mas_bottom);
//    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(14);
        make.left.mas_equalTo(15);
        make.width.mas_equalTo(3);
        make.height.mas_equalTo(14);
        make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-14);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.left.mas_equalTo(self.lineView.mas_left).mas_offset(14);
    }];
    
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.right.mas_equalTo(self).mas_offset(-15);
    }];
    
    [self.subtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.right.mas_equalTo(self.arrowImageView.mas_left).mas_offset(-6);
    }];
    
}

- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [UIView lz_viewWithColor:[UIColor lz_colorWithHexString:@"#FF4163"]];
    }
    return _lineView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel lz_labelWithTitle:@"" color:kTextColor51
                                            font:kFontSizeMedium14];
    };
    return _titleLabel;
}

//- (UIView *)linesView{
//    if (!_linesView) {
//        _linesView = [UIView lz_viewWithColor:kLinerViewColor];
//    }
//    return _linesView;
//}
- (UILabel *)subtitleLabel{
    if (!_subtitleLabel) {
        _subtitleLabel = [UILabel lz_labelWithTitle:@"" color:kTextColor136
                                               font:kFontSizeMedium12];
    };
    return _subtitleLabel;
}

- (UIImageView *)arrowImageView{
    if (!_arrowImageView) {
        _arrowImageView = [[UIImageView alloc] init];
        _arrowImageView.image = kGetImage(@"right_arrow");
    }
    return _arrowImageView;
}

@end
