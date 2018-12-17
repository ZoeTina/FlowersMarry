//
//  FMPersonalViewController.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/24.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMPersonalViewController.h"
#import "FMModifyUserInfoViewController.h"

@interface FMPersonalViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableViewCell *nickNameCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *sexCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *birthdayCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *wedDateCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *bindingTelCell;

@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *sexLabel;
@property (weak, nonatomic) IBOutlet UILabel *birthdayLabel;
@property (weak, nonatomic) IBOutlet UILabel *wedDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *telLabel;
@property (strong, nonatomic) UIButton *exitButton;
@property (strong, nonatomic) UIView *footerView;


@property (nonatomic, strong) UITableView *tableView;
@end

@implementation FMPersonalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initView];
    [Utils setLabelFontOrColor:self.nickNameLabel color:kTextColor153 font:kFontSizeMedium12];
    [Utils setLabelFontOrColor:self.sexLabel color:kTextColor153 font:kFontSizeMedium12];
    [Utils setLabelFontOrColor:self.birthdayLabel color:kTextColor153 font:kFontSizeMedium12];
    [Utils setLabelFontOrColor:self.wedDateLabel color:kTextColor153 font:kFontSizeMedium12];
    [Utils setLabelFontOrColor:self.telLabel color:kTextColor153 font:kFontSizeMedium12];
    
    [self.exitButton lz_handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        [[PVUserModel shared] logout];
        [[PVUserModel shared] dump];
    }];
    
    self.nickNameLabel.text = kUserInfo.username;
    self.birthdayLabel.text = kUserInfo.birthday;
    self.sexLabel.text = (kUserInfo.sex == 0) ? @"女" : @"男";
    self.wedDateLabel.text = kUserInfo.weday;
    self.telLabel.text = kUserInfo.mobile;
}

- (void) initView{
    self.title = @"个人资料";
    
    [Utils lz_setExtraCellLineHidden:self.tableView];
    [self.view addSubview:self.tableView];
    
    [self.footerView addSubview:self.exitButton];
    self.tableView.tableFooterView = self.footerView;
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(kLinerViewHeight));
        make.bottom.left.right.equalTo(self.view);
    }];
    
    [self.exitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(30));
        make.left.equalTo(@(15));
        make.right.equalTo(self.view.mas_right).offset(-15);
        make.height.equalTo(@(51));
    }];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSUInteger row = [indexPath row];
    static NSString *CellIdentifier = @"FMPersonalInfoViewCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (row == 0) {
        _nickNameCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return _nickNameCell;
    }
    if (row == 1) {
        _sexCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return _sexCell;
    }
    if (row == 2) {
        _wedDateCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return _wedDateCell;
    }
    if (row == 3) {
        _birthdayCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return _birthdayCell;
    }
    if (row == 4) {
        _bindingTelCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return _bindingTelCell;
    }
    return cell;
}

// 多少个分组 section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

/// 返回多少
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return IPHONE6_W(50);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSInteger row = [indexPath row];
    if (row == 0) { // 修改昵称
        [self modifyUserInfo];
    }
    if (row == 1) {// 修改性别
        [self showSexActionSheet];
    }
    if (row==2){// 修改婚期
        /// 当前日期
        [self showDataPicker:0 minDateStr:[Utils lz_getCurrentDate] maxDateStr:@""];
    }if(row==3){// 修改生日
        [self showDataPicker:1 minDateStr:@"" maxDateStr:[Utils lz_getCurrentDate]];
    }else{
        
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


/** 个人信息修改 */
- (void) modifyUserInfo{
    MV(weakSelf)
    FMModifyUserInfoViewController *view = [[FMModifyUserInfoViewController alloc] init];
    view.nickname = _nickNameLabel.text;
    view.tabBarTitle = @"个人信息";
    view.block = ^(NSString *text) {
        weakSelf.nickNameLabel.text = text;
        [kNotificationCenter postNotificationName:@"changeUserInfo" object:nil];
    };
    LZNavigationController *nav = [[LZNavigationController alloc] initWithRootViewController:view];
    [self.navigationController presentViewController:nav animated:YES completion:^{
        TTLog(@"个人信息修改");
    }];
}

- (void) showSexActionSheet{
    // 使用方式
    LZActionSheet *actionSheet = [[LZActionSheet alloc] initWithTitle:@"" cancelButtonTitle:@"取消" destructiveButtonTitle:@"" otherButtonTitles:@[@"女",@"男"] actionSheetBlock:^(NSInteger buttonIndex) {
        self.sexLabel.text = buttonIndex==0?@"女":@"男";
        [self updateUserInfoDataRequest];
    }];
    [actionSheet showView];
}

- (void) showDataPicker:(NSInteger) idx minDateStr:(NSString *)minDateStr maxDateStr:(NSString *)masDateStr{
    MV(weakSelf)
    /**
     *  显示时间选择器
     *
     *  @param title            标题
     *  @param type             类型（时间、日期、日期和时间、倒计时）
     *  @param defaultSelValue  默认选中的时间（为空，默认选中现在的时间）
     *  @param minDateStr       最小时间（如：2015-08-28 00:00:00），可为空
     *  @param maxDateStr       最大时间（如：2018-05-05 00:00:00），可为空
     *  @param isAutoSelect     是否自动选择，即选择完(滚动完)执行结果回调，传选择的结果值
     *  @param resultBlock      选择结果的回调
     *
     */
    [LZDatePickerView showDatePickerWithTitle:@"" dateType:UIDatePickerModeDate defaultSelValue:@"" minDateStr:minDateStr maxDateStr:masDateStr isAutoSelect:NO resultBlock:^(NSString *selectValue) {
        if (idx==0) {
            weakSelf.wedDateLabel.text = selectValue;
        }else{
            weakSelf.birthdayLabel.text = selectValue;
        }
        [weakSelf updateUserInfoDataRequest];
    }];
}

- (void) updateUserInfoDataRequest{
    
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    NSNumber *sex = [self.sexLabel.text isEqualToString:@"男"] ? @(1) : @(0);
    [parameter setObject:self.nickNameLabel.text forKey:@"username"];
    [parameter setObject:self.birthdayLabel.text forKey:@"birthday"];
    [parameter setObject:sex forKey:@"sex"];
    [parameter setObject:self.wedDateLabel.text forKey:@"weday"];
    [MBProgressHUD showMessage:@"" toView:self.view];
    [SCHttpTools getWithURLString:@"user/saveinfo" parameter:parameter success:^(id responseObject) {
        NSDictionary *result  = responseObject;
        [MBProgressHUD hideHUDForView:self.view];
        if (result){
            if ([[result lz_objectForKey:@"errcode"] integerValue]==0) {
                Toast(@"信息修改成功");
                
                kUserInfo.username = self.nickNameLabel.text;
                kUserInfo.sex = [sex integerValue];
                kUserInfo.birthday = self.birthdayLabel.text;
                kUserInfo.weday = self.wedDateLabel.text;
                
                [kUserInfo dump];
            }
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view];
        TTLog(@"修改信息 -- %@", error);
    }];
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.showsVerticalScrollIndicator = false;
        [_tableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = kColorWithRGB(245, 244, 249);
    }
    return _tableView;
}

- (UIButton *)exitButton{
    if (!_exitButton) {
        _exitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _exitButton.titleLabel.font = kFontSizeMedium15;
        [_exitButton setBackgroundImage:imageHexString(@"#FF4163") forState:UIControlStateNormal];
        [_exitButton setCornerRadius:3.0];
        [_exitButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [_exitButton setTitle:@"退出登录" forState:UIControlStateNormal];
    }
    return _exitButton;
}

- (UIView *)footerView{
    if (!_footerView) {
        _footerView = [UIView lz_viewWithColor:kClearColor];
        _footerView.frame = CGRectMake(0, 0, kScreenWidth, 100);
    }
    return _footerView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
