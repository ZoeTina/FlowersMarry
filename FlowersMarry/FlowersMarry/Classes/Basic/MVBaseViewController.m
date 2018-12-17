//
//  MVBaseViewController.m
//  MerchantVersion
//
//  Created by 寜小陌 on 2018/1/17.
//  Copyright © 2018年 寜小陌. All rights reserved.
//

#import "MVBaseViewController.h"

@interface MVBaseViewController ()
@property(nonatomic, assign)CGRect reminderBtnFrame;
@end

@implementation MVBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kViewColorNormal;
    self.lz_fullScreenPopGestureEnabled = YES;
    // 设置UINavigationBar的主题
    [self setupNavigationBarTheme];
    [self setUPUI];
    [kNotificationCenter addObserver:self selector:@selector(netWordSatus:) name:NetworkReachabilityStatus object:nil];
}

- (void) netWordSatus:(NSNotification*)notification{
    NSInteger status = ((NSNumber*)notification.userInfo[@"status"]).integerValue;
    if (status == AFNetworkReachabilityStatusReachableViaWWAN) {
//        self.reminderBtn.hidden = YES;
    }else if (status == AFNetworkReachabilityStatusReachableViaWiFi){
//        self.reminderBtn.hidden = YES;
    }else if(status == AFNetworkReachabilityStatusNotReachable){
        Toast(@"请检查网络状态是否正常");
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = kViewColorNormal;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self tapGesture];
}

#pragma mark 给当前view添加识别手势
#pragma mark -- 当前tableView中带有输入框点击背景关闭键盘
- (void) addGesture:(UITableView *) tableView{
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture)];
    [tableView addGestureRecognizer:tapGesture];
    tapGesture.cancelsTouchesInView = NO;
}

-(void)tapGesture {
    [kKeyWindow endEditing:YES];
}

/**
 * 设置界面
 */
- (void)setUPUI {
    [self.view addSubview:self.reminderBtn];
    if (CGRectGetMaxY(self.reminderBtnFrame) > 0.0) {
        self.reminderBtn.frame = self.reminderBtnFrame;
    }else{
        self.reminderBtn.frame = self.view.bounds;
    }
    
    if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == AFNetworkReachabilityStatusNotReachable) {
        self.reminderBtn.hidden = false;
    }
}

- (void) setupNavigationBarTheme {
    
    // 1.去掉背景图片和底部线条
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    [self.navigationController.navigationBar setBackgroundImage:[imageColor(kNavigationColorNormal) resizableImageWithCapInsets:UIEdgeInsetsMake(5, 1, 5, 1)] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.tintColor = kColorWithRGB(51, 51, 51);
    //去掉导航栏下边的投影
    self.navigationController.navigationBar.shadowImage = [imageColor(kClearColor) resizableImageWithCapInsets:UIEdgeInsetsMake(1, 1, 1, 1)];
    
    self.navigationController.navigationBar.barTintColor = kNavigationColorNormal;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:HexString(@"#333333")};
    self.navigationController.navigationBar.translucent = NO;// NavigationBar 是否透明
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
}

#pragma mark - 设置导航栏
- (void)setLeftNavBarItemWithString:(NSString *)title {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor lz_colorWithHex:0X000000] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor lz_colorWithHex:0X000000] forState:UIControlStateHighlighted];
    button.titleLabel.font = [UIFont fontWithName:@".PingFangSC-Regular" size:16];
    [button addTarget:self action:@selector(leftItemClick:) forControlEvents:UIControlEventTouchUpInside];
    button.adjustsImageWhenHighlighted = NO;
    [button sizeToFit];
    UIBarButtonItem* leftItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.scNavigationItem.leftBarButtonItem = leftItem;
}

- (void)setLeftNavBarItemWithImage:(NSString *)imageName {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(leftItemClick:) forControlEvents:UIControlEventTouchUpInside];
    button.adjustsImageWhenHighlighted = YES;
    [button sizeToFit];
    UIBarButtonItem* leftItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = leftItem;
}

- (void)setRightNavBarItemWithString:(NSString *)title{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:[UIColor lz_colorWithHex:0X000000] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor lz_colorWithHex:0X000000]forState:UIControlStateHighlighted];
    button.titleLabel.font = [UIFont fontWithName:@".PingFangSC-Regular" size:16];
    [button addTarget:self action:@selector(rightItemClick:) forControlEvents:UIControlEventTouchUpInside];
    button.adjustsImageWhenHighlighted = NO;
    [button sizeToFit];
    UIBarButtonItem* rightItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)setRightNavBarItemWithImage:(NSString *)imageName{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(rightItemClick:) forControlEvents:UIControlEventTouchUpInside];
    button.adjustsImageWhenHighlighted = YES;
    [button sizeToFit];
    UIBarButtonItem* rightItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)rightItemClick:(UIButton *)sender{
    
}

- (void)leftItemClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
//    return UIStatusBarStyleLightContent;
    return UIStatusBarStyleDefault;
}

-(void)adjustmentReminderBtnFrame:(CGRect)frame{
    self.reminderBtnFrame = frame;
}

-(UIButton *)reminderBtn{
    if (!_reminderBtn) {
        _reminderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _reminderBtn.hidden = true;
        _reminderBtn.titleLabel.font = [UIFont systemFontOfSize:17];
        [_reminderBtn setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
        _reminderBtn.backgroundColor = [UIColor clearColor];
        [_reminderBtn addTarget:self action:@selector(reminderBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        [_reminderBtn setTitle:@"点击这里重新加载" forState:UIControlStateNormal];
    }
    return _reminderBtn;
}

-(void)reminderBtnClicked{
    if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == AFNetworkReachabilityStatusNotReachable) {
        self.reminderBtn.hidden = false;
    }else{
        self.reminderBtn.hidden = true;
    }
    if ([self respondsToSelector:@selector(reLoadVCData)]) {
        [self reLoadVCData];
    }
    TTLog(@"重新加载");
}

-(void)reLoadVCData{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
//    [[SDWebImageManager sharedManager] cancelAll];
//    [[SDImageCache sharedImageCache] clearMemory];
}

@end
