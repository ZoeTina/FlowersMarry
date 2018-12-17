//
//  FMHeaderNavigationTranspView.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/20.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMHeaderNavigationTranspView.h"

@implementation FMHeaderNavigationTranspView


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kClearColor;
        [self setupUI];
    }
    return self;
}

- (void) handleButtonEvents:(UIButton *)sender{
    MV(weakSelf)
    if (weakSelf.block) {
        weakSelf.block(sender.tag);
    }
}

- (void) setupUI{
    
    [self addSubview:self.backButton];
    [self addSubview:self.shareButton];
    [self addSubview:self.titleLabel];
    
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-6);
    }];
    
    [self.shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).mas_offset(IPHONE6_W(-15));
        make.centerY.mas_equalTo(self.backButton);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self.shareButton);
    }];
}

- (UIButton *)backButton{
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_backButton setImage:kGetImage(@"live_btn_back") forState:UIControlStateNormal];
        _backButton.tag = 104;
        MV(weakSelf)
        [_backButton lz_handleControlEvent:UIControlEventTouchUpInside withBlock:^{
            [weakSelf handleButtonEvents:weakSelf.backButton];
        }];
    }
    return _backButton;
}

- (UIButton *)shareButton{
    if (!_shareButton) {
        _shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareButton setImage:kGetImage(@"live_btn_share_s") forState:UIControlStateNormal];
        _shareButton.tag = 105;
        MV(weakSelf)
        [_shareButton lz_handleControlEvent:UIControlEventTouchUpInside withBlock:^{
            [weakSelf handleButtonEvents:weakSelf.shareButton];
        }];
    }
    return _shareButton;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel lz_labelWithTitle:@"" color:kClearColor font:kFontSizeMedium16];
    }
    return _titleLabel;
}

@end
