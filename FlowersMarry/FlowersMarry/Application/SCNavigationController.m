//
//  SCNavigationController.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/6/27.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "SCNavigationController.h"
#import "SCBaseViewController.h"

@interface SCNavigationController ()<UIGestureRecognizerDelegate,UINavigationControllerDelegate>

@property(nonatomic, weak) UIViewController *currentShowVC;

@end

@implementation SCNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    // 隐藏默认导航栏
    self.navigationBar.hidden = YES;
    __weak typeof (self) BBGNavigationController  = self;
    if ([self respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.interactivePopGestureRecognizer.delegate = BBGNavigationController;
    }
}

-(id)initWithRootViewController:(UIViewController *)rootViewController {
    SCNavigationController* nvc = [super initWithRootViewController:rootViewController];
    self.interactivePopGestureRecognizer.delegate = self;
    nvc.delegate = self;
    return nvc;
}
//-(void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
//}

-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    if (navigationController.viewControllers.count == 1)
        self.currentShowVC = Nil;
    else
        self.currentShowVC = viewController;
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    if (gestureRecognizer == self.interactivePopGestureRecognizer) {
        return (self.currentShowVC == self.topViewController);
    }
    return YES;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.childViewControllers.count > 0) {
        self.interactivePopGestureRecognizer.enabled = YES;
        self.interactivePopGestureRecognizer.delegate = self;
        viewController.hidesBottomBarWhenPushed = YES;
        if ([viewController isKindOfClass:[SCBaseViewController class]]) {
            SCBaseViewController *vc = (SCBaseViewController *)viewController;
            //TODO: 修改这里
            NSString *title = @"返回";
            if (self.childViewControllers.count >= 1) {
                title = @"all_btn_back_grey";
            }
            UIButton* leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [leftBtn setImage:[UIImage imageNamed:title] forState:UIControlStateNormal];
            leftBtn.frame = CGRectMake(0, 0, 40, 40);
            [leftBtn addTarget:self action:@selector(popToParent) forControlEvents:UIControlEventTouchUpInside];
            
            vc.scNavigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]  initWithCustomView:leftBtn];
            
            //修改iPhone X跳转时tabbar往上移动问题
            viewController.hidesBottomBarWhenPushed = YES;
        }
    }else{
        self.interactivePopGestureRecognizer.enabled = NO;
    }
    [self.view endEditing:YES];//关闭键盘
    [super pushViewController:viewController animated:YES];
    
    //修改iPhone X跳转时tabbar往上移动问题
    CGRect frame = self.tabBarController.tabBar.frame;
    frame.origin.y = [UIScreen mainScreen].bounds.size.height - frame.size.height;
    self.tabBarController.tabBar.frame = frame;
}

- (void)popToParent {
    [self popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
