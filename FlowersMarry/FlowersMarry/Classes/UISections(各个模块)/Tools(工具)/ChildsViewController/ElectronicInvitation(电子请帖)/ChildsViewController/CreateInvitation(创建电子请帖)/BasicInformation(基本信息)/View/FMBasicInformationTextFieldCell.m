//
//  FMBasicInformationTextFieldCell.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/11/6.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMBasicInformationTextFieldCell.h"

@implementation FMBasicInformationTextFieldCell

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
    }
    return self;
}

- (void) initView{
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.textField];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(15));
        make.centerY.equalTo(self);
    }];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(90));
        make.top.bottom.equalTo(self);
        make.right.equalTo(self.mas_right).offset(-15);
    }];
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel lz_labelWithTitle:@"" color:kTextColor34 font:kFontSizeMedium14];
    }
    return _titleLabel;
}

- (UITextField *)textField{
    if (!_textField) {
        _textField = [UITextField lz_textFieldWithPlaceHolder:@"请输入您的预算总金额"];
        _textField.returnKeyType = UIReturnKeyDone;
        _textField.borderStyle = UITextBorderStyleNone;
        _textField.delegate = self;
        _textField.textColor = kTextColor102;
        _textField.font = kFontSizeMedium14;
    }
    return _textField;
}
@end
