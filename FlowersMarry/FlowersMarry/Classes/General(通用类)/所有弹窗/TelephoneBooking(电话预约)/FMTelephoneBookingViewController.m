//
//  FMTelephoneBookingViewController.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/5.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMTelephoneBookingViewController.h"

@interface FMTelephoneBookingViewController ()<UITextFieldDelegate>

/// 标题
@property (nonatomic, strong) UILabel *titleLabel;
/// 劵图标
@property (nonatomic, strong) UIImageView *imagesCoupons;
/// 劵文字
@property (nonatomic, strong) UILabel *labelCoupons;
/// 礼物图标
@property (nonatomic, strong) UIImageView *imagesGift;
/// 礼物文字
@property (nonatomic, strong) UILabel *labelGift;
/// 电话号码输入框
@property (nonatomic, strong) UITextField *telTextField;
/// 立即预约按钮
@property (nonatomic, strong) UIButton *immediatelyButton;
@property (nonatomic, strong) UIView *telContainerView;

@property (nonatomic, strong) BusinessModel *businessModel;
@property (nonatomic, assign) BOOL isPreferential;

@end

@implementation FMTelephoneBookingViewController

- (id)initBusinessData:(BusinessModel *)businessModel isPreferential:(BOOL)isPreferential{
    if ( self = [super init] ){
        self.businessModel = businessModel;
        self.isPreferential = isPreferential;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initView];
    
    if (self.isPreferential) {
        self.labelCoupons.text = self.businessModel.youhui.coupon.title;
        self.labelGift.text = self.businessModel.youhui.gift.title;
    }else{
        self.imagesCoupons.hidden = YES;
        self.labelCoupons.hidden = YES;
        self.imagesGift.hidden = YES;
        self.labelGift.hidden = YES;
    }
    
    // 这里设置需要绘制的圆角
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.view.bounds
                                                   byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight
                                                         cornerRadii:CGSizeMake(4,4)];

    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.view.bounds;
    maskLayer.path = maskPath.CGPath;
    self.view.layer.mask = maskLayer;
}

- (void) initView{
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.imagesCoupons];
    [self.view addSubview:self.labelCoupons];
    [self.view addSubview:self.imagesGift];
    [self.view addSubview:self.labelGift];
    [self.view addSubview:self.telContainerView];
    [self.telContainerView addSubview:self.telTextField];
    [self.view addSubview:self.immediatelyButton];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(21);
        make.left.right.mas_equalTo(self.view);
    }];
    [self.imagesCoupons mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(70);
        make.left.mas_equalTo(15);
    }];
    [self.labelCoupons mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(70);
        make.left.mas_equalTo(self.imagesCoupons.mas_right).mas_offset(11);
        make.centerY.mas_equalTo(self.imagesCoupons);
    }];
    [self.imagesGift mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imagesCoupons.mas_bottom).mas_offset(25);
        make.left.mas_equalTo(15);
    }];
    [self.labelGift mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.labelCoupons);
        make.centerY.mas_equalTo(self.imagesGift);
    }];
    [self.telContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(42);
        make.right.mas_equalTo(self.view.mas_right).mas_offset(-42);
        make.height.mas_equalTo(44);
        make.top.mas_equalTo(self.imagesGift.mas_bottom).mas_offset(21);
    }];

    [self.telTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.telContainerView.mas_left).mas_offset(10);
        make.right.mas_equalTo(self.telContainerView.mas_right).mas_offset(-10);
        make.top.bottom.mas_equalTo(self.telContainerView);
    }];
    [self.immediatelyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.mas_equalTo(self.view);
        make.height.mas_equalTo(45);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel lz_labelWithTitle:@"预约即享" color:kTextColor51 font:kFontSizeMedium15];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (UIImageView *)imagesCoupons{
    if (!_imagesCoupons) {
        _imagesCoupons = [[UIImageView alloc] init];
        _imagesCoupons.image = kGetImage(@"base_merchant_coupon");
    }
    return _imagesCoupons;
}

- (UILabel *)labelCoupons{
    if (!_labelCoupons) {
        _labelCoupons = [UILabel lz_labelWithTitle:@"" color:kTextColor34 font:kFontSizeMedium13];
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

- (UILabel *)labelGift{
    if (!_labelGift) {
        _labelGift = [UILabel lz_labelWithTitle:@"" color:kTextColor34 font:kFontSizeMedium13];
    }
    return _labelGift;
}

- (UIView *)telContainerView{
    if (!_telContainerView) {
        _telContainerView = [UIView lz_viewWithColor:kWhiteColor];
        _telContainerView.borderWidth = kLinerViewHeight;
        _telContainerView.borderColor = kColorWithRGB(221, 221, 221);
        [_telContainerView lz_setCornerRadius:3.0];
    }
    return _telContainerView;
}

- (UITextField *)telTextField{
    if (!_telTextField) {
        _telTextField = [[UITextField alloc] init];
        _telTextField.textAlignment = NSTextAlignmentLeft;
        _telTextField.textColor = [UIColor blackColor];
        _telTextField.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        _telTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        _telTextField.borderStyle = UITextBorderStyleNone;
        _telTextField.clearButtonMode = UITextFieldViewModeAlways;
        _telTextField.placeholder = @"请输入您的手机号码";
        _telTextField.delegate = self;
    }
    return _telTextField;
}

- (UIButton *)immediatelyButton{
    if (!_immediatelyButton) {
        _immediatelyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_immediatelyButton setTitle:@"立即预约" forState:UIControlStateNormal];
        [_immediatelyButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
        _immediatelyButton.titleLabel.font = kFontSizeMedium15;
        _immediatelyButton.backgroundColor = kColorWithRGB(255, 65, 99);
        [_immediatelyButton lz_handleControlEvent:UIControlEventTouchUpInside withBlock:^{
            TTLog(@"立即预约");
        }];
    }
    return _immediatelyButton;
}
@end
