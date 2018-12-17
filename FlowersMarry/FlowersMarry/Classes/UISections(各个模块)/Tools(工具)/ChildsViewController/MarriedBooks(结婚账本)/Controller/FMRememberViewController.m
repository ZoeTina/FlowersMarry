//
//  FMRememberViewController.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/9/26.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMRememberViewController.h"
#import "FMRememberIncomeViewController.h"
#import "FMRememberSpendingViewController.h"

@interface FMRememberViewController ()

@end

@implementation FMRememberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"活动管理";
}

- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return self.dataArray.count;
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    
    return self.dataArray[index];
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    
    if (index==0) return [[FMRememberIncomeViewController alloc] init];
    return [[FMRememberSpendingViewController alloc] init];
}

- (CGFloat)menuView:(WMMenuView *)menu widthForItemAtIndex:(NSInteger)index {
    CGFloat width = [super menuView:menu widthForItemAtIndex:index];
    return width;
}

/// 自定义 MenuView 框架
- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
    
    return CGRectMake(0, 0, kScreenWidth, 40);
}


#pragma mark - MVPageControllerDataSource -- (必须实现)
- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    
    //    CGFloat originY = self.viewTopHeight + kMenuViewHeight;
    return CGRectMake(0, 0, kScreenWidth, kScreenHeight);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
