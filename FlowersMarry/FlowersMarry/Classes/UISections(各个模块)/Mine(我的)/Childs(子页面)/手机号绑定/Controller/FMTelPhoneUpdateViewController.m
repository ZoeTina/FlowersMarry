//
//  FMTelPhoneUpdateViewController.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/10.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMTelPhoneUpdateViewController.h"
#import "FMTelPhoneBindViewController.h"
#import "FMInputValidationViewController.h"

@interface FMTelPhoneUpdateViewController ()<UIScrollViewDelegate,UITextFieldDelegate>
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIButton *saveButton;
@property(nonatomic, strong) UILabel* titleLabel;

@end

@implementation FMTelPhoneUpdateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.titleLabel.text = [NSString stringWithFormat:@"您已绑定了手机号码：%@",kUserInfo.mobile];
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.titleLabel];
    [self.scrollView addSubview:self.saveButton];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(IPHONE6_W(30));
        make.centerX.mas_equalTo(self.view);
    }];
    [self.saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(IPHONE6_W(15));
        make.height.mas_equalTo(IPHONE6_W(44));
        make.right.mas_equalTo(self.view.mas_right).mas_offset(IPHONE6_W(-15));
        make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_offset(IPHONE6_W(40));
    }];
}

- (void) handleButtonTapped:(UIButton *)sender{
    FMInputValidationViewController *vc = [[FMInputValidationViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.frame = self.view.bounds;
        _scrollView.delegate = self;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.contentSize = CGSizeMake(kScreenWidth, kScreenHeight+1);
        _scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return _scrollView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel lz_labelWithTitle:@"" color:kTextColor51 font:kFontSizeMedium14];
    }
    return _titleLabel;
}

- (UIButton *)saveButton{
    if (!_saveButton) {
        _saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_saveButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
        _saveButton.titleLabel.font = kFontSizeMedium15;
        [_saveButton lz_setCornerRadius:3.0];
        [_saveButton setTitle:@"更换手机号" forState:UIControlStateNormal];
        [_saveButton setBackgroundImage:imageColor(kColorWithRGB(255, 65, 99)) forState:UIControlStateNormal];
        MV(weakSelf);
        [_saveButton lz_handleControlEvent:UIControlEventTouchUpInside withBlock:^{
                [weakSelf handleButtonTapped:weakSelf.saveButton];
        }];
    }
    return _saveButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
