//
//  FMTelephoneBookingView.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/8/20.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMTelephoneBookingView.h"


@interface FMTelephoneBookingView()<UITextFieldDelegate>

@property (nonatomic, strong) UIView    *contentView;
@property (nonatomic, assign) CGFloat   viewHeight;
@property (nonatomic, assign) CGFloat   viewY;
@property (nonatomic, assign) NSString  *cp_id;
@property (nonatomic, assign) NSString  *ap_type;
@property (nonatomic, assign) BOOL   isPreferential;

@end
@implementation FMTelephoneBookingView
- (id)initDataString:(NSString *)cp_id ap_type:(NSString *)ap_type isPreferential:(BOOL)isPreferential{
    if ( self = [super init] ){
        self.cp_id = cp_id;
        self.ap_type = ap_type;
        self.isPreferential = isPreferential;
        
        [self initContent];
        _viewHeight = IPHONE6_W(287) + kSafeAreaBottomHeight;  // 弹出View的高度
        _viewY = kScreenHeight - _viewHeight;
        [self addGesture];
    }
    return self;
}

- (void) handleControlEvent{
    NSString *telStr = self.telTextField.text;
    if(telStr.length==0){
        Toast(@"请输入电话号码");
    } else if (telStr.length!=11) {
        Toast(@"请输入正确的电话号码");
    }else{
        /// 收藏当前动态
        [MBProgressHUD showMessage:@""];
        NSDictionary *parameter = @{@"cp_id":self.cp_id,@"ap_type":self.ap_type,@"ap_phone":telStr};
        [SCHttpTools getWithURLString:businessBooking parameter:parameter success:^(id responseObject) {
            NSDictionary *result = responseObject;
            if ([result isKindOfClass:[NSDictionary class]]) {
                [self disMissView];
                Toast([result lz_objectForKey:@"message"]);
            }
            [MBProgressHUD hideHUD];
        } failure:^(NSError *error) {
            TTLog(@" -- error -- %@",error);
            [MBProgressHUD hideHUD];
        }];
    }
}

- (void)initContent{
    self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    //alpha 0.0  白色   alpha 1 ：黑色   alpha 0～1 ：遮罩颜色，逐渐
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(disMissView)]];
    
    if (!_contentView) {
        _contentView = [[UIView alloc]initWithFrame:CGRectMake(0, _viewY, kScreenWidth, _viewHeight)];
        _contentView.backgroundColor = kWhiteColor;
        [self addSubview:_contentView];
        [SCMonitorKeyboard sc_AddMonitorWithShowBack:^(NSInteger height) {
            self->_contentView.frame = CGRectMake(0, kScreenHeight- self->_viewHeight -height,kScreenWidth,self->_viewHeight);
            TTLog(@"键盘出现了 == %ld",(long)height);
            
        } andDismissBlock:^(NSInteger height) {
            
            self->_contentView.frame = CGRectMake(0, kScreenHeight-self->_viewHeight,kScreenWidth,self->_viewHeight);
            TTLog(@"键盘消失了 == %ld",(long)height);
            
        }];
        [self initView];
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    
    CGRect rect = CGRectMake(0, _viewY, kScreenWidth, _viewHeight);
    UIView *view = [[UIView alloc] initWithFrame:rect];
    [view setTag:103];
    [view setBackgroundColor:[UIColor blackColor]];
    [view setAlpha:0.5];
    [_contentView addSubview:view];
    
    if (self.isPreferential) {
        self.labelCoupons.text = @"1111";//self.businessModel.youhui.coupon.title;
        self.labelGift.text = @"2222";//self.businessModel.youhui.gift;
    }else{
        self.imagesCoupons.hidden = YES;
        self.labelCoupons.hidden = YES;
        self.imagesGift.hidden = YES;
        self.labelGift.hidden = YES;
    }
    
}

#pragma mark keyboard notification
- (void)keyboardWillShow:(NSNotification *)notif {
    
    NSDictionary *userInfo = [notif userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    CGFloat y = keyboardRect.size.height;
    CGFloat x = keyboardRect.size.width;
    TTLog(@"键盘高度是  %d",(int)y);
    TTLog(@"键盘宽度是  %d",(int)x);
}

- (void)keyboardWillHide:(NSNotification *)notif {

}

//移除从上向底部弹下去的UIView（包含遮罩）
- (void)disMissView {
    [_contentView setFrame:CGRectMake(0, _viewY, kScreenWidth, _viewHeight)];
    [UIView animateWithDuration:0.3f
                     animations:^{
                         self.alpha = 0.0;
                         [self->_contentView setFrame:CGRectMake(0, kScreenHeight, kScreenWidth, self->_viewHeight)];
                     }
                     completion:^(BOOL finished){
                         [self removeFromSuperview];
                         [self->_contentView removeFromSuperview];
                     }];
}

//展示从底部向上弹出的UIView（包含遮罩）
- (void)showInView:(UIView *)view {
    if (!view) {
        return;
    }
    
    [view addSubview:self];
    [view addSubview:_contentView];
    
    [_contentView setFrame:CGRectMake(0, kScreenHeight, kScreenWidth, _viewHeight)];
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 1.0;
        [self->_contentView setFrame:CGRectMake(0, self->_viewY, kScreenWidth, self->_viewHeight)];
    } completion:nil];
}

#pragma mark 给当前view添加识别手势
#pragma mark -- 当前tableView中带有输入框点击背景关闭键盘
-(void)addGesture {
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture)];
    [_contentView addGestureRecognizer:tapGesture];
}

-(void)tapGesture {
    [_contentView endEditing:YES];
}

-(void)dealloc{
}


#pragma makr  ---- --- 约束设置 ---- ---
- (void) initView{
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.imagesCoupons];
    [self.contentView addSubview:self.labelCoupons];
    [self.contentView addSubview:self.imagesGift];
    [self.contentView addSubview:self.labelGift];
    [self.contentView addSubview:self.telContainerView];
    [self.telContainerView addSubview:self.telTextField];
    [self.contentView addSubview:self.immediatelyButton];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@21);
        make.left.right.equalTo(self.contentView);
    }];
    [self.imagesCoupons mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@70);
        make.left.equalTo(@15);
    }];
    [self.labelCoupons mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@70);
        make.left.equalTo(self.imagesCoupons.mas_right).offset(11);
        make.centerY.equalTo(self.imagesCoupons);
    }];
    [self.imagesGift mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imagesCoupons.mas_bottom).offset(25);
        make.left.equalTo(@15);
    }];
    [self.labelGift mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.labelCoupons);
        make.centerY.equalTo(self.imagesGift);
    }];
    [self.telContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@42);
        make.right.equalTo(self.contentView.mas_right).offset(-42);
        make.height.equalTo(@44);
        make.top.equalTo(self.imagesGift.mas_bottom).offset(21);
    }];
    
    [self.telTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.telContainerView.mas_left).offset(10);
        make.right.equalTo(self.telContainerView.mas_right).offset(-10);
        make.top.bottom.equalTo(self.telContainerView);
    }];
    [self.immediatelyButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-kSafeAreaBottomHeight);
        make.height.equalTo(@45);
    }];
}

#pragma makr  ---- --- setter/getter ---- ---
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
        MV(weakSelf)
        _immediatelyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_immediatelyButton setTitle:@"立即预约" forState:UIControlStateNormal];
        [_immediatelyButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
        _immediatelyButton.titleLabel.font = kFontSizeMedium15;
        _immediatelyButton.backgroundColor = kColorWithRGB(255, 65, 99);
        [_immediatelyButton lz_handleControlEvent:UIControlEventTouchUpInside withBlock:^{
            [weakSelf handleControlEvent];
        }];
    }
    return _immediatelyButton;
}
@end
