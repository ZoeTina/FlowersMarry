//
//  FMMarriedBudgetViewController.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/9/26.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMMarriedBudgetViewController.h"
#import "FMBudgetDetailsViewController.h"

@interface FMMarriedBudgetViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) UIView *textFieldView;
@property (nonatomic, strong) UIImageView *imageViewTop;
@property (nonatomic, strong) UIImageView *imageViewFigure;
@property (nonatomic, strong) UIImageView *imageViewBottom;
@property (nonatomic, strong) UIView      *bottomView;
@property (nonatomic, strong) UITextField *textField;

@property (nonatomic, strong) UILabel *tipsLable;

@property (nonatomic, strong) UIButton *startCountBtn;

@end

@implementation FMMarriedBudgetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initView];
}

- (void) handleButtonTapped:(UIButton *)sender{
    FMBudgetDetailsViewController *vc = [[FMBudgetDetailsViewController alloc] init];
    TTPushVC(vc);
}

- (void) initView{
    [self.view addSubview:self.bottomView];
    [self.bottomView addSubview:self.imageViewTop];
    [self.bottomView addSubview:self.imageViewFigure];
    [self.bottomView addSubview:self.textFieldView];
    [self.bottomView addSubview:self.imageViewBottom];
    [self.textFieldView addSubview:self.textField];
    [self.bottomView addSubview:self.startCountBtn];
    [self.bottomView addSubview:self.tipsLable];
    
    [self.imageViewTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.centerX.equalTo(self.view);
    }];
    
    [self.imageViewFigure mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.mas_equalTo(IPHONE6_W(70));
    }];
    
    [self.textFieldView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(IPHONE6_W(206)));
        make.height.equalTo(@(IPHONE6_W(40)));
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.imageViewTop.mas_bottom).offset(IPHONE6_W(-40));
    }];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(IPHONE6_W(150)));
        make.height.centerX.centerY.equalTo(self.textFieldView);
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(@(10));
    }];
    
    [self.imageViewBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.centerX.equalTo(self.view);
    }];
    
    [self.startCountBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.centerX.equalTo(self.textFieldView);
        make.height.mas_equalTo(IPHONE6_W(42));
        make.bottom.equalTo(self.tipsLable.mas_top).offset(IPHONE6_W(-17));
    }];
    [self.tipsLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(IPHONE6_W(-80));
    }];
}

- (UIImageView *)imageViewTop{
    if (!_imageViewTop) {
        _imageViewTop = [[UIImageView alloc] init];
        _imageViewTop.image = kGetImage(@"tools_yusuan_bg_top");
    }
    return _imageViewTop;
}

- (UIImageView *)imageViewFigure{
    if (!_imageViewFigure) {
        _imageViewFigure = [[UIImageView alloc] init];
        _imageViewFigure.image = kGetImage(@"tools_yusuan_figure");
    }
    return _imageViewFigure;
}

- (UIImageView *)imageViewBottom{
    if (!_imageViewBottom) {
        _imageViewBottom = [[UIImageView alloc] init];
        _imageViewBottom.image = kGetImage(@"tools_yusuan_xingxing");
    }
    return _imageViewBottom;
}

- (UIView *)textFieldView{
    if (!_textFieldView) {
        _textFieldView = [UIView lz_viewWithColor:kWhiteColor];
        [_textFieldView lz_setCornerRadius:IPHONE6_W(42)/2.0];
    }
    return _textFieldView;
}

- (UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [UIView lz_viewWithColor:kWhiteColor];
    }
    return _bottomView;
}

- (UITextField *)textField{
    if (!_textField) {
        _textField = [UITextField lz_textFieldWithPlaceHolder:@"请输入您的预算总金额"];
        _textField.returnKeyType = UIReturnKeyDone;
        _textField.borderStyle = UITextBorderStyleNone;
        _textField.delegate = self;
        _textField.font = kFontSizeMedium15;
    }
    return _textField;
}

- (UIButton *)startCountBtn{
    if (!_startCountBtn) {
        CALayer *layer = [CALayer layer];
        _startCountBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_startCountBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
        _startCountBtn.titleLabel.font = kFontSizeMedium15;
        [_startCountBtn setTitle:@"开始计算" forState:UIControlStateNormal];
        [_startCountBtn setBackgroundImage:[UIImage lz_imageWithColor:HexString(@"#FF5653")] forState:UIControlStateNormal];
        
        _startCountBtn.layer.shadowColor = [UIColor blackColor].CGColor;
        _startCountBtn.layer.shadowOffset = CGSizeMake(5, 5);
        _startCountBtn.layer.shadowRadius = 5;
        _startCountBtn.layer.shadowOpacity = 0.5;
        //这里self表示当前自定义的view
        [_startCountBtn.layer addSublayer:layer];
        MV(weakSelf);
        [_startCountBtn lz_setCornerRadius:IPHONE6_W(40)/2.0];
        [_startCountBtn lz_handleControlEvent:UIControlEventTouchUpInside withBlock:^{
            [weakSelf handleButtonTapped:weakSelf.startCountBtn];
        }];
    }
    return _startCountBtn;
}

- (UILabel *)tipsLable{
    if (!_tipsLable) {
        _tipsLable = [UILabel lz_labelWithTitle:@"" color:kTextColor153 font:kFontSizeMedium12];
        _tipsLable.text = @"由百万对新人结婚消费数据分析所得";
    }
    return _tipsLable;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
