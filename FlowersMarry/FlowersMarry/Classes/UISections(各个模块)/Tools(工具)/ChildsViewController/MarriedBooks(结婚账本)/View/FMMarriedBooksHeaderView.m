//
//  FMMarriedBooksHeaderView.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/9/28.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMMarriedBooksHeaderView.h"

@interface FMMarriedBooksHeaderView()
@property (nonatomic, copy) FMToolsMarriedBooksHeaderViewBlock headViewBlock;

@end

@implementation FMMarriedBooksHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = kWhiteColor;
        [self initView];
    }
    return self;
}

- (void) initView{
    [self addSubview:self.titleLabel];
    [self addSubview:self.tipsLabel];
    [self addSubview:self.priceLabel];
    [self addSubview:self.rememberButton];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(@(26));
        make.height.equalTo(@(13));
    }];
    
    [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(50));
        make.bottom.equalTo(self.mas_bottom).offset(-43);
    }];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.tipsLabel.mas_right).offset(5);
        make.centerY.equalTo(self.tipsLabel);
    }];
    [self.rememberButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-50);
        make.centerY.equalTo(self.tipsLabel);
        make.width.equalTo(@(80));
        make.height.equalTo(@(28));
    }];
}

- (void)setToolsBooksTableHeadViewBlock:(FMToolsMarriedBooksHeaderViewBlock)block{
    self.headViewBlock = block;
}

- (IBAction)headImageBtnClicked:(id)sender {
    if (self.headViewBlock) {
        self.headViewBlock();
    }
}

- (UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [UILabel lz_labelWithTitle:@"" color:kTextColor102 font:kFontSizeMedium14];
    }
    return _titleLabel;
}

- (UILabel *)tipsLabel{
    if(!_tipsLabel){
        _tipsLabel = [UILabel lz_labelWithTitle:@"已消费￥" color:kTextColor51 font:kFontSizeMedium13];
    }
    return _tipsLabel;
}

- (UILabel *)priceLabel{
    if(!_priceLabel){
        _priceLabel = [UILabel lz_labelWithTitle:@"已消费￥" color:HexString(@"#FF4163") font:kFontSizeDisplayMedium22];
    }
    return _priceLabel;
}

- (UIButton *)rememberButton{
    if (!_rememberButton) {
        _rememberButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rememberButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
        _rememberButton.titleLabel.font = kFontSizeMedium12;
        [_rememberButton setTitle:@"记一笔" forState:UIControlStateNormal];
        [_rememberButton setBackgroundColor:HexString(@"#FF4163")];
        [_rememberButton lz_setCornerRadius:3.0];
    }
    return _rememberButton;
}

@end
