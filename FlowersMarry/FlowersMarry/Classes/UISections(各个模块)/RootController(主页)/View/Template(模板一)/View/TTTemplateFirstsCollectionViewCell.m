//
//  TTTemplateFirstsCollectionViewCell.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/12/12.
//  Copyright © 2018 宁小陌. All rights reserved.
//

#import "TTTemplateFirstsCollectionViewCell.h"

@implementation TTTemplateFirstsCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        self.contentView.backgroundColor = [UIColor clearColor];
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    [self addSubview:self.imagesView];
    [self addSubview:self.titleLabel];
    [self.imagesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(@(IPHONE6_W(7)));
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.imagesView.mas_bottom).offset(IPHONE6_W(9));
    }];
}

#pragma mark -- setter getter
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel lz_labelWithTitle:@"" color:kTextColor12 font:kFontSizeMedium12];
    }
    return _titleLabel;
}

- (UIImageView *)imagesView{
    if (!_imagesView) {
        _imagesView = [[UIImageView alloc] init];
    }
    return _imagesView;
}
@end
