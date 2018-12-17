//
//  MVBaseViewController.m
//  MerchantVersion
//
//  Created by 寜小陌 on 2018/1/17.
//  Copyright © 2018年 寜小陌. All rights reserved.
//

#import "MVBaseViewController.h"

@interface MVBaseViewController ()
@property (nonatomic, strong) UIView *linerView;

@end

@implementation MVBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kViewColorNormal;
    self.lz_fullScreenPopGestureEnabled = YES;
    // 设置UINavigationBar的主题
    [self setupNavigationBarTheme];
    [self.view addSubview:self.linerView];
    [self.linerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(self.view);
        make.height.equalTo(@0.7);
        make.top.equalTo(@0);
    }];
}

- (void) setupNavigationBarTheme {
    
    // 1.去掉背景图片和底部线条
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage lz_imageWithColor:kNavigationColorNormal] resizableImageWithCapInsets:UIEdgeInsetsMake(5, 1, 5, 1)] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.tintColor = kColorWithRGB(51, 51, 51);
    //去掉导航栏下边的投影
    self.navigationController.navigationBar.shadowImage = [[UIImage lz_imageWithColor:kClearColor] resizableImageWithCapInsets:UIEdgeInsetsMake(1, 1, 1, 1)];
    
    self.navigationController.navigationBar.barTintColor = kNavigationColorNormal;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor lz_colorWithHexString:@"333333"]};
    self.navigationController.navigationBar.translucent = NO;// NavigationBar 是否透明
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
//    return UIStatusBarStyleLightContent;
    return UIStatusBarStyleDefault;
}

- (UIView *)linerView{
    if (!_linerView) {
        _linerView = [[UIView alloc] init];
        _linerView.backgroundColor = kColorWithRGB(211, 211, 211);
    }
    return _linerView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
//    [[SDWebImageManager sharedManager] cancelAll];
//    [[SDImageCache sharedImageCache] clearMemory];
}

@end
