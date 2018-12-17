//
//  FMConsumerProtectionCollectionViewCell.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/5.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMConsumerProtectionCollectionViewCell.h"
#pragma mark
@interface FMConsumerProtectionCollectionViewCell ()

@end
@implementation FMConsumerProtectionCollectionViewCell
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
        make.centerY.mas_equalTo(self);
        make.left.mas_equalTo(25);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.imagesView.mas_right).mas_offset(5);
        make.centerY.mas_equalTo(self);
    }];
    
}

#pragma mark -- setter getter
- (UIImageView *)imagesView{
    if (!_imagesView) {
        _imagesView = [[UIImageView alloc] init];
        _imagesView.backgroundColor = [UIColor clearColor];
        _imagesView.image = kGetImage(@"live_btn_selected");
    }
    return _imagesView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel lz_labelWithTitle:@"" color:kTextColor102 font:kFontSizeMedium12];
    }
    return _titleLabel;
}

@end
