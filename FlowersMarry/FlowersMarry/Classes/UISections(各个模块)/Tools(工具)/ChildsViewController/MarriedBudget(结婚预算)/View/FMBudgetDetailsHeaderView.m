//
//  FMBudgetDetailsHeaderView.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/10/10.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMBudgetDetailsHeaderView.h"

@implementation FMBudgetDetailsHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = HexString(@"#FF4163");
        [self initView];
    }
    return self;
}

- (void) initView{
    [self addSubview:self.totalAmountTitleLable];
    [self addSubview:self.totalAmountLable];
    [self addSubview:self.totalAmountTipsLable];
    [self addSubview:self.againButton];
    [self addSubview:self.imagesArrow];
    
    [self.totalAmountTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(IPHONE6_W(15));
        make.height.mas_equalTo(IPHONE6_W(12));
    }];
    [self.totalAmountLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.totalAmountTitleLable);
        make.height.mas_equalTo(IPHONE6_W(28));
        make.top.equalTo(self.totalAmountTitleLable.mas_bottom).offset(10);
    }];
    [self.totalAmountTipsLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.totalAmountLable);
        make.height.mas_equalTo(IPHONE6_W(12));
        make.top.equalTo(self.totalAmountLable.mas_bottom).offset(18);
    }];
    
    [self.imagesArrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-IPHONE6_W(15));
        make.top.mas_equalTo(IPHONE6_W(46));
    }];
    
    [self.againButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.imagesArrow);
        make.right.equalTo(self.imagesArrow.mas_left).offset(-8);
    }];
}

- (UILabel *)totalAmountTitleLable{
    if (!_totalAmountTitleLable) {
        _totalAmountTitleLable = [UILabel lz_labelWithTitle:@"预算总额（元）" color:kWhiteColor font:kFontSizeMedium12];
        _totalAmountTitleLable.alpha = 0.6;
    }
    return _totalAmountTitleLable;
}

- (UILabel *)totalAmountLable{
    if (!_totalAmountLable) {
        _totalAmountLable = [UILabel lz_labelWithTitle:@"" color:kWhiteColor font:kFontSizeMedium36];
    }
    return _totalAmountLable;
}

- (UILabel *)totalAmountTipsLable{
    if (!_totalAmountTipsLable) {
        _totalAmountTipsLable = [UILabel lz_labelWithTitle:@"" color:kWhiteColor font:kFontSizeMedium12];
        _totalAmountTipsLable.alpha = 0.6;
    }
    return _totalAmountTipsLable;
}

- (UIButton *)againButton{
    if (!_againButton) {
        _againButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_againButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
        _againButton.titleLabel.font = kFontSizeMedium15;
        [_againButton setTitle:@"重新计算" forState:UIControlStateNormal];
    }
    return _againButton;
}

- (UIImageView *)imagesArrow{
    if (!_imagesArrow) {
        _imagesArrow = [[UIImageView alloc] init];
        _imagesArrow.image = kGetImage(@"tools_yusuan_white_arrow");
    }
    return _imagesArrow;
}

@end
