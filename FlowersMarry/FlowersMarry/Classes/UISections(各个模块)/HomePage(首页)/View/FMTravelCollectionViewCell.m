//
//  FMTravelCollectionViewCell.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/5.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMTravelCollectionViewCell.h"

////////// 全球旅拍Cell
@implementation FMTravelCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        self.contentView.backgroundColor = [UIColor clearColor];
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    [self lz_setCornerRadius:3.0];
    [self addSubview:self.containerView];
    [self addSubview:self.cityLabel];
    [self.containerView addSubview:self.imagesView];
    [self.containerView addSubview:self.titleLabel];
    [self.containerView addSubview:self.linerView];
    [self.cityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.centerX.mas_equalTo(self);
    }];
    
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.right.mas_equalTo(self);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.centerY.mas_equalTo(self).mas_offset(IPHONE6_W((-5)));
    }];
    [self.imagesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.mas_equalTo(self);
    }];
    [self.linerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.width.mas_equalTo(IPHONE6_W(17));
        make.height.mas_equalTo(IPHONE6_W(2));
        make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_offset(IPHONE6_W(7));
    }];
}

#pragma mark -- setter getter

- (UILabel *)cityLabel{
    if (!_cityLabel) {
        _cityLabel = [UILabel lz_labelWithTitle:@"" color:kTextColor51 font:kFontSizeMedium13];
        _cityLabel.hidden = YES;
    }
    return _cityLabel;
}
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel lz_labelWithTitle:@"" color:kWhiteColor font:kFontSizeScBold15];
    }
    return _titleLabel;
}


- (UIView *)containerView{
    if (!_containerView) {
        _containerView = [UIView lz_viewWithColor:kClearColor];
        _containerView.hidden = YES;
    }
    return _containerView;
}

- (UIView *)linerView{
    if (!_linerView) {
        _linerView = [UIView lz_viewWithColor:kWhiteColor];
    }
    return _linerView;
}

- (UIImageView *)imagesView{
    if (!_imagesView) {
        _imagesView = [[UIImageView alloc] init];
    }
    return _imagesView;
}
@end
