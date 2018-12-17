//
//  FMHomePageSectionHeaderView.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/20.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMHomePageSectionHeaderView.h"

@implementation FMHomePageSectionHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kWhiteColor;
        [self setupUI];
        [self initConstraints];
    }
    return self;
}

- (void) setupUI{
    self.titleLabel.text = @"精选动态";
    [self addSubview:self.imagesView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.recommendButton];
    [self addSubview:self.linerView];
    [self addSubview:self.guanzhuButton];
}

- (void) initConstraints{
    [self.imagesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.left.mas_equalTo(IPHONE6_W(15));
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.left.mas_equalTo(self.imagesView.mas_right).mas_offset(IPHONE6_W(7));
    }];
    [self.guanzhuButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.height.mas_equalTo(self);
        make.right.mas_equalTo(self.mas_right).mas_offset(-15);
    }];
    [self.linerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.height.mas_equalTo(IPHONE6_W(12));
        make.width.mas_equalTo(@(kLinerViewHeight));
        make.right.mas_equalTo(self.guanzhuButton.mas_left).mas_offset(-8);
    }];
    [self.recommendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.right.mas_equalTo(self.linerView.mas_left).mas_offset(-8);
    }];
    
}

- (UIImageView *)imagesView{
    if (!_imagesView) {
        _imagesView = [[UIImageView alloc] init];
        _imagesView.image = kGetImage(@"live_btn_dongtai");
    }
    return _imagesView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel lz_labelWithTitle:@"" color:kTextColor102 font:kFontSizeMedium14];
    }
    return _titleLabel;
}

- (UIButton *)recommendButton{
    if (!_recommendButton) {
        _recommendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_recommendButton setTitleColor:kTextColor102 forState:UIControlStateNormal];
        [_recommendButton setTitleColor:kColorWithRGB(250, 77, 97) forState:UIControlStateSelected];
        _recommendButton.titleLabel.font = kFontSizeMedium12;
        [_recommendButton setTitle:@"推荐" forState:UIControlStateNormal];
        MV(weakSelf)
        [_recommendButton lz_handleControlEvent:UIControlEventTouchUpInside withBlock:^{
            weakSelf.recommendButton.selected = YES;
            weakSelf.guanzhuButton.selected = NO;
        }];
    }
    return _recommendButton;
}

- (UIButton *)guanzhuButton{
    if (!_guanzhuButton) {
        _guanzhuButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_guanzhuButton setTitleColor:kTextColor102 forState:UIControlStateNormal];
        [_guanzhuButton setTitleColor:kColorWithRGB(250, 77, 97) forState:UIControlStateSelected];
        _guanzhuButton.titleLabel.font = kFontSizeMedium12;
        [_guanzhuButton setTitle:@"关注" forState:UIControlStateNormal];
        MV(weakSelf)
        [_guanzhuButton lz_handleControlEvent:UIControlEventTouchUpInside withBlock:^{
            weakSelf.recommendButton.selected = NO;
            weakSelf.guanzhuButton.selected = YES;
        }];
    }
    return _guanzhuButton;
}

- (UIView *)linerView{
    if (!_linerView) {
        _linerView = [UIView lz_viewWithColor:kColorWithRGB(221, 221, 221)];
    }
    return _linerView;
}

@end
