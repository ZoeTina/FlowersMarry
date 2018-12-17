//
//  FMToolsTopCollectionViewCell.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/9/25.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMToolsTopCollectionViewCell.h"

@implementation FMToolsTopCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        self.contentView.backgroundColor = [UIColor clearColor];
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    [self addSubview:self.titleLabel];
    [self addSubview:self.subtitleLabel];
    [self addSubview:self.button];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(@(21));
        make.height.equalTo(@(13));
    }];
    [self.subtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(11);
        make.centerX.equalTo(self);
        make.height.equalTo(@(13));
    }];
    [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.subtitleLabel.mas_bottom).offset(15);
        make.centerX.equalTo(self);
        make.height.equalTo(@(28));
        make.width.equalTo(@(85));
    }];
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel lz_labelWithTitle:@"" color:kTextColor34 font:kFontSizeMedium14];
    }
    return _titleLabel;
}

- (UILabel *)subtitleLabel{
    if (!_subtitleLabel) {
        _subtitleLabel = [UILabel lz_labelWithTitle:@"" color:kTextColor153 font:kFontSizeMedium12];
    }
    return _subtitleLabel;
}

- (UIButton *)button{
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button setTitleColor:kWhiteColor forState:UIControlStateNormal];
        _button.titleLabel.font = kFontSizeMedium10;
        [_button setTitle:@"记任务" forState:UIControlStateNormal];
        [_button setBackgroundImage:kGetImage(@"tools_bg_btn") forState:UIControlStateNormal];
    }
    return _button;
}
@end
