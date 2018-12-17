//
//  FMLoginViewController.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/10.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMLoginViewController.h"
#import "FMThridLoginView.h"
#import "SCLoginTools.h"
#import "PVUserModel.h"
#import "FMTelPhoneBindViewController.h"

@interface FMLoginViewController ()<FMThridLoginViewButtonClickDelegate>
/// 手机号外框
@property (weak, nonatomic) IBOutlet UIView *telBoxView;
/// 获取验证码外框
@property (weak, nonatomic) IBOutlet UIView *codeBoxView;
/// 勾选按钮
@property (weak, nonatomic) IBOutlet UIButton *checkButton;
/// 用户协议点击
@property (weak, nonatomic) IBOutlet UIButton *protocolButton;
/// 登录按钮
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
/// 手机号
@property (weak, nonatomic) IBOutlet UITextField *telField;
/// 验证码or密码填写
@property (weak, nonatomic) IBOutlet UITextField *pwdField;
/// 获取验证码按钮
@property (weak, nonatomic) IBOutlet UIButton *codeButton;
/// 顶部图标约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *iconTopLayout;
@end

@implementation FMLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self initBaseView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.view.backgroundColor = kWhiteColor;
    self.navigationController.navigationBar.hidden = YES;
    [kNotificationCenter addObserver:self selector:@selector(changeCodeView) name:UITextFieldTextDidChangeNotification object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [kNotificationCenter removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
}

-(void)initBaseView{

    MV(weakSelf)
    [self.loginButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
    self.loginButton.titleLabel.font = kFontSizeMedium15;
    
    [self.codeButton setTitleColor:kColorWithRGB(64, 158, 255) forState:UIControlStateNormal];
    self.codeButton.titleLabel.font = kFontSizeMedium13;
    
    [self.checkButton setImage:kGetImage(@"mine_btn_normal") forState:UIControlStateNormal];
    [self.checkButton setImage:kGetImage(@"mine_btn_selected") forState:UIControlStateSelected];
    self.checkButton.selected = YES;
    
    [self initThridLoginView];
    [self.checkButton lz_handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        weakSelf.checkButton.selected = !weakSelf.checkButton.selected;
    }];
    [self.loginButton lz_handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        [weakSelf loginBtnClick:weakSelf.loginButton];
    }];
    [self.codeButton lz_handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        [weakSelf obtainVerificationCode:weakSelf.codeButton];
    }];
}

- (void)changeCodeView {
    if (self.pwdField.text.length == 0) {
        [self.loginButton setBackgroundColor:UIColorHexString(0xFF4163)];
    }else {
        [self.loginButton setBackgroundColor:UIColorHexString(0xFF4163)];
    }
}

/**
 *  点击获取验证码
 *
 *  @param sender 当前按钮
 */
- (IBAction)obtainVerificationCode:(id)sender {
    NSString *telphone = self.telField.text;
    if (telphone.length == 0) {
        Toast(@"请输入电话号码");
        return;
    }
    if (![SCSmallTools checkTelNumber:telphone]) {
        Toast(@"请输入正确的电话号码");
        return;
    }
    
    [MBProgressHUD showMessage:@"" toView:self.view];
    [SCHttpTools getWithURLString:@"index/sendverify" parameter:@{@"mobile":telphone} success:^(id responseObject) {
        if (responseObject){
            id result = responseObject;
            if (result) {
                [MBProgressHUD hideHUDForView:self.view];
                if ([[result lz_objectForKey:@"errcode"] integerValue] == 0) {
                    [self countdown];
                }
                Toast([result lz_objectForKey:@"message"]);
            }
        }
    } failure:^(NSError *error) {

        [MBProgressHUD hideHUDForView:self.view];
        Toast(@"验证码发送失败");
        TTLog(@"error --- %@",error);

    }];
}

- (void) obtainCityData{
//    [kNotificationCenter postNotificationName:@"obtainCityData" object:nil];
}

/**
 *  点击注册按钮
 *
 *  @param sender 当前按钮
 */

- (IBAction)loginBtnClick:(id)sender {
    /// 发送通知重新获取城市数据
    [self obtainCityData];
    if (self.telField.text.length == 0) {
        Toast(@"请输入电话号码");
        return;
    }
    
    if (![SCSmallTools checkTelNumber:self.telField.text]) {
        Toast(@"请输入正确的电话号码");
        return;
    }
    if (self.pwdField.text.length == 0) {
        Toast(@"请输入验证码");
        return;
    }
    if (!self.checkButton.selected) {
        Toast(@"请同意用户协议");
        return;
    }
    [super tapGesture];
    [MBProgressHUD showMessage:@"" toView:self.view];
    NSDictionary *paraDic = @{@"mobile":self.telField.text, @"verify":self.pwdField.text};
    [SCHttpTools postWithURLString:@"index/loginbysms" parameter:paraDic success:^(id responseObject) {
        NSDictionary *result  = responseObject;
        [self loginSuccessful:result];
        [MBProgressHUD hideHUDForView:self.view];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view];
        Toast(@"登录失败");
        TTLog(@"error --- %@",error);
    }];
}

- (void) loginSuccessful:(NSDictionary *)result{
    if (result){
        PVUserDataModel *model = [PVUserDataModel mj_objectWithKeyValues:result];
        TTLog(@"登录 -- %@",[Utils lz_dataWithJSONObject:result]);
        if (model.errcode == 0) {
            PVUserModel *userModel = [PVUserModel shared];
            [userModel yy_modelSetWithDictionary:[result lz_objectForKey:@"data"]];
            [userModel dump];
            if (model.data.isBindTel) {
                AppDelegate* delegate = (AppDelegate*)kAppDelegate;
                [delegate jumpMainVC];
                [delegate openTencentLocation];
            }else{
                FMTelPhoneBindViewController *vc = [[FMTelPhoneBindViewController alloc] init];
                vc.type = 1;
                [self.navigationController pushViewController:vc animated:YES];
            }
        }else{
            Toast(model.message);
        }
    }
    [MBProgressHUD hideHUDForView:self.view];
}

- (void) loginThirdReuqst:(NSDictionary *)parameter{
    /// 发送通知重新获取城市数据
    [self obtainCityData];
    [SCHttpTools postWithURLString:@"index/loginbysns" parameter:parameter success:^(id responseObject) {
        NSDictionary *result  = responseObject;
        [self loginSuccessful:result];
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view];
        Toast(@"登录失败");
        TTLog(@"error --- %@",error);
    }];
}

/**
 *  微信登录按钮
 */
- (void)weixinClick {
    
    [MBProgressHUD showMessage:@"" toView:self.view];
    [SCLoginTools loginWithPlatform:SSDKPlatformTypeWechat successBlock:^(SSDKUser *userInfo) {
        [MBProgressHUD hideHUDForView:self.view];
        if (userInfo) {
            TTLog(@"userInfo.icon --- %@",userInfo.icon);
            TTLog(@"userInfo.nickname --- %@",userInfo.nickname);
            TTLog(@"openId --- %@",userInfo.uid);
            TTLog(@"openId --- %@",userInfo.rawData);
            NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
            /// 平台标识,qq=QQ,onst wx=微信 weibo=微博
            [parameter setObject:@"wx" forKey:@"platform"];
            [parameter setObject:userInfo.uid forKey:@"openid"];
            [parameter setObject:userInfo.rawData[@"unionid"] forKey:@"unionid"];
            [parameter setObject:userInfo.nickname forKey:@"nickname"];
            [parameter setObject:userInfo.icon forKey:@"headimgurl"];
            
            TTLog(@" - --- -%@",parameter);
            [self loginThirdReuqst:parameter];
        }else {
            Toast(@"获取微信用户信息失败");
        }
    } failureBlock:^(NSString *errorStr, NSError *error) {
        [MBProgressHUD hideHUDForView:self.view];
        if (errorStr.length > 0) {
            
        }else {
            //登录失败提示信息
            Toast(@"微信登录失败");
        }
    }];
    
}

/**
 *  新浪登录按钮
 */
- (void)weiboClick {
    
//    [[PVProgressHUD shared] showHudInView:self.view];
    
    [SCLoginTools loginWithPlatform:SSDKPlatformTypeSinaWeibo successBlock:^(SSDKUser *userInfo) {
        
//        [[PVProgressHUD shared] hideHudInView:self.view];
        
        if (userInfo) {
            TTLog(@"userInfo.icon --- %@",userInfo.icon);
            TTLog(@"userInfo.nickname --- %@",userInfo.nickname);
            TTLog(@"openId --- %@",userInfo.uid);
//            NSDictionary *dict = @{@"avatar":userInfo.icon, @"nickName":userInfo.nickname, @"openId":userInfo.uid, @"platform":SINAWEIBO, @"device":@(device)};
//            [self thridLoginWirhParaDict:dict];
        }else {
            Toast(@"获取微博用户信息失败");
        }
    } failureBlock:^(NSString *errorStr, NSError *error) {
        //因为微博有网页分享，所以没必要有未安装的提示信息
//        [[PVProgressHUD shared] hideHudInView:self.view];
        if (error) {
            Toast(@"微博登录失败");
        }
    }];
}

/**
 *  QQ登录按钮
 */
- (void)QQClick {
    
//    [[PVProgressHUD shared] showHudInView:self.view];
    
    [SCLoginTools loginWithPlatform:SSDKPlatformTypeQQ successBlock:^(SSDKUser *userInfo) {
        
//        [[PVProgressHUD shared] hideHudInView:self.view];
        
        if (userInfo) {
            TTLog(@"userInfo.icon --- %@",userInfo.icon);
            TTLog(@"userInfo.nickname --- %@",userInfo.nickname);
            TTLog(@"openId --- %@",userInfo.uid);
//            NSDictionary *dict = @{@"avatar":userInfo.icon, @"nickName":userInfo.nickname, @"openId":userInfo.uid, @"platform":QQ, @"device":@(device)};
//            [self thridLoginWirhParaDict:dict];
        }else {
            Toast(@"获取QQ用户信息失败");
        }
    } failureBlock:^(NSString *errorStr, NSError *error) {
        
//        [[PVProgressHUD shared] hideHudInView:self.view];
        
        if (errorStr.length > 0) {
            
        }else {
            //分享失败提示信息
            Toast(@"QQ登录失败");
        }
    }];
    
}

#pragma mark ----- 其他第三方登录 ----- 
- (void)initThridLoginView {
    FMThridLoginView *loginView = [[FMThridLoginView alloc] initWithFrame:CGRectZero];
    loginView.thridLoginViewDelegate = self;
    [self.view addSubview:loginView];
    [loginView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.height.mas_equalTo(IPHONE6_W(73));
        make.bottom.mas_offset(-(IPHONE6_W(43)+ kSafeAreaBottomHeight));
    }];
    
    UIView *lineView = [UIView lz_viewWithColor:UIColorHexString(0xD7D7D7)];
    [self.view addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(IPHONE6_W(13));
        make.right.mas_offset(-IPHONE6_W(13));
        make.height.mas_equalTo(0.5);
        make.bottom.equalTo(loginView.mas_top).mas_offset(-IPHONE6_W(30));
    }];
    
    UILabel *tipsLabel = [UILabel lz_labelWithTitle:@"第三方登录" color:kTextColor153 font:kFontSizeMedium12 alignment:NSTextAlignmentCenter];
    tipsLabel.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:tipsLabel];
    [tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(lineView.mas_centerY);
        make.centerX.mas_equalTo(lineView.mas_centerX);
        make.width.mas_equalTo(99);
    }];
}

/**
 *  点击获取验证码
 *
 *  倒计时
 */
- (void) countdown {
    
    [self.pwdField becomeFirstResponder];
    
    __block int timeout = 59; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [self.codeButton setTitle:@"重新获取" forState:UIControlStateNormal];
                self.codeButton.userInteractionEnabled = YES;
                //                [self.codeButton setBackgroundImage:[Utils imageWithColor:kColorWithRGB(107, 152, 254)] forState:UIControlStateNormal];
            });
        }else{
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [self.codeButton setTitle:[NSString stringWithFormat:@"%@秒后获取",strTime] forState:UIControlStateNormal];
                self.codeButton.userInteractionEnabled = NO;
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
