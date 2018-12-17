//
//  FMBindPartnerViewController.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/10/16.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMBindPartnerViewController.h"

@interface FMBindPartnerViewController ()<UIScrollViewDelegate,UITextFieldDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UITextField *telTextField;
/// 自己的头像
@property (nonatomic, strong) UIImageView *imagesViewSelf;
/// 伴侣头像
@property (nonatomic, strong) UIImageView *imagesViewPartner;
/// 加号按钮
@property (nonatomic, strong) UIButton *buttonPartner;
/// 链接图片
@property (nonatomic, strong) UIImageView *imagesViewLink;
/// 手机图标
@property (nonatomic, strong) UIImageView *imagesViewTel;
/// 通讯录按钮
@property (nonatomic, strong) UIButton *tongxunluButton;
/// 分割线
@property (nonatomic, strong) UIView *linerView;
/// 绑定按钮
@property (nonatomic, strong) UIButton *buttonBind;

@end

@implementation FMBindPartnerViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"绑定伴侣";
    [self initView];
    self.imagesViewSelf.image = kGetImage(@"user1");
}

- (void) handleButtonTapped:(UIButton *)sender{
    
}

- (void) initView{
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.telTextField];
    [self.scrollView addSubview:self.imagesViewSelf];
    [self.scrollView addSubview:self.imagesViewPartner];
    [self.scrollView addSubview:self.buttonPartner];
    [self.scrollView addSubview:self.imagesViewLink];
    [self.scrollView addSubview:self.imagesViewTel];
    [self.scrollView addSubview:self.tongxunluButton];
    [self.scrollView addSubview:self.linerView];
    [self.scrollView addSubview:self.buttonBind];
    
    [self.imagesViewLink mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(@(85));
    }];
    
    [self.imagesViewSelf mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.imagesViewLink);
        make.right.equalTo(self.imagesViewLink.mas_left).offset(-14);
        make.height.width.equalTo(@(83));
    }];
    
    [self.imagesViewPartner mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.imagesViewLink);
        make.left.equalTo(self.imagesViewLink.mas_right).offset(14);
        make.height.width.equalTo(self.imagesViewSelf);
    }];
    [self.buttonPartner mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.left.equalTo(self.imagesViewPartner);
    }];
    [self.linerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(15));
        make.right.equalTo(self.view.mas_right).offset(-15);
        make.height.equalTo(@(0.7));
        make.centerX.equalTo(self.view);
        make.top.equalTo(@(222));
    }];
    [self.imagesViewTel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(25));
        make.bottom.equalTo(self.linerView.mas_top).offset(-15);
    }];
    [self.telTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(41));
        make.centerY.equalTo(self.imagesViewTel);
        make.height.equalTo(@(40));
        make.right.equalTo(self.view.mas_right).offset(-90);
    }];
    [self.tongxunluButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).offset(-25);
        make.centerY.equalTo(self.imagesViewTel);
    }];

    [self.buttonBind mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(15));
        make.height.equalTo(@(44));
        make.right.equalTo(self.tongxunluButton);
        make.top.equalTo(self.linerView.mas_bottom).offset(26);
    }];
}

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.frame = self.view.bounds;
        _scrollView.delegate = self;
        _scrollView.backgroundColor = kWhiteColor;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.contentSize = CGSizeMake(kScreenWidth, kScreenHeight+1);
        _scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return _scrollView;
}

- (UITextField *)telTextField{
    if (!_telTextField) {
        _telTextField = [UITextField lz_textFieldWithPlaceHolder:@"请输入手机号"];
        _telTextField.returnKeyType = UIReturnKeyDone;
        _telTextField.borderStyle = UITextBorderStyleNone;
        _telTextField.delegate = self;
        _telTextField.font = kFontSizeMedium13;
    }
    return _telTextField;
}

- (UIImageView *)imagesViewSelf{
    if (!_imagesViewSelf) {
        _imagesViewSelf = [[UIImageView alloc] init];
        [_imagesViewSelf lz_setCornerRadius:83.0/2];
    }
    return _imagesViewSelf;
}

- (UIImageView *)imagesViewPartner{
    if(!_imagesViewPartner){
        _imagesViewPartner = [[UIImageView alloc] init];
        [_imagesViewPartner lz_setCornerRadius:83.0/2];
    }
    return _imagesViewPartner;
}

- (UIButton *)buttonPartner{
    if (!_buttonPartner) {
        _buttonPartner = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buttonPartner setImage:kGetImage(@"tools_btn_add_partner") forState:UIControlStateNormal];
    }
    return _buttonPartner;
}

- (UIImageView *)imagesViewLink{
    if (!_imagesViewLink) {
        _imagesViewLink = [[UIImageView alloc] init];
        _imagesViewLink.image = kGetImage(@"tools_btn_link");
    }
    return _imagesViewLink;
}

- (UIImageView *)imagesViewTel{
    if (!_imagesViewTel) {
        _imagesViewTel = [[UIImageView alloc] init];
        _imagesViewTel.image = kGetImage(@"tools_btn_tel");
    }
    return _imagesViewTel;
}

- (UIButton *)tongxunluButton{
    if (!_tongxunluButton) {
        _tongxunluButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_tongxunluButton setTitleColor:HexString(@"#409EFF") forState:UIControlStateNormal];
        _tongxunluButton.titleLabel.font = kFontSizeMedium15;
        [_tongxunluButton setTitle:@"通讯录" forState:UIControlStateNormal];
        [_tongxunluButton setImage:kGetImage(@"tools_btn_tongxunlu") forState:UIControlStateNormal];
        //image在左，文字在右，default
        [Utils lz_setButtonTitleWithImageEdgeInsets:_tongxunluButton postition:kMVImagePositionLeft spacing:6];
        MV(weakSelf)
        [_tongxunluButton lz_handleControlEvent:UIControlEventTouchUpInside withBlock:^{
            [weakSelf handleButtonTapped:weakSelf.tongxunluButton];
        }];
    }
    return _tongxunluButton;
}

- (UIView *)linerView{
    if (!_linerView) {
        _linerView = [UIView lz_viewWithColor:HexString(@"#DDDDDD")];
    }
    return _linerView;
}

- (UIButton *)buttonBind{
    if (!_buttonBind) {
        _buttonBind = [UIButton buttonWithType:UIButtonTypeCustom];
        [_buttonBind setTitleColor:kWhiteColor forState:UIControlStateNormal];
        _buttonBind.titleLabel.font = kFontSizeMedium15;
        [_buttonBind setTitle:@"提交" forState:UIControlStateNormal];
        [_buttonBind lz_setCornerRadius:3.0];
        [_buttonBind setBackgroundImage:[UIImage lz_imageWithColor:HexString(@"#FF4163")] forState:UIControlStateNormal];
        MV(weakSelf);
        [_buttonBind lz_handleControlEvent:UIControlEventTouchUpInside withBlock:^{
            [weakSelf handleButtonTapped:weakSelf.buttonBind];
        }];
    }
    return _buttonBind;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
