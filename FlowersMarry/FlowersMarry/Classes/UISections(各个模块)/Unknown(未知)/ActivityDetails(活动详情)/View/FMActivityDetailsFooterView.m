//
//  FMActivityDetailsFooterView.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/12.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMActivityDetailsFooterView.h"


@interface FMActivityDetailsFooterView()




@end


@implementation FMActivityDetailsFooterView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kWhiteColor;
        [self setupUI];
    }
    return self;
}

- (void) handleControlEvent:(UIButton *)sender{
    MV(weakSelf)
    if (weakSelf.block) {
        weakSelf.block(sender.tag);
    }
}

/// 关注当前商家
- (void) didClickGuanZhu:(NSString *)cp_id{
    [MBProgressHUD showMessage:@""];
    NSString *URLString = @"feed/fllow";
    NSDictionary *parameter = @{@"cp_id":cp_id};
    [SCHttpTools getWithURLString:URLString parameter:parameter success:^(id responseObject) {
        NSDictionary *result = responseObject;
        if ([result isKindOfClass:[NSDictionary class]]) {
            if ([[result lz_objectForKey:@"errcode"] integerValue] == 0) {
                self.guanzhuButton.selected = self.guanzhuButton.selected?NO:YES;
            }
            Toast([result lz_objectForKey:@"message"]);
        }
        [MBProgressHUD hideHUD];
    } failure:^(NSError *error) {
        TTLog(@" -- error -- %@",error);
        [MBProgressHUD hideHUD];
    }];
}

- (void) setupUI{
    [self addSubview:self.kefuButton];
    [self addSubview:self.guanzhuButton];
    [self addSubview:self.shangpuButton];
    [self addSubview:self.yuyueButton];
    
    [self.yuyueButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.mas_equalTo(self);
        make.width.mas_equalTo(165);
        make.height.mas_equalTo(50);
    }];
    CGFloat margin = 15;
    CGFloat width = (kScreenWidth-165-margin)/3;
    [self.kefuButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.height.mas_equalTo(self.yuyueButton);
        make.width.mas_equalTo(width);
        make.left.mas_equalTo(margin);
    }];
    [self.guanzhuButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.width.height.mas_equalTo(self.kefuButton);
        make.left.mas_equalTo(self.kefuButton.mas_right);
    }];
    [self.shangpuButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.width.height.mas_equalTo(self.kefuButton);
        make.left.mas_equalTo(self.guanzhuButton.mas_right);
    }];
}

- (UIButton *)kefuButton{
    if (!_kefuButton) {
        _kefuButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_kefuButton setTitleColor:kTextColor102 forState:UIControlStateNormal];
        _kefuButton.titleLabel.font = kFontSizeMedium13;
        [_kefuButton setTitle:@"客服" forState:UIControlStateNormal];
        [_kefuButton setImage:kGetImage(@"live_btn_kefu") forState:UIControlStateNormal];
        CGFloat spacing = 5;
        //image在左，文字在右，default
        [Utils lz_setButtonTitleWithImageEdgeInsets:_kefuButton postition:kMVImagePositionTop spacing:spacing];
        _kefuButton.tag = 100;
        MV(weakSelf)
        [_kefuButton lz_handleControlEvent:UIControlEventTouchUpInside withBlock:^{
            [weakSelf handleControlEvent:weakSelf.kefuButton];
        }];
    }
    return _kefuButton;
}
- (UIButton *)guanzhuButton{
    if (!_guanzhuButton) {
        _guanzhuButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_guanzhuButton setTitleColor:kTextColor102 forState:UIControlStateNormal];
        _guanzhuButton.titleLabel.font = kFontSizeMedium13;
        [_guanzhuButton setTitle:@"关注" forState:UIControlStateNormal];
        [_guanzhuButton setImage:kGetImage(@"live_btn_follow_nor") forState:UIControlStateNormal];
        [_guanzhuButton setImage:kGetImage(@"live_btn_follow_press") forState:UIControlStateSelected];
        CGFloat spacing = 5;
        //image在左，文字在右，default
        [Utils lz_setButtonTitleWithImageEdgeInsets:_guanzhuButton postition:kMVImagePositionTop spacing:spacing];
        _guanzhuButton.tag = 101;
        MV(weakSelf)
        [_guanzhuButton lz_handleControlEvent:UIControlEventTouchUpInside withBlock:^{
            [weakSelf handleControlEvent:weakSelf.guanzhuButton];
        }];
    }
    return _guanzhuButton;
}
- (UIButton *)shangpuButton{
    if (!_shangpuButton) {
        _shangpuButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shangpuButton setTitleColor:kTextColor102 forState:UIControlStateNormal];
        _shangpuButton.titleLabel.font = kFontSizeMedium13;
        [_shangpuButton setTitle:@"商铺" forState:UIControlStateNormal];
        [_shangpuButton setImage:kGetImage(@"live_btn_business") forState:UIControlStateNormal];
        CGFloat spacing = 5;
        //image在左，文字在右，default
        [Utils lz_setButtonTitleWithImageEdgeInsets:_shangpuButton postition:kMVImagePositionTop spacing:spacing];
        _shangpuButton.tag = 102;
        MV(weakSelf)
        [_shangpuButton lz_handleControlEvent:UIControlEventTouchUpInside withBlock:^{
            [weakSelf handleControlEvent:weakSelf.shangpuButton];
        }];
    }
    return _shangpuButton;
}
- (UIButton *)yuyueButton{
    if (!_yuyueButton) {
        _yuyueButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_yuyueButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
        _yuyueButton.titleLabel.font = kFontSizeMedium15;
        [_yuyueButton setTitle:@"免费预约" forState:UIControlStateNormal];
        [_yuyueButton setBackgroundImage:imageColor(kColorWithRGB(255, 65, 99)) forState:UIControlStateNormal];
        //image在左，文字在右，default
        _yuyueButton.tag = 103;
        MV(weakSelf)
        [_yuyueButton lz_handleControlEvent:UIControlEventTouchUpInside withBlock:^{
            [weakSelf handleControlEvent:weakSelf.yuyueButton];
        }];
    }
    return _yuyueButton;
}

@end
