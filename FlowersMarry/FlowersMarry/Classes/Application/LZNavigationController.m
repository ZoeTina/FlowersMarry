//
//  LZNavigationController.m
//  LZKit
//
//  Created by 寕小陌 on 2017/10/12.
//  Copyright © 2017年 寕小陌. All rights reserved.
//

#import "LZNavigationController.h"

#pragma mark - LZNavigationController
@interface LZNavigationController ()<UINavigationControllerDelegate,UIGestureRecognizerDelegate>

@end

@implementation LZNavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    if (self = [super init]) {
        rootViewController.lz_navigationController = self;
        self.viewControllers = @[[LZWrapViewController wrapViewControllerWithViewController:rootViewController]];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.viewControllers.firstObject.lz_navigationController = self;
        self.viewControllers = @[[LZWrapViewController wrapViewControllerWithViewController:self.viewControllers.firstObject]];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    [self setNavigationBarHidden:YES];
    self.delegate = self;
    self.popGestureDelegate = self.interactivePopGestureRecognizer.delegate;
    SEL action = NSSelectorFromString(@"handleNavigationTransition:");
    self.popPanGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self.popGestureDelegate action:action];
    self.popPanGesture.maximumNumberOfTouches = 1;
}

// 加载完之后调用
- (void) navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    // 如果展示的控制器是根控制器,就还还原pop代理
//    if (viewController == [self.viewControllers firstObject]) {
//        self.interactivePopGestureRecognizer.delegate = self.popGestureDelegate;
//    }
    BOOL isRootVC = viewController == navigationController.viewControllers.firstObject;
    
    if (viewController.lz_fullScreenPopGestureEnabled) {
        if (isRootVC) {
            [self.view removeGestureRecognizer:self.popPanGesture];
        } else {
            [self.view addGestureRecognizer:self.popPanGesture];
        }
        self.interactivePopGestureRecognizer.delegate = self.popGestureDelegate;
        self.interactivePopGestureRecognizer.enabled = NO;
    } else {
        [self.view removeGestureRecognizer:self.popPanGesture];
        self.interactivePopGestureRecognizer.delegate = self;
        self.interactivePopGestureRecognizer.enabled = !isRootVC;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UIGestureRecognizerDelegate

//修复有水平方向滚动的ScrollView时边缘返回手势失效的问题
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return [gestureRecognizer isKindOfClass:UIScreenEdgePanGestureRecognizer.class];
}

#pragma mark - Getter

- (NSArray *)lz_viewControllers {
    NSMutableArray *viewControllers = [NSMutableArray array];
    for (LZWrapViewController *wrapViewController in self.viewControllers) {
        [viewControllers addObject:wrapViewController.rootViewController];
    }
    return viewControllers.copy;
}


@end

/////******************************************** 添加全屏侧滑 ********************************************/////

#pragma mark - JTWrapNavigationController
@interface LZWrapNavigationController : UINavigationController

@end

@implementation LZWrapNavigationController

- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    return [self.navigationController popViewControllerAnimated:animated];
}

- (NSArray<UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated {
    return [self.navigationController popToRootViewControllerAnimated:animated];
}

- (NSArray<UIViewController *> *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    LZNavigationController *lz_navigationController = viewController.lz_navigationController;
    NSInteger index = [lz_navigationController.lz_viewControllers indexOfObject:viewController];
    return [self.navigationController popToViewController:lz_navigationController.viewControllers[index] animated:animated];
}

- (void) pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    // 如果现在push的不是栈底控制器(最先push进来的那个控制器)
//    if (self.viewControllers.count > 0) {
//        self.interactivePopGestureRecognizer.enabled = YES;
////        self.interactivePopGestureRecognizer.delegate = self;
//        viewController.hidesBottomBarWhenPushed = YES;
//
//        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
//        // 设置导航栏的按钮(返回)
//        UIBarButtonItem *backButton = [UIBarButtonItem lz_itemWithImageName:@"nav_back_copy"
//                                                              highImageName:@"nav_back_copy"
//                                                                     target:self
//                                                                     action:@selector(didBackOnClick:)];
//        viewController.navigationItem.leftBarButtonItems = @[negativeSpacer, backButton];
//
//        // 就有滑动返回功能(系统默认的侧滑返回)
//        self.interactivePopGestureRecognizer.delegate = nil;
//
//    }
//    [super pushViewController:viewController animated:animated]
    
    viewController.lz_navigationController = (LZNavigationController *)self.navigationController;
    viewController.lz_fullScreenPopGestureEnabled = viewController.lz_navigationController.isFullScreenPopGestureEnabled;
    
    UIImage *backButtonImage = viewController.lz_navigationController.backButtonImage;
    
    if (!backButtonImage) {
//        backButtonImage = [UIImage imageNamed:kDefaultBackImageName];
        backButtonImage = [UIImage imageNamed:@"all_btn_back_grey"];
    }
    
    viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:backButtonImage style:UIBarButtonItemStylePlain target:self action:@selector(didBackOnClick:)];
    
    [self.navigationController pushViewController:[LZWrapViewController wrapViewControllerWithViewController:viewController] animated:animated];
}

- (void)didBackOnClick:(UIBarButtonItem *)barButtonItem {
    // 判断两种情况: push 和 present
    if ((self.navigationController.presentedViewController || self.navigationController.presentingViewController) && self.navigationController.childViewControllers.count == 1) {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }else {
//        [self popViewControllerAnimated:YES];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion{
    [self.navigationController dismissViewControllerAnimated:flag completion:completion];
    self.viewControllers.firstObject.lz_navigationController=nil;
}

@end


#pragma mark - LZWrapViewController

static NSValue *lz_tabBarRectValue;

@implementation LZWrapViewController

+ (LZWrapViewController *)wrapViewControllerWithViewController:(UIViewController *)viewController {
    
    LZWrapNavigationController *wrapNavController = [[LZWrapNavigationController alloc] init];
    wrapNavController.viewControllers = @[viewController];
    
    LZWrapViewController *wrapViewController = [[LZWrapViewController alloc] init];
    [wrapViewController.view addSubview:wrapNavController.view];
    [wrapViewController addChildViewController:wrapNavController];
    
    return wrapViewController;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    if (self.tabBarController && !lz_tabBarRectValue) {
        lz_tabBarRectValue = [NSValue valueWithCGRect:self.tabBarController.tabBar.frame];
    }
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (self.tabBarController && [self rootViewController].hidesBottomBarWhenPushed) {
        self.tabBarController.tabBar.frame = CGRectZero;
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.translucent = YES;
    if (self.tabBarController && !self.tabBarController.tabBar.hidden && lz_tabBarRectValue) {
        self.tabBarController.tabBar.frame = lz_tabBarRectValue.CGRectValue;
    }
}

- (BOOL)lz_fullScreenPopGestureEnabled {
    return [self rootViewController].lz_fullScreenPopGestureEnabled;
}

- (BOOL)hidesBottomBarWhenPushed {
    return [self rootViewController].hidesBottomBarWhenPushed;
}

- (UITabBarItem *)tabBarItem {
    return [self rootViewController].tabBarItem;
}

- (NSString *)title {
    return [self rootViewController].title;
}

- (UIViewController *)childViewControllerForStatusBarStyle {
    return [self rootViewController];
}

- (UIViewController *)childViewControllerForStatusBarHidden {
    return [self rootViewController];
}

- (UIViewController *)rootViewController {
    LZWrapNavigationController *wrapNavController = self.childViewControllers.firstObject;
    return wrapNavController.viewControllers.firstObject;
}

@end





























