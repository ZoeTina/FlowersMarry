//
//  FMConventionViewController.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/8/28.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMConventionViewController.h"

@interface FMConventionViewController ()
/// 标题
@property (nonatomic, strong) UILabel *titleLabel;
/// 副标题
@property (nonatomic, strong) UILabel *subtitleLabel;
/// 劵图标
@property (nonatomic, strong) UIImageView *imagesCoupons;
/// 劵文字
@property (nonatomic, strong) SCVerticallyAlignedLabel *labelCoupons;
/// 礼物图标
@property (nonatomic, strong) UIImageView *imagesGift;
/// 礼物文字
@property (nonatomic, strong) SCVerticallyAlignedLabel *labelGift;
/// 完成按钮
@property (nonatomic, strong) UIButton *overButton;

/// 背景图1
@property (nonatomic, strong) UIImageView *imagesViewBg;

@property (nonatomic, strong) BusinessYouHuiModel *youhui;
@property (nonatomic, assign) NSInteger type;

@end

@implementation FMConventionViewController
- (id)initYouHuiModelData:(BusinessYouHuiModel *)youhuiModel{
    if ( self = [super init] ){
        self.youhui = youhuiModel;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view lz_setCornerRadius:12.0];
    self.view.backgroundColor = kWhiteColor;
    BusinessYouHuiCouponModel *modelCoupon = self.youhui.coupon;
    BusinessYouHuiGiftModel *modelGift = self.youhui.gift;
    self.titleLabel.text = @"恭喜，预约成功！";
    if (modelGift.title.length==0) self.imagesGift.hidden = YES;
    if (modelCoupon.num==0) self.imagesCoupons.hidden = YES;
    if (modelGift.title.length>0||modelCoupon.num>0) {
        [self initView:0];
        self.imagesViewBg.image = kGetImage(@"live_successful_bg");
        self.subtitleLabel.text = @"店家心意请笑纳";
        self.labelCoupons.text = modelCoupon.title;
        self.labelGift.text = modelGift.title;
        
        self.view.frame = CGRectMake(IPHONE6_W((kScreenWidth - 300)/2), 0, IPHONE6_W(300), 329);
    }else{
        [self initView:1];

        self.imagesViewBg.image = kGetImage(@"live_successful_bg1");
        self.view.frame = CGRectMake(IPHONE6_W((kScreenWidth - 270)/2), 0, IPHONE6_W(270), 289);
    }
}

// 去报名按钮
- (IBAction)dismissedPopupView:(id)sender{
    if (self.delegate && [self.delegate respondsToSelector:@selector(dismissedButtonClicked:)]) {
        [self.delegate dismissedButtonClicked:self];
    }
}

- (void) initView:(NSInteger)type{
    [self.view addSubview:self.imagesViewBg];
    [self.view addSubview:self.titleLabel];
    if (type==0) {
        [self.view addSubview:self.subtitleLabel];
        [self.view addSubview:self.imagesCoupons];
        [self.view addSubview:self.labelCoupons];
        [self.view addSubview:self.imagesGift];
        [self.view addSubview:self.labelGift];
    }
    [self.view addSubview:self.overButton];
    
    [self.imagesViewBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        if (type==0) {
            make.top.equalTo(@46);
            make.left.right.equalTo(self.view);
        }else{
            make.bottom.equalTo(self.overButton.mas_top).offset(-35);
            make.left.right.equalTo(self.view);
        }
    }];
    
    if (type==0) {
        [self.subtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
            make.left.right.equalTo(self.view);
        }];
        
        [self.imagesCoupons mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(@138);
            make.left.equalTo(@53);
        }];
        [self.labelCoupons mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.imagesCoupons.mas_top);
            make.left.equalTo(@79);
            make.right.equalTo(self.view.mas_right).offset(-53);
        }];
        [self.imagesGift mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.labelCoupons.mas_bottom).offset(19);
            make.left.equalTo(self.imagesCoupons);
        }];
        [self.labelGift mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.labelCoupons);
            make.top.equalTo(self.imagesGift);
        }];
    }
    
    [self.overButton mas_makeConstraints:^(MASConstraintMaker *make) {
        if (type==0) {
            make.left.equalTo(@75);
            make.right.equalTo(self.view.mas_right).offset(-75);
            make.bottom.equalTo(self.view.mas_bottom).offset(-48);
        }else{
            make.left.equalTo(@60);
            make.right.equalTo(self.view.mas_right).offset(-60);
            make.bottom.equalTo(self.view.mas_bottom).offset(-62);

        }
        make.height.equalTo(@35);
    }];
}


- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel lz_labelWithTitle:@"" color:kTextColor51 font:kFontSizeMedium17];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UILabel *)subtitleLabel{
    if (!_subtitleLabel) {
        _subtitleLabel = [UILabel lz_labelWithTitle:@"" color:kTextColor102 font:kFontSizeMedium12];
        _subtitleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _subtitleLabel;
}

- (UIImageView *)imagesViewBg{
    if (!_imagesViewBg) {
        _imagesViewBg = [[UIImageView alloc] init];
    }
    return _imagesViewBg;
}

- (UIImageView *)imagesCoupons{
    if (!_imagesCoupons) {
        _imagesCoupons = [[UIImageView alloc] init];
        _imagesCoupons.image = kGetImage(@"base_merchant_coupon");
    }
    return _imagesCoupons;
}

- (SCVerticallyAlignedLabel *)labelCoupons{
    if (!_labelCoupons) {
        _labelCoupons = [[SCVerticallyAlignedLabel alloc] init];
        _labelCoupons.textColor = kTextColor34;
        _labelCoupons.font = kFontSizeMedium12;
        _labelCoupons.numberOfLines = 0;
    }
    return _labelCoupons;
}

- (UIImageView *)imagesGift{
    if (!_imagesGift) {
        _imagesGift = [[UIImageView alloc] init];
        _imagesGift.image = kGetImage(@"base_merchant_gift");
    }
    return _imagesGift;
}

- (SCVerticallyAlignedLabel *)labelGift{
    if (!_labelGift) {
        _labelGift = [[SCVerticallyAlignedLabel alloc] init];
        _labelGift.textColor = kTextColor34;
        _labelGift.font = kFontSizeMedium12;
        _labelGift.numberOfLines = 0;
    }
    return _labelGift;
}

- (UIButton *)overButton{
    if (!_overButton) {
        _overButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_overButton setTitle:@"好哒" forState:UIControlStateNormal];
        [_overButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
        _overButton.titleLabel.font = kFontSizeMedium15;
        _overButton.backgroundColor = kColorWithRGB(255, 65, 99);
        [_overButton lz_setCornerRadius:3.0];
        [_overButton lz_handleControlEvent:UIControlEventTouchUpInside withBlock:^{
            [self dismissedPopupView:self->_overButton];
        }];
    }
    return _overButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
