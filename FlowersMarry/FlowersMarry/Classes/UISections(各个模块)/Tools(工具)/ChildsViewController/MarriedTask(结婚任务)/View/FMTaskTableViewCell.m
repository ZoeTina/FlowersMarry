//
//  FMTaskTableViewCell.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/10/13.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMTaskTableViewCell.h"

@implementation FMTaskTableViewCell

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
        [self initView];
    }
    return self;
}

- (void) initView{
    [self addSubview:self.selectBtn];
    [self addSubview:self.titleLabel];
    [self addSubview:self.imagesArrow];
    [self addSubview:self.subtitleLabel];
    [self addSubview:self.tagButton];
    
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(20));
        make.centerY.equalTo(self);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.selectBtn.mas_right).offset(12);
    }];
    
    [self.imagesArrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self.mas_right).offset(-20);
    }];
    [self.subtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self.imagesArrow.mas_left).offset(-9);
    }];
    [self.tagButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-15);
        make.top.equalTo(self);
        make.height.equalTo(@(12));
        make.width.equalTo(@(28));
    }];
    
    // 这里设置需要绘制的圆角
    CGRect rect = CGRectMake(0, 0, 28, 12);

    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:rect
                                                   byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight
                                                         cornerRadii:CGSizeMake(3,3)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = rect;
    maskLayer.path = maskPath.CGPath;
    self.tagButton.layer.mask = maskLayer;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel lz_labelWithTitle:@"" color:kTextColor51 font:kFontSizeMedium12];
    }
    return _titleLabel;
}

- (UIButton *)selectBtn{
    if (!_selectBtn) {
        _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _selectBtn.selected = NO;
        [_selectBtn setImage:kGetImage(@"tools_img_unselected") forState:UIControlStateNormal];
        [_selectBtn setImage:kGetImage(@"tools_img_selected") forState:UIControlStateSelected];
    }
    return _selectBtn;
}

- (UIImageView *)imagesArrow{
    if (!_imagesArrow) {
        _imagesArrow = [[UIImageView alloc] init];
        _imagesArrow.image = kGetImage(@"tools_img_arrow");
    }
    return _imagesArrow;
}

- (UILabel *)subtitleLabel{
    if (!_subtitleLabel) {
        _subtitleLabel = [UILabel lz_labelWithTitle:@"" color:kTextColor153 font:kFontSizeMedium12];
    }
    return _subtitleLabel;
}

- (UIButton *)tagButton{
    if (!_tagButton) {
        _tagButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_tagButton setTitle:@"我的" forState:UIControlStateNormal];
        _tagButton.titleLabel.font = kFontSizeMedium10;
        [_tagButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [_tagButton setBackgroundImage:[UIImage lz_imageWithColor:HexString(@"#FFBE3B")] forState:UIControlStateNormal];
        _tagButton.hidden = YES;
    }
    return _tagButton;
}
@end
