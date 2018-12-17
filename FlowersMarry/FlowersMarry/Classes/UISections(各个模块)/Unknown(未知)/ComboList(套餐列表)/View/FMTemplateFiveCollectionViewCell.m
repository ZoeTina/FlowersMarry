//
//  FMTemplateFiveCollectionViewCell.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/13.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMTemplateFiveCollectionViewCell.h"

@implementation FMTemplateFiveCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self setupUI];
    }
    return self;
}

- (void)setFiveModel:(FMFiveCellModel *)fiveModel{
    _fiveModel = fiveModel;
    self.titleLabel.text = fiveModel.title;
    self.subtitleLabel.text = fiveModel.subtitle;
    self.imagesView.image = kGetImage(fiveModel.imageText);
}

- (void)setupUI {
    [self addSubview:self.imagesView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.subtitleLabel];
    [self addSubview:self.linerView];
  
    
    [self.imagesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(IPHONE6_W(21));
        make.centerY.mas_equalTo(self);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(IPHONE6_W(13));
        make.left.mas_equalTo(self.imagesView.mas_right).mas_offset(IPHONE6_W((7)));
    }];
    [self.subtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.titleLabel);
        make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-13);
    }];
    [self.linerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(@(kLinerViewHeight));
        make.top.mas_equalTo(IPHONE6_W(19));
        make.bottom.mas_equalTo(self.mas_bottom).mas_offset(IPHONE6_W(-19));
        make.right.mas_equalTo(self);
    }];
}

#pragma mark -- setter getter

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel lz_labelWithTitle:@"" color:kTextColor51 font:kFontSizeMedium12];
    }
    return _titleLabel;
}

- (UILabel *)subtitleLabel{
    if (!_subtitleLabel) {
        _subtitleLabel = [UILabel lz_labelWithTitle:@"" color:kTextColor136 font:kFontSizeMedium13];
    }
    return _subtitleLabel;
}

- (UIView *)linerView{
    if (!_linerView) {
        _linerView = [UIView lz_viewWithColor:kLinerViewColor];
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
