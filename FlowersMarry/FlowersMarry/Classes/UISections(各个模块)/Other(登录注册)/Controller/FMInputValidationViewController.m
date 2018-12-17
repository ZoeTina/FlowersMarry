//
//  FMInputValidationViewController.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/23.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMInputValidationViewController.h"
#import "SCVerCodeInputView.h"
#import "FMGeneralModel.h"

@interface FMInputValidationViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UILabel   *titleLabel;
@property (nonatomic, strong) UILabel   *subtitleLabel;
@property (nonatomic, strong) UIButton *saveButton;
@property (nonatomic, strong) SCVerCodeInputView *verCodeInputView;

@end

@implementation FMInputValidationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.scrollView];
    [self initView];
    self.title = @"身份验证";
    self.verCodeInputView.block = ^(NSString *text){
        TTLog(@"text = %@",text);
        if (text.length==4) {
            
        }
    };
    [self obtainVerificationCode:self.saveButton];
}

- (void) handleButtonTapped:(UIButton *) sender{
    [self obtainVerificationCode:sender];
}

- (void) obtainVerificationCode:(UIButton *)sender{
    [SCHttpTools getWithURLString:@"index/smsverify" parameter:@{@"mobile":kUserInfo.mobile} success:^(id responseObject) {
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
    } failure:^(NSError *error) {
    }];
}

- (void) initView{
    
    self.subtitleLabel.text = [NSString stringWithFormat:@"验证码已发送至您的手机%@",kUserInfo.mobile];
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.titleLabel];
    [self.scrollView addSubview:self.subtitleLabel];
    [self.scrollView addSubview:self.verCodeInputView];
    [self.scrollView addSubview:self.saveButton];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(IPHONE6_W(28));
        make.centerX.mas_equalTo(self.view);
    }];
    [self.subtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_offset(IPHONE6_W(8));
        make.centerX.mas_equalTo(self.view);
    }];
    [self.verCodeInputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(IPHONE6_W(50));
        make.width.mas_equalTo(IPHONE6_W(252));
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.subtitleLabel.mas_bottom).mas_offset(IPHONE6_W(15));
    }];
    [self.saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.verCodeInputView);
        make.top.mas_equalTo(self.verCodeInputView.mas_bottom).mas_offset(IPHONE6_W(17));
    }];
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
        _titleLabel.text = @"为了让确认您的身份，需要验证手机号码";
    }
    return _titleLabel;
}

- (UILabel *)subtitleLabel{
    if (!_subtitleLabel) {
        _subtitleLabel = [UILabel lz_labelWithTitle:@"" color:kTextColor153 font:kFontSizeMedium14];
        _subtitleLabel.text = @"为了让确认您的身份，需要验证手机号码";
    }
    return _subtitleLabel;
}

- (UIButton *)saveButton{
    if (!_saveButton) {
        _saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_saveButton setTitleColor:kTextColor153 forState:UIControlStateNormal];
        _saveButton.titleLabel.font = kFontSizeMedium12;
        MV(weakSelf);
        [_saveButton lz_handleControlEvent:UIControlEventTouchUpInside withBlock:^{
            [weakSelf handleButtonTapped:weakSelf.saveButton];
        }];
    }
    return _saveButton;
}

- (SCVerCodeInputView *)verCodeInputView{
    if (!_verCodeInputView) {
        CGFloat width = 252;
        _verCodeInputView = [[SCVerCodeInputView alloc]initWithFrame:CGRectMake((kScreenWidth-width)/2, 100, width, 50)];
        _verCodeInputView.maxLenght = 4;//最大长度
        _verCodeInputView.keyBoardType = UIKeyboardTypeNumberPad;
        [_verCodeInputView sc_verCodeViewWithMaxLenght];
    }
    return _verCodeInputView;
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
