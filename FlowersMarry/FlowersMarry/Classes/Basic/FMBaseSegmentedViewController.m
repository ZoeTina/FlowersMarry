//
//  FMBaseSegmentedViewController.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/2.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMBaseSegmentedViewController.h"

@interface FMBaseSegmentedViewController ()

@end

@implementation FMBaseSegmentedViewController
- (instancetype)init {
    if (self = [super init]) {
        self.titleFontName = @"PingFang-SC-Medium";
        self.titleSizeNormal = 14;  /// 默认字体大小
        self.titleSizeSelected = 14;/// 选中字体大小
        self.menuViewStyle = WMMenuViewStyleSegmented;/// 样式
        self.menuViewLayoutMode = WMMenuViewLayoutModeCenter;
        self.showOnNavigationBar = YES;
        self.menuItemWidth = 88;/// 宽度
        self.titleColorSelected = kColorWithRGB(51, 51, 51);
        self.titleColorNormal = kColorWithRGB(252, 252, 253);
        self.progressColor = kWhiteColor;
//        self.progressViewCornerRadius = 4.0;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.lz_fullScreenPopGestureEnabled = YES;
    // 设置UINavigationBar的主题
    [self setupNavigationBarTheme];
}

- (NSArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSArray alloc] init];
        _dataArray = @[@"记礼金",@"记开支"];
    }
    return _dataArray;
}

- (void) setupNavigationBarTheme {
    
    // 1.去掉背景图片和底部线条
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    [self.navigationController.navigationBar setBackgroundImage:[imageColor(kColorWithRGB(255, 65, 99)) resizableImageWithCapInsets:UIEdgeInsetsMake(5, 1, 5, 1)] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.tintColor = kWhiteColor;
    //去掉导航栏下边的投影
    self.navigationController.navigationBar.shadowImage = [imageColor(kClearColor) resizableImageWithCapInsets:UIEdgeInsetsMake(1, 1, 1, 1)];
    
    self.navigationController.navigationBar.barTintColor = kNavigationColorNormal;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:kWhiteColor};
    self.navigationController.navigationBar.translucent = YES;// NavigationBar 是否透明
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
