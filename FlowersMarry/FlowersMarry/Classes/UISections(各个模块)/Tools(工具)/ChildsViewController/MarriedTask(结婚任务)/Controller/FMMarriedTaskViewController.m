//
//  FMMarriedTaskViewController.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/9/26.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMMarriedTaskViewController.h"
#import "MVPanGestureRecognizer.h"
#import "FMMarriedTaskHeaderView.h"
#import "FMCustomTaskViewController.h"
static CGFloat const kWMMenuViewHeight = 44.0;

@interface FMMarriedTaskViewController ()<UIGestureRecognizerDelegate>
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) MVPanGestureRecognizer *panGesture;
@property (nonatomic, assign) CGPoint lastPoint;
@property (nonatomic, strong) FMMarriedTaskHeaderView *headerView;
@property (nonatomic, strong) UIButton *addButton;

@end

@implementation FMMarriedTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.headerView.progressView.progressValue = 7.0/40.0;
    self.headerView.totalCountLabel.text = @"7/40";
    [self.headerView.invitationButton lz_handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        Toast(@"去邀请");
    }];
    [self.view addSubview:self.headerView];
    self.panGesture = [[MVPanGestureRecognizer alloc] initWithTarget:self action:@selector(panOnView:)];
    [self.view addGestureRecognizer:self.panGesture];
    
    [self.view addSubview:self.addButton];
    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(-26);
    }];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setupNavigationBarTheme];
    self.title = @"结婚任务";
}

- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = @[@"自定任务", @"常规任务", @"已经完成"];
    }
    return _dataArray;
}

- (instancetype)init {
    if (self = [super init]) {
        self.titleFontName = @"PingFang-SC-Medium";
        self.titleSizeNormal = 14;  /// 默认字体大小
        self.titleSizeSelected = 14;/// 选中字体大小
        self.menuViewStyle = WMMenuViewStyleLine;/// 样式
        self.menuViewLayoutMode = WMMenuViewLayoutModeCenter;
        self.viewTop = kNavigationBarHeight + kWMHeaderViewHeight;
        self.titleColorSelected = kColorWithRGB(51, 51, 51);
        self.titleColorNormal = kColorWithRGB(102, 102, 102);
        self.progressColor = HexString(@"#FF4163");
        self.progressWidth = 15;
        self.progressHeight = 2;
        self.menuItemWidth = 88;/// 宽度
    }
    return self;
}

- (void)panOnView:(MVPanGestureRecognizer *)recognizer {
    CGPoint currentPoint = [recognizer locationInView:self.view];
    
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        self.lastPoint = currentPoint;
    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
        CGPoint velocity = [recognizer velocityInView:self.view];
        CGFloat targetPoint = velocity.y < 0 ? kNavigationBarHeight : kNavigationBarHeight + kWMHeaderViewHeight;
        NSTimeInterval duration = fabs((targetPoint - self.viewTop) / velocity.y);
        
        if (fabs(velocity.y) * 1.0 > fabs(targetPoint - self.viewTop)) {
            TTLog(@"velocity: %lf", velocity.y);
            [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
                self.viewTop = targetPoint;
            } completion:nil];
            return;
        }
    }
    CGFloat yChange = currentPoint.y - self.lastPoint.y;
    
    self.viewTop += yChange;
    self.lastPoint = currentPoint;
}

// MARK: ChangeViewFrame (Animatable)
- (void)setViewTop:(CGFloat)viewTop {
    _viewTop = viewTop;
    
    if (_viewTop <= kNavigationBarHeight) {
        _viewTop = kNavigationBarHeight;
    }
    
    if (_viewTop > kWMHeaderViewHeight + kNavigationBarHeight) {
        _viewTop = kWMHeaderViewHeight + kNavigationBarHeight;
    }
    
    self.headerView.frame = ({
        CGRect oriFrame = self.headerView.frame;
        oriFrame.origin.y = _viewTop - kWMHeaderViewHeight;
        oriFrame;
    });
    
//    [self forceLayoutSubviews];
}

#pragma mark - Datasource & Delegate
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return self.dataArray.count;
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    FMCustomTaskViewController *vc = [[FMCustomTaskViewController alloc] init];
    return vc;
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    return self.dataArray[index];
}

/// 自定义 MenuView 框架
- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
    return CGRectMake(0, _viewTop, kScreenWidth, kWMMenuViewHeight);
}

#pragma mark - MVPageControllerDataSource -- (必须实现)
- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    CGFloat originY = _viewTop + kWMMenuViewHeight;
    return CGRectMake(0, originY, self.view.width, self.view.height - originY);
}

- (CGFloat)menuView:(WMMenuView *)menu widthForItemAtIndex:(NSInteger)index {
    CGFloat width = [super menuView:menu widthForItemAtIndex:index];
    return width;
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
    self.navigationController.navigationBar.translucent = NO;// NavigationBar 是否透明
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
}

- (FMMarriedTaskHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[FMMarriedTaskHeaderView alloc] init];
        _headerView.frame = CGRectMake(0, kNavigationBarHeight, kScreenWidth, kWMHeaderViewHeight);
        _headerView.backgroundColor = HexString(@"#FF4163");
    }
    return _headerView;
}

- (UIButton *)addButton{
    if (!_addButton) {
        _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addButton setImage:kGetImage(@"tools_task_btn_add") forState:UIControlStateNormal];
    }
    return _addButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
