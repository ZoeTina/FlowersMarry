//
//  FMMessagePopupViewController.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/6/25.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMMessagePopupViewController.h"

@interface FMMessagePopupViewController ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel   *titleLabel;
@property (nonatomic, strong) UIButton  *determineBtn;

@end

@implementation FMMessagePopupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 重设View的frame及其圆角
    self.view.frame = CGRectMake(IPHONE6_W((kScreenWidth - 200)/2), 0, IPHONE6_W(200), IPHONE6_W(180));
    self.view.layer.masksToBounds = YES;
    self.view.layer.cornerRadius = 12.0;
    
    
    self.titleLabel.text = self.messageStr;
    self.imageView.image = kGetImage(self.iconImage);
    
    [self.view addSubview:self.imageView];
    [self.view addSubview:self.titleLabel];
    [self.view addSubview:self.determineBtn];
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(IPHONE6_W(17.5)));
        make.centerX.equalTo(self.view);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageView.mas_bottom).offset(IPHONE6_W(12));
        make.centerX.equalTo(self.view);
    }];
    [self.determineBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(IPHONE6_W(16.5));
        make.centerX.equalTo(self.view);
        make.width.equalTo(@(IPHONE6_W(150)));
        make.height.equalTo(@(IPHONE6_W(30)));
    }];
}

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.image = kGetImage(@"Success");
    }
    return _imageView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"发送成功";
        _titleLabel.textColor = kColorWithRGB(51, 51, 51);
        _titleLabel.font = [UIFont systemFontOfSize:16.0];
    }
    return _titleLabel;
}

- (UIButton *)determineBtn{
    if (!_determineBtn) {
        _determineBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_determineBtn setBackgroundImage:imageColor(kColorWithRGB(255, 65, 99)) forState:UIControlStateNormal];
        _determineBtn.titleLabel.font = [UIFont systemFontOfSize:13.0];
        [_determineBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_determineBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [_determineBtn setTitle:@"知道啦" forState:UIControlStateNormal];
        [_determineBtn addTarget:self action:@selector(dismissedPopupView:) forControlEvents:UIControlEventTouchUpInside];
        _determineBtn.layer.cornerRadius = 5.0;
        _determineBtn.layer.masksToBounds = YES;
    }
    return _determineBtn;
}

// 去报名按钮
- (IBAction)dismissedPopupView:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(dismissedButtonClicked:)]) {
        [self.delegate dismissedButtonClicked:self];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
