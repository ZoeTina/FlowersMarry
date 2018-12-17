//
//  FMRecommendBusinessCollectionViewCell.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/17.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMRecommendBusinessCollectionViewCell.h"

@implementation FMRecommendBusinessCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        self.contentView.backgroundColor = [UIColor clearColor];
        [self setupUI];
        [self initConstraints];
    }
    return self;
}

- (void)setupUI {
    [self.imagesCountButton setTitle:[NSString stringWithFormat:@"6图"] forState:UIControlStateNormal];

    [self.imagesView lz_setCornerRadius:3.0];
    [self addSubview:self.titleLabel];
    [self addSubview:self.imagesView];
    [self addSubview:self.imagesPlay];
    [self addSubview:self.imagesCountButton];
}

- (void) initConstraints{
    [self.imagesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(self);
        make.height.mas_equalTo(IPHONE6_W(105));
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.imagesView);
        make.top.mas_equalTo(self.imagesView.mas_bottom).mas_offset(9);
    }];
    [self.imagesPlay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.mas_equalTo(self.imagesView);
    }];
    [self.imagesCountButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.imagesView.mas_right).mas_offset(-10);
        make.bottom.mas_equalTo(self.imagesView.mas_bottom).mas_offset(-10);
        make.height.mas_equalTo(IPHONE6_W(20));
        make.width.mas_equalTo(IPHONE6_W(46));
    }];
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel lz_labelWithTitle:@"" color:kWhiteColor font:kFontSizeMedium12];
        _titleLabel.numberOfLines = 2;
    }
    return _titleLabel;
}

- (UIImageView *)imagesView{
    if (!_imagesView) {
        _imagesView = [[UIImageView alloc] init];
    }
    return _imagesView;
}

- (UIImageView *)imagesPlay{
    if (!_imagesPlay) {
        _imagesPlay = [[UIImageView alloc] init];
        _imagesPlay.image = kGetImage(@"live_btn_play");
        _imagesPlay.hidden = YES;
    }
    return _imagesPlay;
}

- (UIButton *)imagesCountButton{
    if (!_imagesCountButton) {
        if (!_imagesCountButton) {
            _imagesCountButton = [UIButton buttonWithType:UIButtonTypeCustom];
            [_imagesCountButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
            _imagesCountButton.titleLabel.font = kFontSizeMedium12;
            [_imagesCountButton setImage:kGetImage(@"base_tujitubiao") forState:UIControlStateNormal];
            _imagesCountButton.hidden = YES;
            CGFloat spacing = 5;
            //image在左，文字在右，default
            [Utils lz_setButtonTitleWithImageEdgeInsets:_imagesCountButton postition:kMVImagePositionLeft spacing:spacing];
            [_imagesCountButton setBackgroundColor:kColorWithRGBA(0, 0, 0, 0.6)];
            [_imagesCountButton lz_setCornerRadius:IPHONE6_W(19/2)];
        }
    }
    return _imagesCountButton;
}
@end
