//
//  FMShowPhotoCollectionHeaderView.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/18.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMShowPhotoCollectionHeaderView.h"

@implementation FMShowPhotoCollectionHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kWhiteColor;
        [self setupUI];
        [self initConstraints];
    }
    return self;
}

- (void) handleControlEvent:(UIButton *)sender{
    MV(weakSelf)
    if (weakSelf.headerBlock) {
        weakSelf.headerBlock(sender.tag);
    }
}

- (void) setupUI{
    [self addSubview:self.leftButton];
    [self addSubview:self.avatarImage];
    [self addSubview:self.avatarButton];
    [self addSubview:self.titleLabel];
    [self addSubview:self.focusButton];
}

- (void)initConstraints{
    [self.leftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.width.height.equalTo(@(44));
        make.left.equalTo(self);
    }];
    
    [self.avatarImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.leftButton);
        make.width.height.equalTo(@(34));
        make.left.equalTo(self.leftButton.mas_right);
        
    }];
    
    [self.avatarButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.centerY.centerX.equalTo(self.avatarImage);
    }];
    
    [self.focusButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(55));
        make.height.equalTo(@(26));
        make.centerY.equalTo(self.leftButton);
        make.right.equalTo(self.mas_right).offset(IPHONE6_W(-20));
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.avatarImage);
        make.left.equalTo(self.avatarImage.mas_right).offset(10);
        make.right.equalTo(self.focusButton.mas_left).offset(-10);
    }];
}

- (UIImageView *)avatarImage{
    if (!_avatarImage) {
        _avatarImage = [[UIImageView alloc] init];
        [_avatarImage setCornerRadius:17.0];
    }
    return _avatarImage;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel lz_labelWithTitle:@"" color:kWhiteColor font:kFontSizeMedium14];
    }
    return _titleLabel;
}

- (UIButton *)focusButton{
    if (!_focusButton) {
        _focusButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_focusButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [_focusButton setTitleColor:kTextColor153 forState:UIControlStateSelected];
        _focusButton.titleLabel.font = kFontSizeMedium12;;
        _focusButton.tag = 101;
        _focusButton.hidden = YES;
        [_focusButton setTitle:@"关注" forState:UIControlStateNormal];
        [_focusButton setTitle:@"已关注" forState:UIControlStateSelected];
        [_focusButton lz_setCornerRadius:4];
        [_focusButton setBackgroundImage:[UIImage lz_imageWithColor:[UIColor lz_colorWithHexString:@"#F85A59"]] forState:UIControlStateNormal];
        [_focusButton setBackgroundImage:imageColor(kTextColor238) forState:UIControlStateSelected];
        MV(weakSelf)
        [_focusButton lz_handleControlEvent:UIControlEventTouchUpInside withBlock:^{
            [weakSelf handleControlEvent:weakSelf.focusButton];
        }];
    }
    return _focusButton;
}

- (UIButton *)leftButton{
    if (!_leftButton) {
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftButton.tag = 100;
        [_leftButton setImage:kGetImage(@"nav_back_copy") forState:UIControlStateNormal];
        [_leftButton setImage:kGetImage(@"nav_back_copy") forState:UIControlStateHighlighted];
        MV(weakSelf)
        [_leftButton lz_handleControlEvent:UIControlEventTouchUpInside withBlock:^{
            [weakSelf handleControlEvent:weakSelf.leftButton];
        }];
    }
    return _leftButton;
}

- (UIButton *)avatarButton{
    if (!_avatarButton) {
        _avatarButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _avatarButton.tag = 99;
        _avatarButton.backgroundColor = kClearColor;
        MV(weakSelf)
        [_avatarButton lz_handleControlEvent:UIControlEventTouchUpInside withBlock:^{
            [weakSelf handleControlEvent:weakSelf.avatarButton];
        }];
    }
    return _avatarButton;
}

@end
