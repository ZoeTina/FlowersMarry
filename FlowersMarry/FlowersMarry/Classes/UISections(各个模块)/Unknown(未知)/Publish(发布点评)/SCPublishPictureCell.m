//
//  SCPublishPictureCell.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/8/9.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "SCPublishPictureCell.h"

@implementation SCPublishPictureCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        self.contentView.backgroundColor = kClearColor;
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    [self.contentView addSubview:self.imagesView];
    [self.contentView addSubview:self.imagesDelButton];
    [self.imagesView lz_setCornerRadius:3.0];
    [self.imagesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-0.5);
        make.top.equalTo(self.contentView).offset(9.5);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
    }];
    
    [self.imagesDelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.right.equalTo(self.contentView.mas_right).offset(-2);
    }];
}


- (FLAnimatedImageView *)imagesView{
    if (!_imagesView) {
        _imagesView = [[FLAnimatedImageView alloc] init];
        _imagesView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _imagesView;
}

- (UIButton *)imagesDelButton{
    if (!_imagesDelButton) {
        _imagesDelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_imagesDelButton setImage:kGetImage(@"live_btn_del") forState:UIControlStateNormal];
    }
    return _imagesDelButton;
}

@end
