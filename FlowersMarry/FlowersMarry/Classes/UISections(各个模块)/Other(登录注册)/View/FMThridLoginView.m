//
//  FMThridLoginView.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/10.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMThridLoginView.h"
@interface FMThridLoginView ()
{
//    CGFloat buttonWidth;
}
@property (nonatomic, strong) NSMutableArray *subViewsArrays;
@end
@implementation FMThridLoginView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
//        buttonWidth = IPHONE6_W(53);
        [self getButtonSubviews];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
- (void)getButtonSubviews {
    MV(weakSelf)

    //判断微信是否安装
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]){
        UIButton *weixinButton = [self createButtonWithTitle:@"" imageName:@"mine_btn_wechat"];
        [self addSubview:weixinButton];
        [weixinButton lz_handleControlEvent:UIControlEventTouchUpInside withBlock:^{
            [weakSelf weixinLogin];
        }];
        [self.subViewsArrays addObject:weixinButton];
    }
    
    //判断QQ是否安装
    if ([ShareSDK isClientInstalled:SSDKPlatformTypeQQ]) {
        UIButton *QQButton = [self createButtonWithTitle:@"" imageName:@"mine_btn_qq"];
        [self addSubview:QQButton];
        [QQButton lz_handleControlEvent:UIControlEventTouchUpInside withBlock:^{
            [weakSelf QQLogin];
        }];
        [self.subViewsArrays addObject:QQButton];
    }
    
    BOOL isWeb = NO;
    if (isWeb) {
        UIButton *weiboButton = [self createButtonWithTitle:@"微博" imageName:@"mine_btn_weibo"];
        [self addSubview:weiboButton];
        [self.subViewsArrays addObject:weiboButton];
        [weiboButton lz_handleControlEvent:UIControlEventTouchUpInside withBlock:^{
            [weakSelf weiboLogin];
        }];
    }

    [self layoutButtons];
    
}

- (void)weixinLogin {
    if (self.thridLoginViewDelegate && [self.thridLoginViewDelegate respondsToSelector:@selector(weixinClick)]) {
        [self.thridLoginViewDelegate weixinClick];
    }
}
- (void)QQLogin {
    if (self.thridLoginViewDelegate && [self.thridLoginViewDelegate respondsToSelector:@selector(QQClick)]) {
        [self.thridLoginViewDelegate QQClick];
    }
}

- (void)weiboLogin {
    if (self.thridLoginViewDelegate && [self.thridLoginViewDelegate respondsToSelector:@selector(weiboClick)]) {
        [self.thridLoginViewDelegate weiboClick];
    }
}

- (void)layoutButtons {
    if (self.subViewsArrays.count == 3) {
        [self layoutThreeButton];
    }
    if (self.subViewsArrays.count == 2) {
        [self layoutTwoButton];
    }
    if (self.subViewsArrays.count == 1) {
        [self layoutOneButton];
    }
}

- (void)layoutThreeButton {
    
    CGFloat letMargin = IPHONE6_W(58);
    CGFloat buttonWidth = IPHONE6_W(63);
    CGFloat margin = (kScreenWidth - letMargin * 2 - 3 * buttonWidth ) / 2.0;
    for (int i = 0; i < self.subViewsArrays.count; i ++) {
        
        UIButton *button = [self.subViewsArrays lz_safeObjectAtIndex:i];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(letMargin + buttonWidth * i + margin * i);
            make.top.mas_offset(0);
            make.height.mas_equalTo(self.mas_height);
            make.width.mas_equalTo(buttonWidth);
        }];
    }
    
}

- (void)layoutTwoButton {
    CGFloat buttonWidth = IPHONE6_W(63);
    CGFloat margin = (kScreenWidth - buttonWidth * 2) / 3.0;
    for (int i = 0; i < self.subViewsArrays.count; i ++) {
        UIView *button = [self.subViewsArrays lz_safeObjectAtIndex:i];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(buttonWidth * i + margin * (i + 1));
            make.width.mas_equalTo(buttonWidth);
            make.top.mas_offset(0);
            make.height.mas_equalTo(self.mas_height);
        }];
    }
}

- (void)layoutOneButton {
    CGFloat buttonWidth = IPHONE6_W(63);
    UIView *button = [self.subViewsArrays lz_safeObjectAtIndex:0];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX);
        make.top.mas_offset(0);
        make.width.mas_equalTo(buttonWidth);
        make.height.mas_equalTo(self.mas_height);
    }];
}

- (NSMutableArray *)subViewsArrays {
    if(!_subViewsArrays) {
        _subViewsArrays = [[NSMutableArray alloc] init];
    }
    return _subViewsArrays;
}

- (UIButton *)createButtonWithTitle:(NSString *)title imageName:(NSString *)imageName {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitleColor:kBlackColor forState:UIControlStateNormal];
    button.titleLabel.font = kFontSizeMedium12;
    [button setTitle:title forState:UIControlStateNormal];
    [button setImage:kGetImage(imageName) forState:UIControlStateNormal];
    return button;
}
@end
