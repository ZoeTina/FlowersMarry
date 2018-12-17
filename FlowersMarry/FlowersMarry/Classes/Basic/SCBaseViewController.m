//
//  SCBaseViewController.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/6/27.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "SCBaseViewController.h"
#import "SCNavigationBar.h"

@interface SCBaseViewController ()
@property(nonatomic, assign)CGRect reminderBtnFrame;
@end

@implementation SCBaseViewController

- (SCNavigationBar *)scNavigationBar {
    if (!_scNavigationBar) {
        _scNavigationBar = [[SCNavigationBar alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kNavBarHeight)];
    }
    return _scNavigationBar;
}

- (UINavigationItem *)scNavigationItem {
    if (!_scNavigationItem) {
        _scNavigationItem = [[UINavigationItem alloc] init];
    }
    return _scNavigationItem;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUPUI];
}

/**
 * 设置界面
 */
- (void)setUPUI {

    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.scNavigationBar];
    self.scNavigationBar.items = @[self.scNavigationItem];

    // 背景颜色
    self.scNavigationBar.backgroundColor = [UIColor redColor];
    UIView* topView = [[UIView alloc]  init];
    topView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.equalTo(@(kNavBarHeight-44));
    }];
    if (@available(iOS 11.0, *)) {
        topView.hidden = false;
    }else{
        topView.hidden = true;
    }
    
    self.baseTopView = topView;
    
    [self setupNavigationBar];
    
    [self.view addSubview:self.reminderBtn];
    if (CGRectGetMaxY(self.reminderBtnFrame) > 0.0) {
        self.reminderBtn.frame = self.reminderBtnFrame;
    }else{
        self.reminderBtn.frame = CGRectMake(0, self.scNavigationBar.height,kScreenWidth, kScreenHeight-self.scNavigationBar.height);
    }
    
    if ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus == AFNetworkReachabilityStatusNotReachable) {
//        self.reminderBtn.hidden = false;
    }
}

- (void)setupNavigationBar {
    
    //TODO: - Test
//    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((ScreenWidth - ScreenWidth * 0.5) * 0.5, 0, ScreenWidth * 0.5, 20)];
//    imageView.image = [UIImage imageNamed:@"邀请码-文字"];
//    self.scNavigationItem.titleView = imageView;
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

- (void)setLeftNavBarItemWithImage:(NSString *)imageName
{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(leftItemClick:) forControlEvents:UIControlEventTouchUpInside];
    button.adjustsImageWhenHighlighted = YES;
    [button sizeToFit];
    UIBarButtonItem* leftItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.scNavigationItem.leftBarButtonItem = leftItem;
    
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
    self.scNavigationItem.rightBarButtonItem = rightItem;
}

- (void)setRightNavBarItemWithImage:(NSString *)imageName {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(rightItemClick:) forControlEvents:UIControlEventTouchUpInside];
    button.adjustsImageWhenHighlighted = YES;
    [button sizeToFit];
    UIBarButtonItem* rightItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.scNavigationItem.rightBarButtonItem = rightItem;
    
}


- (void)leftItemClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)rightItemClick:(UIButton *)sender {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
//    [[SDWebImageManager sharedManager] cancelAll];
//    [[SDImageCache sharedImageCache] clearMemory];
}

- (UIButton *)reminderBtn{
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
- (void)reminderBtnClicked{
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
- (void)reLoadVCData{
    
}


- (void)adjustmentReminderBtnFrame:(CGRect)frame{
    self.reminderBtnFrame = frame;
}

@end
