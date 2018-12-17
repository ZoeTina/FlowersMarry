//
//  FMComboListDetailsViewController.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/10/30.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMComboListDetailsViewController.h"
#import "MVPanGestureRecognizer.h"
#import "FMComboListDetailHeaderView.h"
#import "FMCustomTaskViewController.h"

#import "FMComboListDetailHeaderView.h"
#import "FMComboListDetailLeftViewController.h"
#import "FMComboListDetailRightViewController.h"

#import "FMFiveCellModel.h"

#import "FMActivityDetailsFooterView.h"

static CGFloat const kWMMenuViewHeight = 44.0;

@interface FMComboListDetailsViewController ()<UIGestureRecognizerDelegate,FMPopupViewDelegate>
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) MVPanGestureRecognizer *panGesture;
@property (nonatomic, assign) CGPoint lastPoint;
@property (nonatomic, strong) FMComboListDetailHeaderView *headerView;
@property (nonatomic, assign) CGFloat viewTop;

@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, assign) NSInteger pageSize;
/// 套餐详情
@property (nonatomic, strong) BusinessTaoxiModel *taoxiModel;

/// 底部工具栏
@property (nonatomic, strong) FMActivityDetailsFooterView *footerView;

@property (nonatomic, strong) FMComboListDetailLeftViewController *left_vc;
@property (nonatomic, strong) FMComboListDetailRightViewController *right_vc;

@end

@implementation FMComboListDetailsViewController

- (void)setTaoxiDataModel:(BusinessTaoxiModel *)taoxiDataModel{
    _taoxiDataModel = taoxiDataModel;    
    self.pageSize = 20;
    self.pageIndex = 1;
    [self loadCombinationDataRequest];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.headerView];
    self.panGesture = [[MVPanGestureRecognizer alloc] initWithTarget:self action:@selector(panOnView:)];
    [self.view addGestureRecognizer:self.panGesture];
    
    [self.view addSubview:self.headerView];
    FMActivityDetailsFooterView *view = [[FMActivityDetailsFooterView alloc] init];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(@(50));
    }];
    
    MV(weakSelf)
    view.block = ^(NSInteger idx) {
        [weakSelf handleButtonEvents:idx];
    };
    TTLog(@"222222");
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setupNavigationBarTheme];
    self.lz_fullScreenPopGestureEnabled = NO;
//    self.tx_id = @"347495";
    TTLog(@"333333");
}

- (void) handleButtonEvents:(NSInteger)idx{
    /// 100:评论按钮 101:点赞按钮 102:客服按钮 103:预约按钮
    switch (idx) {
        case 100:
            [self lz_make:@"客服"];
            break;
        case 101:
            [self.footerView didClickGuanZhu:self.taoxiDataModel.cp_id];
            break;
        case 102:
            [self.navigationController popViewControllerAnimated:YES];
            break;
        case 103:
            [self loadConventionRequest:@"1"];
            break;
        default:
            break;
    }
}


/// 预约商家或者领劵和优惠
- (void) loadConventionRequest:(NSString *)type{
    [MBProgressHUD showMessage:@"" toView:kKeyWindow];
    /// 类型  1:预约看店,3:优惠领取,10:客服,11:动态信息
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setObject:self.taoxiDataModel.cp_id forKey:@"cp_id"];
    [parameter setObject:kUserInfo.mobile forKey:@"mobile"];
    [parameter setObject:type forKey:@"type"];
    TTLog(@"parameter --- %@",parameter);
    [SCHttpTools getWithURLString:businessBooking parameter:parameter success:^(id responseObject) {
        NSDictionary *result = responseObject;
        if ([result isKindOfClass:[NSDictionary class]]) {
            FMGeneralModel *genralModel = [FMGeneralModel mj_objectWithKeyValues:result];
            if (genralModel.errcode == 0) {
                BusinessYouHuiModel *preModel = [BusinessYouHuiModel mj_objectWithKeyValues:result[@"data"]];
                FMConventionViewController *vc = [[FMConventionViewController alloc] initYouHuiModelData:preModel];
                vc.delegate = self;
                [self presentPopupViewController:vc animationType:LZPopupViewAnimationFade];
            }else {
                Toast([result lz_objectForKey:@"message"]);
            }
        }
        [MBProgressHUD hideHUDForView:kKeyWindow];
    } failure:^(NSError *error) {
        TTLog(@" -- error -- %@",error);
        [MBProgressHUD hideHUDForView:kKeyWindow];
    }];
}

/// 获取套餐详情数据
- (void) loadCombinationDataRequest{
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setObject:self.taoxiDataModel.tx_id forKey:@"tx_id"];
    [parameter setObject:@"1" forKey:@"has_tx"];// 1=返回商家套餐3个
    [parameter setObject:@"1" forKey:@"has_yh"];// 1=返回商家优惠信息
    
    TTLog(@"parameter --- %@",parameter);
    [SCHttpTools getWithURLString:@"taoxi/info" parameter:parameter success:^(id responseObject) {
        NSDictionary *results = responseObject;
        TTLog(@"parameter --- %@",[Utils lz_dataWithJSONObject:results]);
        if ([results isKindOfClass:[NSDictionary class]]) {
            BusinessTaoxiModel *taoxiModel = [BusinessTaoxiModel mj_objectWithKeyValues:results[@"data"]];
            self.taoxiModel = taoxiModel;
            self.footerView.guanzhuButton.selected = [self.taoxiModel.is_follow integerValue] ==0?YES:NO;
            self.headerView.taoxiModel = self.taoxiModel;
            self.left_vc.taoxiModel = self.taoxiModel;
        }
        [self.view dismissLoadingView];
    } failure:^(NSError *error) {
        TTLog(@"---- %@",error);
        [self.view dismissLoadingView];
    }];
}

- (NSArray *)dataArray {
    if (!_dataArray) {
        _dataArray = @[@"图文详情", @"套餐介绍"];
    }
    return _dataArray;
}

//static CGFloat const kWMHeaderViewHeight = 405;
static CGFloat const kNavigationBarHeight = 0;
#define kWMHeaderViewHeight IPHONE6_W(405)
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
//            TTLog(@"velocity: %lf", velocity.y);
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
    self.left_vc = [[FMComboListDetailLeftViewController alloc] init];
    self.right_vc = [[FMComboListDetailRightViewController alloc] init];

    if (index==0) {
        return self.left_vc;
    }else{
        self.right_vc.taoxiModel = self.taoxiModel;
        return self.right_vc;
    }
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
    
    [self.navigationController.navigationBar setBackgroundImage:[imageColor(kWhiteColor) resizableImageWithCapInsets:UIEdgeInsetsMake(5, 1, 5, 1)] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.tintColor = kTextColor51;
    //去掉导航栏下边的投影
    self.navigationController.navigationBar.shadowImage = [[UIImage lz_imageWithColor:HexString(@"#DDDDDD")] resizableImageWithCapInsets:UIEdgeInsetsMake(1, 1, 1, 1)];
    
    self.navigationController.navigationBar.barTintColor = kNavigationColorNormal;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:kTextColor51};
    self.navigationController.navigationBar.translucent = NO;// NavigationBar 是否透明
    self.navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
}

- (FMComboListDetailHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[FMComboListDetailHeaderView alloc] init];
        _headerView.frame = CGRectMake(0, kNavigationBarHeight, kScreenWidth, kWMHeaderViewHeight);
        _headerView.backgroundColor = kWhiteColor;
    }
    return _headerView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
