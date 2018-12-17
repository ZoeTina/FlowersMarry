//
//  FMMineGuestsFooterView.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/10/17.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMMineGuestsFooterView.h"

@implementation FMMineGuestsFooterView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kWhiteColor;
        [self setupUI];
    }
    return self;
}

- (void) handleControlEvent:(UIButton *)sender{
    MV(weakSelf)
    if (weakSelf.block) {
        weakSelf.block(sender.tag);
    }
}

- (void) setupUI{
    [self addSubview:self.searchButton];
    [self addSubview:self.addDesksButton];
    [self addSubview:self.previewButton];
    [self addSubview:self.checkSeatButton];
    [self addSubview:self.sendGuestsButton];
    CGFloat width = (kScreenWidth-140)/4;
    [self.sendGuestsButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(140));
        make.right.top.equalTo(self);
        make.height.equalTo(@(50));
    }];
    [self.searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.width.equalTo(@(width));
        make.top.height.equalTo(self.sendGuestsButton);
    }];
    [self.addDesksButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.searchButton.mas_right);
        make.top.width.height.equalTo(self.searchButton);
    }];
    [self.previewButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.addDesksButton.mas_right);
        make.top.width.height.equalTo(self.searchButton);
    }];
    [self.checkSeatButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.previewButton.mas_right);
        make.top.width.height.equalTo(self.searchButton);
    }];
}

- (UIButton *)searchButton{
    if (!_searchButton) {
        _searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_searchButton setTitleColor:kTextColor34 forState:UIControlStateNormal];
        _searchButton.titleLabel.font = kFontSizeMedium13;
        [_searchButton setTitle:@"搜索" forState:UIControlStateNormal];
        [_searchButton setImage:kGetImage(@"tools_guests_btn_search") forState:UIControlStateNormal];
        //image在左，文字在右，default
        [Utils lz_setButtonTitleWithImageEdgeInsets:_searchButton postition:kMVImagePositionTop spacing:5];
        _searchButton.tag = 100;
        MV(weakSelf)
        [_searchButton lz_handleControlEvent:UIControlEventTouchUpInside withBlock:^{
            [weakSelf handleControlEvent:weakSelf.searchButton];
        }];
    }
    return _searchButton;
}
- (UIButton *)addDesksButton{
    if (!_addDesksButton) {
        _addDesksButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addDesksButton setTitleColor:kTextColor34 forState:UIControlStateNormal];
        _addDesksButton.titleLabel.font = kFontSizeMedium13;
        [_addDesksButton setTitle:@"加桌" forState:UIControlStateNormal];
        [_addDesksButton setImage:kGetImage(@"tools_guests_btn_jiazhuo") forState:UIControlStateNormal];
        //image在左，文字在右，default
        [Utils lz_setButtonTitleWithImageEdgeInsets:_addDesksButton postition:kMVImagePositionTop spacing:5];
        _addDesksButton.tag = 101;
        MV(weakSelf)
        [_addDesksButton lz_handleControlEvent:UIControlEventTouchUpInside withBlock:^{
            [weakSelf handleControlEvent:weakSelf.addDesksButton];
        }];
    }
    return _addDesksButton;
}
- (UIButton *)previewButton{
    if (!_previewButton) {
        _previewButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_previewButton setTitleColor:kTextColor34 forState:UIControlStateNormal];
        _previewButton.titleLabel.font = kFontSizeMedium13;
        [_previewButton setTitle:@"预览" forState:UIControlStateNormal];
        [_previewButton setImage:kGetImage(@"tools_guests_btn_yulan") forState:UIControlStateNormal];
        //image在左，文字在右，default
        [Utils lz_setButtonTitleWithImageEdgeInsets:_previewButton postition:kMVImagePositionTop spacing:5];
        _previewButton.tag = 102;
        MV(weakSelf)
        [_previewButton lz_handleControlEvent:UIControlEventTouchUpInside withBlock:^{
            [weakSelf handleControlEvent:weakSelf.previewButton];
        }];
    }
    return _previewButton;
}
- (UIButton *)checkSeatButton{
    if (!_checkSeatButton) {
        _checkSeatButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_checkSeatButton setTitleColor:kTextColor34 forState:UIControlStateNormal];
        _checkSeatButton.titleLabel.font = kFontSizeMedium13;
        [_checkSeatButton setTitle:@"查座" forState:UIControlStateNormal];
        [_checkSeatButton setImage:kGetImage(@"tools_guests_btn_chazuo") forState:UIControlStateNormal];
        //image在左，文字在右，default
        [Utils lz_setButtonTitleWithImageEdgeInsets:_checkSeatButton postition:kMVImagePositionTop spacing:5];
        _checkSeatButton.tag = 103;
        MV(weakSelf)
        [_checkSeatButton lz_handleControlEvent:UIControlEventTouchUpInside withBlock:^{
            [weakSelf handleControlEvent:weakSelf.checkSeatButton];
        }];
    }
    return _checkSeatButton;
}

- (UIButton *)sendGuestsButton{
    if (!_sendGuestsButton) {
        _sendGuestsButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sendGuestsButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
        _sendGuestsButton.titleLabel.font = kFontSizeMedium15;
        [_sendGuestsButton setTitle:@"发送至宾客" forState:UIControlStateNormal];
        [_sendGuestsButton setBackgroundImage:imageHexString(@"#FF4163") forState:UIControlStateNormal];
        //image在左，文字在右，default
        _sendGuestsButton.tag = 104;
        MV(weakSelf)
        [_sendGuestsButton lz_handleControlEvent:UIControlEventTouchUpInside withBlock:^{
            [weakSelf handleControlEvent:weakSelf.sendGuestsButton];
        }];
    }
    return _sendGuestsButton;
}


@end
