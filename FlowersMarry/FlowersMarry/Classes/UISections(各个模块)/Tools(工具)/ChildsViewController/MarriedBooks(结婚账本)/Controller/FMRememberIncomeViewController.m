//
//  FMRememberIncomeViewController.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/9/27.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMRememberIncomeViewController.h"

@interface FMRememberIncomeViewController ()<UIScrollViewDelegate,UITextFieldDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UITextField *nicknameTextField;
@property (nonatomic, strong) UIImageView *imagesAvatar;
@property (nonatomic, strong) UITextField *amountTextField;

@property (nonatomic, strong) UIImageView *imagesIcon1;
@property (nonatomic, strong) UIImageView *imagesIcon2;
@property (nonatomic, strong) UIImageView *imagesIcon3;
@property (nonatomic, strong) UILabel *dataLabel;
@property (nonatomic, strong) UITextField *remarkTextField;

@property (nonatomic, strong) UIButton *hasGuestsButton;
@property (nonatomic, strong) UIButton *saveButton;
@property (nonatomic, strong) UIButton *deleteButton;

@end

@implementation FMRememberIncomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"记礼金";
    [self.imagesAvatar sd_setImageWithURL:kGetImageURL(@"") placeholderImage:kGetImage(mineAvatar)];
    [self initView];
    
    self.dataLabel.text = @"2018-10-05";
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = kWhiteColor;
    self.navigationController.navigationBar.translucent = YES;// NavigationBar 是否透明
}

- (void) initView{
    [self.view addSubview:self.scrollView];
    [self.view addSubview:self.saveButton];
    [self.saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(@(49));
    }];
    
    CGRect view1Frame = CGRectMake(0, kNavBarHeight, kScreenWidth, 70);
    UIView *view1 = [self viewWithFrame:view1Frame left:0];

    CGRect view2Frame = CGRectMake(0, CGRectGetMaxY(view1.frame)+26, kScreenWidth, 55);
    UIView *view2 = [self viewWithFrame:view2Frame left:15];

    CGRect view3Frame = CGRectMake(0, CGRectGetMaxY(view2.frame), kScreenWidth, 55);
    UIView *view3 = [self viewWithFrame:view3Frame left:15];
    [self.scrollView addSubview:view1];
    [self.scrollView addSubview:view2];
    [self.scrollView addSubview:view3];

    [view1 addSubview:self.imagesAvatar];
    [view1 addSubview:self.nicknameTextField];
    [view1 addSubview:self.amountTextField];

    [self.imagesAvatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(15));
        make.width.height.equalTo(@(IPHONE6_W(32)));
        make.centerY.equalTo(view1);
    }];

    [self.nicknameTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imagesAvatar.mas_right).offset(10);
        make.height.equalTo(@(44));
        make.width.equalTo(@(200));
        make.centerY.equalTo(self.imagesAvatar);
    }];
    [self.amountTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).offset(-15);
        make.centerY.height.equalTo(self.nicknameTextField);
        make.width.equalTo(@(100));
    }];

    [view2 addSubview:self.imagesIcon1];
    [view2 addSubview:self.dataLabel];
    [self.imagesIcon1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(15));
        make.centerY.equalTo(view2);
    }];
    [self.dataLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(41));
        make.centerY.equalTo(self.imagesIcon1);
    }];

    [view3 addSubview:self.imagesIcon2];
    [view3 addSubview:self.remarkTextField];
    [self.imagesIcon2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(15));
        make.centerY.equalTo(view3);
    }];
    [self.remarkTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(41));
        make.centerY.equalTo(self.imagesIcon2);
        make.height.equalTo(@(44));
        make.right.equalTo(self.view.mas_right).offset(-15);
    }];

    if (self.idxType==2) {
        CGRect view4Frame = CGRectMake(0, CGRectGetMaxY(view3.frame), kScreenWidth, 55);
        UIView *view4 = [self viewWithFrame:view4Frame left:15];
        [self.scrollView addSubview:view4];
        [view4 addSubview:self.imagesIcon3];
        [view4 addSubview:self.deleteButton];
        [self.imagesIcon3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.centerX.equalTo(self.imagesIcon1);
            make.centerY.equalTo(view4);
        }];
        [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.dataLabel);
            make.centerY.equalTo(self.imagesIcon3);
            make.right.equalTo(self.view.mas_right).offset(-15);
            make.height.equalTo(@(44));
        }];
    }else{
        [self.scrollView addSubview:self.hasGuestsButton];
        self.hasGuestsButton.frame = CGRectMake(0, CGRectGetMaxY(view3.frame), kScreenWidth, 44);
        [self.hasGuestsButton setTitle:@"你有18位宾客，点击批量导入礼金账目" forState:UIControlStateNormal];
    }
    
}

- (void) handleButtonTapped:(UIButton *)sender{
    if (sender.tag==1) {
        Toast(@"已有联系人");
    }else if (sender.tag==2){
        Toast(@"删除");
    }else if (sender.tag==3){
        Toast(@"保存");
    }
}

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.frame = self.view.bounds;
        _scrollView.delegate = self;
        _scrollView.backgroundColor = kClearColor;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.contentSize = CGSizeMake(kScreenWidth, kScreenHeight+1);
        _scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _scrollView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    }
    return _scrollView;
}

- (UIImageView *)imagesAvatar{
    if (!_imagesAvatar) {
        _imagesAvatar = [[UIImageView alloc] init];
    }
    return _imagesAvatar;
}

- (UIImageView *)imagesIcon1{
    if (!_imagesIcon1) {
        _imagesIcon1 = [[UIImageView alloc] init];
        _imagesIcon1.image = kGetImage(@"tools_btn_calendar");
    }
    return _imagesIcon1;
}

- (UIImageView *)imagesIcon2{
    if (!_imagesIcon2) {
        _imagesIcon2 = [[UIImageView alloc] init];
        _imagesIcon2.image = kGetImage(@"tools_btn_edit");
    }
    return _imagesIcon2;
}

- (UIImageView *)imagesIcon3{
    if (!_imagesIcon3) {
        _imagesIcon3 = [[UIImageView alloc] init];
        _imagesIcon3.image = kGetImage(@"tools_btn_delete");
    }
    return _imagesIcon3;
}

- (UILabel *)dataLabel{
    if (!_dataLabel) {
        _dataLabel = [UILabel lz_labelWithTitle:@"" color:kTextColor51 font:kFontSizeMedium12];
    }
    return _dataLabel;
}

- (UITextField *)nicknameTextField{
    if (!_nicknameTextField) {
        _nicknameTextField = [UITextField lz_textFieldWithPlaceHolder:@"请填写宾客姓名"];
        _nicknameTextField.returnKeyType = UIReturnKeyDone;
        _nicknameTextField.borderStyle = UITextBorderStyleNone;
        _nicknameTextField.delegate = self;
        _nicknameTextField.font = kFontSizeMedium14;
        _nicknameTextField.textColor = kTextColor102;
    }
    return _nicknameTextField;
}

- (UITextField *)amountTextField{
    if (!_amountTextField) {
        _amountTextField = [UITextField lz_textFieldWithPlaceHolder:@"0.00"];
        _amountTextField.returnKeyType = UIReturnKeyDone;
        _amountTextField.borderStyle = UITextBorderStyleNone;
        _amountTextField.textAlignment = NSTextAlignmentRight;
        _amountTextField.delegate = self;
        _amountTextField.font = kFontSizeMedium13;
        _nicknameTextField.textColor = kColorWithRGB(255, 65, 99);
    }
    return _amountTextField;
}

- (UITextField *)remarkTextField{
    if (!_remarkTextField) {
        _remarkTextField = [UITextField lz_textFieldWithPlaceHolder:@"添加备注"];
        _remarkTextField.returnKeyType = UIReturnKeyDone;
        _remarkTextField.borderStyle = UITextBorderStyleNone;
        _remarkTextField.delegate = self;
        _remarkTextField.font = kFontSizeMedium13;
    }
    return _remarkTextField;
}

- (UIButton *)hasGuestsButton{
    if (!_hasGuestsButton) {
        _hasGuestsButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_hasGuestsButton setTitleColor:kColorWithRGB(64, 158, 255) forState:UIControlStateNormal];
        _hasGuestsButton.titleLabel.font = kFontSizeMedium12;
        _hasGuestsButton.tag = 1;
        MV(weakSelf);
        [_hasGuestsButton lz_handleControlEvent:UIControlEventTouchUpInside withBlock:^{
            [weakSelf handleButtonTapped:weakSelf.hasGuestsButton];
        }];
    }
    return _hasGuestsButton;
}

- (UIButton *)deleteButton{
    if (!_deleteButton) {
        _deleteButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_deleteButton setTitleColor:HexString(@"#999999") forState:UIControlStateNormal];
        _deleteButton.titleLabel.font = kFontSizeMedium12;
        [_deleteButton setTitle:@"删除账目" forState:UIControlStateNormal];
        _deleteButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _deleteButton.tag = 2;
        MV(weakSelf);
        [_deleteButton lz_handleControlEvent:UIControlEventTouchUpInside withBlock:^{
            [weakSelf handleButtonTapped:weakSelf.deleteButton];
        }];
    }
    return _deleteButton;
}

- (UIButton *)saveButton{
    if (!_saveButton) {
        _saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_saveButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
        _saveButton.titleLabel.font = kFontSizeMedium15;
        [_saveButton setTitle:@"保存" forState:UIControlStateNormal];
        _saveButton.tag = 3;
        [_saveButton setBackgroundImage:imageColor(kColorWithRGB(255, 65, 99)) forState:UIControlStateNormal];
        MV(weakSelf);
        [_saveButton lz_handleControlEvent:UIControlEventTouchUpInside withBlock:^{
            [weakSelf handleButtonTapped:weakSelf.saveButton];
        }];
    }
    return _saveButton;
}

- (UIView *) viewWithFrame:(CGRect) frame left:(NSUInteger)left{
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = kClearColor;
    
    UIView *linerView = [UIView lz_viewWithColor:kColorWithRGB(238, 238, 238)];
    [view addSubview:linerView];
    [linerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(left));
        make.width.equalTo(@(kScreenWidth-left*2));
        make.height.equalTo(@(0.7));
        make.bottom.equalTo(view.mas_bottom);
    }];
    return view;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
