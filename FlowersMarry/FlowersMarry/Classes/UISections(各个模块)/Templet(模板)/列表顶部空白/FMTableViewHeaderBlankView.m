//
//  FMTableViewHeaderBlankView.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/16.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMTableViewHeaderBlankView.h"

@implementation FMTableViewHeaderBlankView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kWhiteColor;
        [self setupUI];
    }
    return self;
}

- (void) setupUI{
    
    [self addSubview:self.imagesView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.lineLabel];
    [self addSubview:self.guessLabel];
    
    [self.imagesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(IPHONE6_W(29));
        make.centerX.mas_equalTo(self);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imagesView.mas_bottom).mas_offset(IPHONE6_W(11));
        make.centerX.mas_equalTo(self);
    }];
    [self.lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_offset(IPHONE6_W(29));
        make.centerX.mas_equalTo(self);
        make.height.mas_equalTo(@(kLinerViewHeight));
        make.width.mas_equalTo(IPHONE6_W(77));
    }];
    [self.guessLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.mas_equalTo(self.lineLabel);
        make.width.mas_equalTo(60);
    }];
}


- (UIImageView *)imagesView{
    if (!_imagesView) {
        _imagesView = [[UIImageView alloc] init];
    }
    return _imagesView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel lz_labelWithTitle:@"" color:kTextColor153 font:kFontSizeMedium12];
    }
    return _titleLabel;
}

- (UILabel *)guessLabel{
    if (!_guessLabel) {
        _guessLabel = [UILabel lz_labelWithTitle:@"" color:kTextColor153 font:kFontSizeMedium12];
        _guessLabel.backgroundColor = kWhiteColor;
    }
    return _guessLabel;
}

- (UIView *)lineLabel{
    if (!_lineLabel) {
        _lineLabel = [UIView lz_viewWithColor:kColorWithRGB(204, 204, 204)];
    }
    return _lineLabel;
}
@end
