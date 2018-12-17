//
//  FMBudgetDetailsTableViewCell.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/10/10.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMBudgetDetailsTableViewCell.h"

@implementation FMBudgetDetailsTableViewCell

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
    
    self.textField.text = @"3000";
    [self addSubview:self.imagesView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.textField];
    [self addSubview:self.iconLabel];
    [self addSubview:self.editButton];
    
    [self.imagesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.mas_equalTo(15);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.imagesView.mas_right).offset(10);
    }];
    [self.iconLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self).offset(-20);
        make.centerY.equalTo(self);
    }];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.height.equalTo(self);
        make.left.equalTo(self.iconLabel.mas_right).offset(3);
        make.width.equalTo(@(200));
    }];
    [self.editButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.height.equalTo(self);
        make.right.equalTo(self.mas_right).offset(-30);
    }];
}

- (UIImageView *)imagesView{
    if (!_imagesView) {
        _imagesView = [[UIImageView alloc] init];
    }
    return _imagesView;
}


- (UILabel *)iconLabel{
    if (!_iconLabel) {
        _iconLabel = [UILabel lz_labelWithTitle:@"￥" color:HexString(@"#FF4163") font:kFontSizeMedium12];
    }
    return _iconLabel;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel lz_labelWithTitle:@"" color:kTextColor51 font:kFontSizeMedium12];
    }
    return _titleLabel;
}

- (UITextField *)textField{
    if (!_textField) {
        _textField = [UITextField lz_textFieldWithPlaceHolder:@"请输入金额"];
        _textField.returnKeyType = UIReturnKeyDone;
        _textField.borderStyle = UITextBorderStyleNone;
        _textField.delegate = self;
        _textField.font = kFontSizeMedium15;
        _textField.textColor = HexString(@"#FF4163");
    }
    return _textField;
}

- (UIButton *)editButton{
    if (!_editButton) {
        _editButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_editButton setImage:kGetImage(@"tools_btn_yusuan_edit") forState:UIControlStateNormal];
    }
    return _editButton;
}


@end
