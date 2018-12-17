//
//  FMModifyUserInfoViewController.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/9.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMModifyUserInfoViewController.h"

@interface FMModifyUserInfoViewController ()<UIScrollViewDelegate,UITextFieldDelegate>

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UITextField *textField;
@property (strong, nonatomic) UIButton *saveButton;
@property (strong, nonatomic) UIView *cellView;
@property (strong, nonatomic) UILabel *titlelabel;


@end

@implementation FMModifyUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kColorWithRGB(234, 235, 236);
    
    [self addGesture];
    [self initView];
    self.textField.text = self.nickname;
    
    // 添加右边保存按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveBtnClick)];
    
    // 添加左边保存按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelBtnClick)];
    
}

/** 取消(关闭界面) */
- (void) cancelBtnClick{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

/** 保存 */
- (void) saveBtnClick{
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self addGesture];
}

/** 保存 */
- (void) saveBtnClick:(UIButton *) sender{
    
    NSString *nickname = self.textField.text;

    if (nickname.length == 0) {
        Toast(@"昵称为空");
        return;
    }
    
    NSInteger length = [SCSmallTools convertToInt:nickname];
    if (length < 2) {
        Toast(@"昵称长度不够哦");
        return;
    }
    if (length > 20) {
        Toast(@"昵称长度超过20个字符了");
        return;
    }

    [self updateUserInfoDataRequest];
}

- (void) updateUserInfoDataRequest{
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setObject:self.textField.text forKey:@"username"];
    [MBProgressHUD showMessage:@"" toView:self.view];
    [SCHttpTools getWithURLString:@"user/saveinfo" parameter:parameter success:^(id responseObject) {
        NSDictionary *result  = responseObject;
        [MBProgressHUD hideHUDForView:self.view];
        
        TTLog(@" result --- %@",[Utils lz_dataWithJSONObject:result]);
        if (result){
            if ([[result lz_objectForKey:@"errcode"] integerValue]==0) {
                Toast(@"信息修改成功");
                kUserInfo.username = self.textField.text;
                [kUserInfo dump];
                if (self.block) {
                    self.block(self.textField.text);
                }
                [self dismissViewControllerAnimated:YES completion:nil];
            }else{
                NSString *message = [result lz_objectForKey:@"message"];
                Toast(message);
            }
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view];
        TTLog(@"修改信息 -- %@", error);
    }];
}

- (void) initView{
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.cellView];
    [self.cellView addSubview:self.textField];
    [self.scrollView addSubview:self.titlelabel];
    [self.scrollView addSubview:self.saveButton];
    
    
    [self.cellView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(IPHONE6_W(15));
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(IPHONE6_W(50));
    }];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(IPHONE6_W(13));
        make.right.mas_equalTo(self.cellView.mas_right).mas_offset(IPHONE6_W(-13));
        make.height.centerY.centerX.mas_equalTo(self.cellView);
    }];
    
    [self.titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.textField);
        make.top.equalTo(self.cellView.mas_bottom).offset(IPHONE6_W(10));
    }];
    
    [self.saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.textField);
        make.height.equalTo(@44);
        make.top.equalTo(self.titlelabel.mas_bottom).offset(IPHONE6_W(50));
    }];
}

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.frame = self.view.bounds;
        _scrollView.delegate = self;
        _scrollView.backgroundColor = kTextColor244;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.contentSize = CGSizeMake(kScreenWidth, kScreenHeight+1);
        _scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    }
    return _scrollView;
}

- (UIView *)cellView{
    if (!_cellView) {
        _cellView = [UIView lz_viewWithColor:kWhiteColor];
    }
    return _cellView;
}

- (UITextField *)textField{
    if (!_textField) {
        _textField = [UITextField lz_textFieldWithPlaceHolder:@"请输入昵称"];
        _textField.returnKeyType = UIReturnKeyDone;
        _textField.clearButtonMode = UITextFieldViewModeAlways;
        _textField.borderStyle = UITextBorderStyleNone;
        _textField.delegate = self;
        _textField.text = self.nickname;
        _textField.font = kFontSizeMedium13;
    }
    return _textField;
}

- (UILabel *)titlelabel{
    if (!_titlelabel) {
        _titlelabel = [UILabel lz_labelWithTitle:@"" color:kTextColor128 font:kFontSizeMedium13];
        _titlelabel.text = @"昵称规则4-20个字符，可由中文、数字、组成";
    }
    return _titlelabel;
}

- (UIButton *)saveButton{
    if (!_saveButton) {
        _saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_saveButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
        _saveButton.titleLabel.font = kFontSizeMedium15;
        [_saveButton lz_setCornerRadius:3.0];
        [_saveButton setTitle:@"保存" forState:UIControlStateNormal];
        [_saveButton setBackgroundImage:imageColor(kColorWithRGB(255, 65, 99)) forState:UIControlStateNormal];
        MV(weakSelf);
        [_saveButton lz_handleControlEvent:UIControlEventTouchUpInside withBlock:^{
            [weakSelf saveBtnClick:self.saveButton];
        }];
    }
    return _saveButton;
}

#pragma mark 给当前view添加识别手势
#pragma mark -- 当前tableView中带有输入框点击背景关闭键盘
-(void)addGesture {
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture)];
    [self.scrollView addGestureRecognizer:tapGesture];
    tapGesture.cancelsTouchesInView = NO;
}

-(void)tapGesture {
    [kKeyWindow endEditing:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
