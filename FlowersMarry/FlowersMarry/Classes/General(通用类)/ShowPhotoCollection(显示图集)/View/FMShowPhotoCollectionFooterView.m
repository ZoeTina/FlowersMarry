//
//  FMShowPhotoCollectionFooterView.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/18.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMShowPhotoCollectionFooterView.h"

@implementation FMShowPhotoCollectionFooterView

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
    if (weakSelf.footerBlock) {
        weakSelf.footerBlock(sender.tag);
    }
}

- (void) setupUI{
    [self addSubview:self.linerView];
    [self addSubview:self.currentIndexLabel];
    [self addSubview:self.subtitleLabel];
    [self addSubview:self.commentsButton];
    [self addSubview:self.likeButton];
    [self addSubview:self.kefuButton];
    [self addSubview:self.subscribeButton];
}

- (void)initConstraints{
    
    [self.linerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self);
        make.height.equalTo(@(kLinerViewHeight));
    }];
    
    [self.subscribeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-(7+kSafeAreaBottomHeight));
        make.right.mas_equalTo(self.mas_right).mas_offset(-30);
        make.width.mas_equalTo(85);
        make.height.mas_equalTo(35);
    }];
    
    CGFloat margin = 15;
    CGFloat width = (kScreenWidth-15-30-85)/3;
    [self.commentsButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(margin);
        make.width.mas_equalTo(width);
        make.centerY.height.mas_equalTo(self.subscribeButton);
    }];
    [self.likeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.commentsButton.mas_right);
        make.centerY.width.height.mas_equalTo(self.subscribeButton);
    }];
    [self.kefuButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.likeButton.mas_right);
        make.centerY.width.height.mas_equalTo(self.subscribeButton);
    }];
    
    [self.currentIndexLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(16);
        make.top.mas_equalTo(5);
    }];
    [self.subtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.currentIndexLabel.mas_right).offset(5);
        make.right.mas_equalTo(self.mas_right).mas_offset(-16);
        make.top.mas_equalTo(8);
    }];
}

- (UILabel *)currentIndexLabel{
    if (!_currentIndexLabel) {
        _currentIndexLabel = [UILabel lz_labelWithTitle:@"" color:[UIColor lz_colorWithHexString:@"#BBBBBB"] font:kFontSizeMedium13];
    }
    return _currentIndexLabel;
}

- (UILabel *)subtitleLabel{
    if (!_subtitleLabel) {
        _subtitleLabel = [UILabel lz_labelWithTitle:@"" color:kWhiteColor font:kFontSizeMedium13];
        _subtitleLabel.numberOfLines = 0;
    }
    return _subtitleLabel;
}

- (UIButton *)commentsButton{
    if (!_commentsButton) {
        _commentsButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_commentsButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
        _commentsButton.titleLabel.font = kFontSizeMedium15;
        [_commentsButton setImage:kGetImage(@"live_btn_comment") forState:UIControlStateNormal];
        CGFloat spacing = 4;
        //image在左，文字在右，default
        [Utils lz_setButtonTitleWithImageEdgeInsets:_commentsButton postition:kMVImagePositionLeft spacing:spacing];
        _commentsButton.tag = 102;
        MV(weakSelf)
        [_commentsButton lz_handleControlEvent:UIControlEventTouchUpInside withBlock:^{
            [weakSelf handleControlEvent:weakSelf.commentsButton];
        }];
    }
    return _commentsButton;
}

- (UIButton *)likeButton{
    if (!_likeButton) {
        _likeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_likeButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
        _likeButton.titleLabel.font = kFontSizeMedium15;
        [_likeButton setImage:kGetImage(@"live_btn_like") forState:UIControlStateNormal];
        [_likeButton setImage:kGetImage(@"live_btn_like_selected") forState:UIControlStateSelected];
        CGFloat spacing = 4;
        //image在左，文字在右，default
        [Utils lz_setButtonTitleWithImageEdgeInsets:_likeButton postition:kMVImagePositionLeft spacing:spacing];
        _likeButton.tag = 103;
        MV(weakSelf)
        [_likeButton lz_handleControlEvent:UIControlEventTouchUpInside withBlock:^{
            [weakSelf handleControlEvent:weakSelf.likeButton];
        }];
    }
    return _likeButton;
}

- (UIButton *)kefuButton{
    if (!_kefuButton) {
        _kefuButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_kefuButton setImage:kGetImage(@"live_btn_service") forState:UIControlStateNormal];
        _kefuButton.tag = 104;
        MV(weakSelf)
        [_kefuButton lz_handleControlEvent:UIControlEventTouchUpInside withBlock:^{
            [weakSelf handleControlEvent:weakSelf.kefuButton];
        }];
    }
    return _kefuButton;
}

- (UIButton *)subscribeButton{
    if (!_subscribeButton) {
        _subscribeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_subscribeButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
        _subscribeButton.titleLabel.font = kFontSizeMedium15;
        [_subscribeButton setTitle:@"预约" forState:UIControlStateNormal];
        [_subscribeButton lz_setCornerRadius:4];
        [_subscribeButton setBackgroundImage:[UIImage lz_imageWithColor:[UIColor lz_colorWithHexString:@"#FF4163"]] forState:UIControlStateNormal];
        _subscribeButton.tag = 105;
        MV(weakSelf)
        [_subscribeButton lz_handleControlEvent:UIControlEventTouchUpInside withBlock:^{
            [weakSelf handleControlEvent:weakSelf.subscribeButton];
        }];
    }
    return _subscribeButton;
}

- (UIView *)linerView{
    if (!_linerView) {
        _linerView = [UIView lz_viewWithColor:kLinerViewColor];
        _linerView.hidden = YES;
    }
    return _linerView;
}

@end
