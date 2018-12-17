//
//  FMTelPhoneBindTableViewCell.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/9.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMTelPhoneBindTableViewCell.h"


@interface FMTelPhoneBindTableViewCell()<UITextFieldDelegate>
@end
@implementation FMTelPhoneBindTableViewCell

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

    [self addSubview:self.titleLabel];
    [self addSubview:self.textField];
    [self addSubview:self.codeButton];

    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(IPHONE6_W(15));
        make.centerY.mas_equalTo(self);
    }];
    [self.codeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).mas_offset(IPHONE6_W(-15));
        make.centerY.mas_equalTo(self);
    }];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(IPHONE6_W(80));
        make.right.mas_equalTo(self.mas_right).mas_offset(IPHONE6_W(-80));
        make.height.centerY.mas_equalTo(self);
    }];
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel lz_labelWithTitle:@"" color:kTextColor51 font:kFontSizeMedium14];
    }
    return _titleLabel;
}

- (UITextField *)textField{
    if (!_textField) {
        _textField = [UITextField lz_textFieldWithPlaceHolder:@"请输入手机号"];
        _textField.returnKeyType = UIReturnKeyDone;
        _textField.borderStyle = UITextBorderStyleNone;
        _textField.delegate = self;
        _textField.font = kFontSizeMedium13;
    }
    return _textField;
}

- (UIButton *)codeButton{
    if (!_codeButton) {
        _codeButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_codeButton setTitleColor:[UIColor lz_colorWithHexString:@"#409EFF"] forState:UIControlStateNormal];
        _codeButton.titleLabel.font = kFontSizeMedium13;
        [_codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        //        MV(weakSelf);
        [_codeButton lz_handleControlEvent:UIControlEventTouchUpInside withBlock:^{
            //            [weakSelf handleButtonTapped:_codeButton];
            
        }];
    }
    return _codeButton;
}
@end
