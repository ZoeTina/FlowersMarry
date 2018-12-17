//
//  FMTelPhoneBindViewController.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/9.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMTelPhoneBindViewController.h"
#import "FMTelPhoneBindTableViewCell.h"
#import "FMTelPhoneUpdateViewController.h"
#import "FMGeneralModel.h"
#import "LZRootViewController.h"

static NSString * const reuseIdentifier = @"FMTelPhoneBindTableViewCell";

@interface FMTelPhoneBindViewController ()<UIScrollViewDelegate,UITextFieldDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UILabel *telLabel;
@property (nonatomic, strong) UITextField *telTextField;
@property (nonatomic, strong) UITextField *codeTextField;
@property (nonatomic, strong) UILabel *codeLabel;
@property (nonatomic, strong) UIButton *codeButton;

@property (nonatomic, strong) UIButton *saveButton;
@property (nonatomic, strong) UIView *footerView;
@property (nonatomic, strong) UIView *firstView;
@property (nonatomic, strong) UIView *lastView;

@end

@implementation FMTelPhoneBindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if ([self.title isEqualToString:@"手机号绑定"]) {
        self.type = 1;
    }else{
        self.title = @"手机号绑定";
        self.type = 0;
    }
    [self initView];
}

- (void) initView{
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.firstView];
    [self.scrollView addSubview:self.lastView];
    [self.scrollView addSubview:self.saveButton];
    [self.firstView addSubview:self.telLabel];
    [self.firstView addSubview:self.telTextField];
    [self.lastView addSubview:self.codeLabel];
    [self.lastView addSubview:self.codeTextField];
    [self.lastView addSubview:self.codeButton];

    [self.telLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(IPHONE6_W(15));
        make.centerY.equalTo(self.firstView);
    }];
    [self.telTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(IPHONE6_W(80));
        make.right.equalTo(self.firstView.mas_right).mas_offset(IPHONE6_W(-80));
        make.height.centerY.equalTo(self.firstView);
    }];
    [self.codeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.telLabel);
        make.centerY.equalTo(self.lastView);
    }];
    [self.codeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.lastView.mas_right).mas_offset(IPHONE6_W(-15));
        make.centerY.equalTo(self.lastView);
    }];
    [self.codeTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.telTextField);
        make.right.equalTo(self.lastView.mas_right).offset(IPHONE6_W(-80));
        make.height.centerY.equalTo(self.lastView);
    }];
    [self.saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).mas_offset(IPHONE6_W(-15));
        make.left.equalTo(self.telLabel);
        make.height.equalTo(@44);
        make.top.equalTo(self.lastView.mas_bottom).offset(50);
    }];
}

- (void)touchesBegan:(NSSet*)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES]; //实现该方法是需要注意view需要是继承UIControl而来的
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return [textField resignFirstResponder];
}


- (void) obtainVerificationCode:(UIButton *)sender{
    NSString *telphone = self.telTextField.text;
    if (telphone.length == 0) {
        Toast(@"请输入电话号码");
        return;
    }
    if (![SCSmallTools checkTelNumber:telphone]) {
        Toast(@"请输入正确的电话号码");
        return;
    }
    
    [MBProgressHUD showMessage:@"" toView:self.view];
    [SCHttpTools getWithURLString:@"index/smsverify" parameter:@{@"mobile":telphone} success:^(id responseObject) {
        if (responseObject){
            id result = responseObject;
            if (result) {
                FMGeneralModel *genralModel = [FMGeneralModel mj_objectWithKeyValues:result];
                if (genralModel.errcode == 0) {
                    [self countdown:sender];
                }
                Toast([result lz_objectForKey:@"message"]);
            }
        }
        [MBProgressHUD hideHUDForView:self.view];
    } failure:^(NSError *error) {
        
        [MBProgressHUD hideHUDForView:self.view];
        Toast(@"验证码发送失败");
        TTLog(@"error --- %@",error);
    }];
}

- (void) handleButtonTapped:(UIButton *)sender{
    NSString *telphone = self.telTextField.text;
    NSString *codeStr = self.codeTextField.text;

    if (telphone.length == 0) {
        Toast(@"请输入电话号码");
        return;
    }

    if (![SCSmallTools checkTelNumber:telphone]) {
        Toast(@"请输入正确的电话号码");
        return;
    }
    if (codeStr.length == 0) {
        Toast(@"请输入验证码");
        return;
    }
    [self.view endEditing:YES];
    [MBProgressHUD showMessage:@"" toView:self.view];
    NSDictionary *parameter = @{@"mobile":telphone, @"verify":codeStr};
    [SCHttpTools postWithURLString:@"index/mobilelogin" parameter:parameter success:^(id responseObject) {
        NSDictionary *result  = responseObject;
        if (result){
            PVUserDataModel *model = [PVUserDataModel mj_objectWithKeyValues:result];
            TTLog(@"登录 -- %@ \n %@",[Utils lz_dataWithJSONObject:result],model.sid);
            if (model.errcode == 0) {
                PVUserModel *userModel = [PVUserModel shared];
                [userModel yy_modelSetWithDictionary:[result lz_objectForKey:@"data"]];
                [userModel dump];
                if (self.type==0) {
                    LZRootViewController *mainVC   = [[LZRootViewController alloc] init];
                    kKeyWindow.rootViewController = mainVC;
                }else{
                    [self.navigationController popToRootViewControllerAnimated:YES];
                }
            }else{
                Toast(@"手机号绑定失败");
            }
        }
        [MBProgressHUD hideHUDForView:self.view];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view];
        Toast(@"登录失败");
        TTLog(@"error --- %@",error);
    }];
}

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.frame = self.view.bounds;
        _scrollView.y = 1;
        _scrollView.delegate = self;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.contentSize = CGSizeMake(kScreenWidth, kScreenHeight+1);
        _scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return _scrollView;
}

- (UILabel *)telLabel{
    if (!_telLabel) {
        _telLabel = [UILabel lz_labelWithTitle:@"手机号" color:kTextColor51 font:kFontSizeMedium14];
    }
    return _telLabel;
}

- (UILabel *)codeLabel{
    if (!_codeLabel) {
        _codeLabel = [UILabel lz_labelWithTitle:@"验证码" color:kTextColor51 font:kFontSizeMedium14];
    }
    return _codeLabel;
}

- (UIButton *)saveButton{
    if (!_saveButton) {
        _saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _saveButton.frame = CGRectMake(IPHONE6_W(15), IPHONE6_W(50), kScreenWidth-IPHONE6_W(30), IPHONE6_W(44));
        [_saveButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
        _saveButton.titleLabel.font = kFontSizeMedium15;
        [_saveButton lz_setCornerRadius:3.0];
        [_saveButton setTitle:@"绑定" forState:UIControlStateNormal];
        [_saveButton setBackgroundImage:imageColor(kColorWithRGB(255, 65, 99)) forState:UIControlStateNormal];
        MV(weakSelf);
        [_saveButton lz_handleControlEvent:UIControlEventTouchUpInside withBlock:^{
            [weakSelf handleButtonTapped:weakSelf.saveButton];
        }];
    }
    return _saveButton;
}

- (UIView *)firstView{
    if (!_firstView) {
        _firstView = [UIView lz_viewWithColor:kWhiteColor];
        _firstView.frame = CGRectMake(0, 0, kScreenWidth, IPHONE6_W(57));
        UIView *linerView = [UIView lz_viewWithColor:kLinerViewColor];
        [_firstView addSubview:linerView];
        linerView.frame = CGRectMake(IPHONE6_W(15), IPHONE6_W(56), kScreenWidth-IPHONE6_W(30), 0.5);
    }
    return _firstView;
}

- (UIView *)lastView{
    if (!_lastView) {
        _lastView = [UIView lz_viewWithColor:kWhiteColor];
        _lastView.frame = CGRectMake(0, CGRectGetMaxY(_firstView.frame)+1, kScreenWidth, IPHONE6_W(57));
        UIView *linerView = [UIView lz_viewWithColor:kLinerViewColor];
        [_lastView addSubview:linerView];
        linerView.frame = CGRectMake(IPHONE6_W(15), IPHONE6_W(56), kScreenWidth-IPHONE6_W(30), 0.5);
    }
    return _lastView;
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

- (UITextField *)codeTextField{
    if (!_codeTextField) {
        _codeTextField = [UITextField lz_textFieldWithPlaceHolder:@"请输入手机号"];
        _codeTextField.returnKeyType = UIReturnKeyDone;
        _codeTextField.borderStyle = UITextBorderStyleNone;
        _codeTextField.keyboardType = UIKeyboardTypeNumberPad;
        _codeTextField.delegate = self;
        _codeTextField.font = kFontSizeMedium13;
    }
    return _codeTextField;
}

- (UIButton *)codeButton{
    if (!_codeButton) {
        _codeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_codeButton setTitleColor:[UIColor lz_colorWithHexString:@"#409EFF"] forState:UIControlStateNormal];
        _codeButton.titleLabel.font = kFontSizeMedium13;
        [_codeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
        MV(weakSelf);
        [_codeButton lz_handleControlEvent:UIControlEventTouchUpInside withBlock:^{
            [weakSelf obtainVerificationCode:weakSelf.codeButton];
        }];
    }
    return _codeButton;
}

/**
 *  点击获取验证码
 *
 *  倒计时
 */
- (void) countdown:(UIButton *)sender{
    __block int timeout = 59; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [sender setTitle:@"重新获取" forState:UIControlStateNormal];
                sender.userInteractionEnabled = YES;
            });
        }else{
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [sender setTitle:[NSString stringWithFormat:@"%@秒后获取",strTime] forState:UIControlStateNormal];
                sender.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
