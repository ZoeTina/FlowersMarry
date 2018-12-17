//
//  FMMerchantsHomeAddressTableViewCell.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/2.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMMerchantsHomeAddressTableViewCell.h"

@implementation FMMerchantsHomeAddressTableViewCell

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
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initView];
    }
    return self;
}

- (void) initView{
    [self addSubview:self.titleLabel];
    [self addSubview:self.leftImageView];
    [self addSubview:self.rightImageView];
    [self addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self);
        make.height.mas_equalTo(@(kLinerViewHeight));
    }];
    [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(self);
    }];
    [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).offset(-15);
        make.centerY.mas_equalTo(self);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_left).mas_offset(30);
        make.centerY.mas_equalTo(self);
        make.right.mas_equalTo(self.mas_right).mas_offset(-35);
    }];
//    self.titleLabel.text = @"[青羊区] 太升南路288号锦天国际C座10楼1...";
}


- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel lz_labelWithTitle:@"1" color:kTextColor34 font:kFontSizeMedium13];
    }
    return _titleLabel;
}

- (UIImageView *)leftImageView{
    if(!_leftImageView){
        _leftImageView = [[UIImageView alloc] init];
        _leftImageView.image = kGetImage(@"base_merchant_position");
    }
    return _leftImageView;
}


- (UIImageView *)rightImageView{
    if(!_rightImageView){
        _rightImageView = [[UIImageView alloc] init];
        _rightImageView.image = kGetImage(@"base_merchant_phone");
    }
    return _rightImageView;
}

- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [UIView lz_viewWithColor:kLinerViewColor];
    }
    return _lineView;
}

@end
