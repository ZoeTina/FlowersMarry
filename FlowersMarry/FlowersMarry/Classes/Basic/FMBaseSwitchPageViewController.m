//
//  FMBaseSwitchPageViewController.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/6/21.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMBaseSwitchPageViewController.h"

@interface FMBaseSwitchPageViewController ()

@end

@implementation FMBaseSwitchPageViewController

- (instancetype)init {
    if (self = [super init]) {
        self.titleSizeNormal = 14;  /// 默认字体大小
        self.titleSizeSelected = 14;/// 选中字体大小
        self.menuViewStyle = WMMenuViewStyleLine;/// 样式
        self.menuItemWidth = kScreenWidth / self.itemModelArray.count;/// 宽度
        self.viewTop = kNavigationBarHeight + kMVHeaderViewHeight;
        self.titleColorSelected = kColorWithRGB(34, 34, 34);
        self.titleColorNormal = kColorWithRGB(102, 102, 102);
        self.progressColor = kColorWithRGB(255, 69, 99);
        self.progressWidth = 70.0;
        self.progressHeight = 2.0;
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

- (void) setupNavigationBarTheme {
    
    // 1.去掉背景图片和底部线条
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    [self.navigationController.navigationBar setBackgroundImage:[imageColor(kColorWithRGB(253, 56, 98)) resizableImageWithCapInsets:UIEdgeInsetsMake(5, 1, 5, 1)] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    //去掉导航栏下边的投影
    self.navigationController.navigationBar.shadowImage = [imageColor(kClearColor) resizableImageWithCapInsets:UIEdgeInsetsMake(1, 1, 1, 1)];
    
    self.navigationController.navigationBar.barTintColor = kColorWithRGB(253, 56, 98);
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
    self.navigationController.navigationBar.translucent = NO;// NavigationBar 是否透明
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
}

- (NSArray *)itemModelArray{
    if (!_itemModelArray) {
        _itemModelArray = [[NSArray alloc] init];
        _itemModelArray = @[@"赴宴(18)",@"待定(5)",@"有事(25)"];
    }
    return _itemModelArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
