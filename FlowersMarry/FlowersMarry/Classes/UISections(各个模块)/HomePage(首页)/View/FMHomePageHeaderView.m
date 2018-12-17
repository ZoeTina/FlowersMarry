//
//  FMHomePageHeaderView.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/21.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMHomePageHeaderView.h"

@implementation FMHomePageHeaderView

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

    self.cityLabel.text = @"成都市";
    [self addSubview:self.containerView];
    [self.containerView addSubview:self.searchView];
    [self.containerView addSubview:self.cityLabel];
    [self.containerView addSubview:self.imagesCity];
    [self.searchView addSubview:self.searchLabel];
    [self.searchView addSubview:self.searchImages];
    
}

- (void) initConstraints{
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(IPHONE6_W(44)));
        make.bottom.left.right.equalTo(self);
    }];
    [self.cityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(15));
        make.top.bottom.equalTo(self.containerView);
    }];
    [self.imagesCity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.cityLabel.mas_right).offset(5);
        make.centerY.equalTo(self.containerView);
    }];
    
    [self.searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.containerView);
        make.height.equalTo(@(IPHONE6_W(28)));
        make.left.equalTo(self.imagesCity.mas_right).offset(5);
        make.right.equalTo(self.containerView.mas_right).offset(IPHONE6_W(-15));
    }];
    [self.searchImages mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.searchView);
        make.left.equalTo(self.searchView.mas_left).offset(IPHONE6_W(11));
    }];
    [self.searchLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.searchView);
        make.left.equalTo(self.searchImages.mas_right).offset(IPHONE6_W(5));
    }];
}

- (UIView *)containerView{
    if (!_containerView) {
        _containerView = [UIView lz_viewWithColor:kWhiteColor];
    }
    return _containerView;
}

- (UIView *)searchView{
    if (!_searchView) {
        _searchView = [UIView lz_viewWithColor:kColorWithRGB(244, 244, 244)];
        [_searchView lz_setCornerRadius:3.0];
    }
    return _searchView;
}

- (UIImageView *)searchImages{
    if (!_searchImages) {
        _searchImages = [[UIImageView alloc] init];
        _searchImages.image = kGetImage(@"mine_btn_search");
    }
    return _searchImages;
}

- (UILabel *)searchLabel{
    if (!_searchLabel) {
        _searchLabel = [UILabel lz_labelWithTitle:@"搜索你感兴趣的商家" color:kTextColor153 font:kFontSizeMedium12];
    }
    return _searchLabel;
}

- (UILabel *)cityLabel{
    if (!_cityLabel) {
        _cityLabel = [UILabel lz_labelWithTitle:@"" color:kTextColor34 font:kFontSizeMedium14];
        _cityLabel.highlighted = YES;
    }
    return _cityLabel;
}

- (UIImageView *)imagesCity{
    if (!_imagesCity) {
        _imagesCity = [[UIImageView alloc] init];
        _imagesCity.image = kGetImage(@"business_xia");
    }
    return _imagesCity;
}

@end
