//
//  TTRootViewController.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/12/11.
//  Copyright © 2018 宁小陌. All rights reserved.
//

#import "TTRootViewController.h"
#import "FMHomePageHeaderView.h"
#import "FMSelectedCityViewController.h"
#import "FMSearchBusinessViewController.h"
#import "PYSearchViewController.h"
#import "FMHomePageSectionHeaderView.h"

#import "TTTemplateFirstTableViewCell.h"
#import "TTTemplateSecondTableViewCell.h"
#import "TTTemplateThreeTableViewCell.h"

#import "WMPageController.h"
#import "TTBaseTemplateTableView.h"
#import "TTTemplateChildViewController.h"
#import "FMTourismShootingViewController.h"
#import "SCVideoPlayViewController.h"

static NSString * const tt_reuseIdentifierFirst = @"TTTemplateFirstTableViewCell";
static NSString * const tt_reuseIdentifierSecond = @"TTTemplateSecondTableViewCell";
static NSString * const tt_reuseIdentifierThree = @"TTTemplateThreeTableViewCell";

@interface TTRootViewController ()<UITableViewDelegate,UITableViewDataSource,PYSearchViewControllerDelegate,
TTTemplateFirstTableViewCellDelegate,TTTemplateSecondTableViewCellDelegate,TTTemplateThreeTableViewCellDelegate,WMPageControllerDelegate>
@property (nonatomic, strong) FMHomePageHeaderView *homeHeaderView;
@property (nonatomic, strong) NSMutableDictionary *heightAtIndexPath;//缓存高度
@property (nonatomic, strong) NSMutableDictionary *heightSecondAtIndexPath;//缓存高度
@property (nonatomic, strong) TTBaseTemplateTableView *mainTableView;
@property (nonatomic, assign) BOOL canScroll;
@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) NSMutableArray *itemModelArray;

@end

static CGFloat const headViewHeight = 256;

@implementation TTRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initView];
    [self initViewConstraints];
//    [self.mainTableView addSubview:self.headImageView];
    self.canScroll = YES;
    [kNotificationCenter addObserver:self selector:@selector(MainTableScroll:) name:@"MainTableScroll" object:nil];
    // 注册通知
    [kNotificationCenter addObserver:self selector:@selector(receiveUpdateLocation:) name:@"NoticeCityHasUpdate" object:nil];
    [self getRecommendedVideoData];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)MainTableScroll:(NSNotification *)user{
    self.canScroll = YES;
}

- (void) receiveUpdateLocation:(NSNotification *)infoNotification{
    TTLog(@"当前城市：%@",kUserInfo.cityName);
    NSDictionary *dic = [infoNotification userInfo];
    NSString *cityName = [dic objectForKey:@"info"];
    self.homeHeaderView.cityLabel.text = cityName;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView==self.mainTableView) {
        CGFloat tabOffsetY = [self.mainTableView rectForSection:3].origin.y+10                                                                                                                                                         ;
        CGFloat offsetY = scrollView.contentOffset.y;
        if (offsetY>=tabOffsetY) {
            self.canScroll = NO;
            scrollView.contentOffset = CGPointMake(0, tabOffsetY);
            [[NSNotificationCenter defaultCenter] postNotificationName:@"childScrollCan" object:nil];
        }else{
            if (!self.canScroll) {
//                [scrollView setContentOffset:CGPointZero];
                [scrollView setContentOffset:CGPointMake(0, tabOffsetY)];
            }
        }
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void) initView{
    self.homeHeaderView.cityLabel.text = kUserInfo.cityName;
    [self.view addSubview:self.homeHeaderView];
    [Utils lz_setExtraCellLineHidden:self.mainTableView];
    [self.view addSubview:self.mainTableView];
}

#pragma mark ---- 约束布局
- (void) initViewConstraints{
    [self.homeHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(kLinerViewHeight));
        make.left.right.equalTo(self.view);
        make.height.equalTo(@(kNavBarHeight));
    }];
    
    [self.mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.homeHeaderView.mas_bottom);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(-kTabBarHeight);
    }];
    
}

- (void) sc_createSearchViewController{
    // 1.创建热门搜索
    NSArray *hotSeaches = @[@"拉斐婚纱", @"成都金夫人", @"成都古摄影", @"宝贝家族",@"帆.拉斐婚纱摄影",@"成都维纳斯",@"可乐加糖策划",@"记憶里摄影",@"甜蜜海岸旅拍",@"花笙摄影工作室"];
    // 2. 创建控制器
    PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:hotSeaches searchBarPlaceholder:NSLocalizedString(@"找商家", @"找商家") didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
        //这里添加了多线程，消除警告
        dispatch_after(0.2, dispatch_get_main_queue(), ^{
            // 开始搜索执行以下代码
            // 如：跳转到指定控制器
            // 通知关闭当前的View
            FMSearchBusinessViewController *vc = [[FMSearchBusinessViewController alloc] init];
            vc.keywords = searchText;
            [vc setHidesBottomBarWhenPushed:YES];
            [searchViewController.navigationController pushViewController:vc animated:YES];
        });
    }];
    // 3. 设置风格
    searchViewController.hotSearchStyle = PYHotSearchStyleDefault; // 热门搜索风格根据选择
    searchViewController.searchHistoryStyle = PYSearchHistoryStyleNormalTag; // 搜索历史风格为default
    
    // 4. 设置代理
    searchViewController.delegate = self;
    // 5. 跳转到搜索控制器
    LZNavigationController *nav = [[LZNavigationController alloc] initWithRootViewController:searchViewController];
    nav.navigationBar.tintColor = kColorWithRGB(211, 0, 0);
    [self presentViewController:nav  animated:NO completion:nil];
}

#pragma mark ----- tableView
#pragma mark - Table view data source
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        TTTemplateFirstTableViewCell* tools = [tableView dequeueReusableCellWithIdentifier:tt_reuseIdentifierFirst forIndexPath:indexPath];
        tools.delegate = self;
        tools.indexPath = indexPath;
        return tools;
    }else if(indexPath.section==1){
        TTTemplateSecondTableViewCell* tools = [tableView dequeueReusableCellWithIdentifier:tt_reuseIdentifierSecond forIndexPath:indexPath];
        tools.delegate = self;
        tools.indexPath = indexPath;
        return tools;
    }else if(indexPath.section == 2){
        TTTemplateThreeTableViewCell* tools = [tableView dequeueReusableCellWithIdentifier:tt_reuseIdentifierThree forIndexPath:indexPath];
        tools.dataArray = self.itemModelArray;
        tools.delegate = self;
        return tools;
    }else{
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        /* 添加pageView
         * 这里可以任意替换你喜欢的pageView
         *作者这里使用一款github较多人使用的 WMPageController 地址https://github.com/wangmchn/WMPageController
         */
        //        [cell.contentView addSubview:self.titleView];
        //        [cell.contentView addSubview:self.pageContentView];
        [cell.contentView addSubview:self.setPageViewControllers];
        cell.contentView.backgroundColor = kWhiteColor;
        return cell;
    }
}

#pragma mark -- 设置Header高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) return 0;
    return 10;
}

#pragma mark -- Section HearderView Title
// UITableView在Plain类型下，HeaderView和FooterView不悬浮和不停留的方法viewForHeaderInSection
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    SCBaseSectionHeaderView *sectionView = [[SCBaseSectionHeaderView alloc] init];
    sectionView.backgroundColor = kColorWithRGB(211, 0, 0);
    sectionView.section = section;
    sectionView.tableView = tableView;
    return sectionView;
}

// 多少个分组 section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

/// 返回多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        if (self.heightAtIndexPath[indexPath]) {
            NSNumber *num = self.heightAtIndexPath[indexPath];
            /// collectionView 底部还有七个像素
            TTLog(@"[num floatValue] --- %f",[num floatValue]);
            return [num floatValue];
        }else {
            return UITableViewAutomaticDimension;
        }

    }else if (indexPath.section==1){
        if (self.heightSecondAtIndexPath[indexPath]) {
            NSNumber *num = self.heightSecondAtIndexPath[indexPath];
            /// collectionView 底部还有七个像素
            //            return [num floatValue];
            TTLog(@"[num floatValue] --- %f",[num floatValue]);
        }else {
            //            return UITableViewAutomaticDimension;
        }
        return 223;
    }else if (indexPath.section==2){
        return 255;
    }else if (indexPath.section==3){
        return kScreenHeight;
    }else{
        return kScreenHeight;
    }
}


#pragma mark -- setter/getter
-(UIView *)setPageViewControllers {
    WMPageController *pageController = [self p_defaultController];
    pageController.titleFontName = @"PingFang-SC-Medium";
    pageController.titleSizeNormal = 14;  /// 默认字体大小
    pageController.titleSizeSelected = 16;/// 选中字体大小
    pageController.menuViewStyle = WMMenuViewStyleLine;/// 样式
    pageController.menuViewLayoutMode = WMMenuViewLayoutModeCenter;//居中模式
    pageController.menuItemWidth = kScreenWidth/5;/// 宽度
    pageController.titleColorSelected = HexString(@"#FF4163");
    pageController.titleColorNormal = kTextColor12;
    pageController.progressWidth = 20;
    pageController.progressColor = HexString(@"#FF4163");
    pageController.menuBGColor = kWhiteColor;
    [self addChildViewController:pageController];
    [pageController didMoveToParentViewController:self];
    
    
    UIView *linerView = [UIView lz_viewWithColor:kTextColor238];
    [pageController.view addSubview:linerView];
    linerView.frame = CGRectMake(0, pageController.menuHeight, kScreenWidth, 0.7);
    return pageController.view;
}

- (WMPageController *)p_defaultController {
    NSArray *titles = @[@"全部",@"婚纱摄影",@"婚礼策划",@"婚纱礼服"];
    NSMutableArray *viewControllers = [[NSMutableArray alloc] init];
    for (int i=0; i<titles.count; i++) {
        TTTemplateChildViewController *vc  = [TTTemplateChildViewController new];
        [viewControllers addObject:vc];
    }
    
    WMPageController *pageVC = [[WMPageController alloc] initWithViewControllerClasses:viewControllers andTheirTitles:titles];
    [pageVC setViewFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    pageVC.delegate = self;
    pageVC.menuHeight = 40;
    pageVC.postNotification = YES;
    pageVC.bounces = YES;
    return pageVC;
}

- (void)pageController:(WMPageController *)pageController willEnterViewController:(__kindof UIViewController *)viewController withInfo:(NSDictionary *)info {
    TTLog(@"%@",viewController);
}

/// 点击TableViewCell事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark ====== First ======
- (void)updateTableViewCellHeight:(TTTemplateFirstTableViewCell *)cell andheight:(CGFloat)height andIndexPath:(NSIndexPath *)indexPath {
    if (![self.heightAtIndexPath[indexPath] isEqualToNumber:@(height)]) {
        self.heightAtIndexPath[indexPath] = @(height);
        [self.mainTableView reloadData];
    }
}


#pragma mark ====== onClick Second Section 热门城市======
- (void)didHotCitySelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    FMTourismShootingViewController *vc = [[FMTourismShootingViewController alloc] initIndexPath:indexPath];
    TTPushVC(vc);
}

#pragma mark ====== onClick First Section 工具======
- (void)didToolsSelectItemAtIndexPath:(NSIndexPath *)indexPath withContent:(NSString *)content{
    Toast(content);
}

#pragma mark ====== onClick First Section 工具======
- (void)didRecommendVideoSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    DynamicModel *dynamicModel = self.itemModelArray[indexPath.row];
    SCVideoPlayViewController *vc = [[SCVideoPlayViewController alloc] initHomeDataModel:dynamicModel];
    TTPushVC(vc);
}

#pragma mark ====== Second Section======
- (void)updateSecondTableViewCellHeight:(TTTemplateSecondTableViewCell *)cell andheight:(CGFloat)height andIndexPath:(NSIndexPath *)indexPath {
    if (![self.heightSecondAtIndexPath[indexPath] isEqualToNumber:@(height)]) {
        self.heightSecondAtIndexPath[indexPath] = @(height);
        [self.mainTableView reloadData];
    }
}

#pragma mark ----- getter/setter
- (FMHomePageHeaderView *)homeHeaderView{
    if (!_homeHeaderView) {
        MV(weakSelf)
        _homeHeaderView = [[FMHomePageHeaderView alloc] init];
        [_homeHeaderView.cityLabel whenTapped:^{
            TTLog(@"单击事件");
            //            [weakSelf presentViewController:[[YMCitySelect alloc] initWithDelegate:weakSelf] animated:YES completion:nil];
            FMSelectedCityViewController *vc = [[FMSelectedCityViewController alloc] init];
            LZNavigationController *nav = [[LZNavigationController alloc] initWithRootViewController:vc];
//            [weakSelf.navigationController presentViewController:nav animated:YES completion:^{
//                TTLog(@"城市选择");
//            }];
        }];
        [_homeHeaderView.searchView whenTapped:^{
            TTLog(@"单击事件-----1");
            [weakSelf sc_createSearchViewController];
        }];
    }
    return _homeHeaderView;
}

- (NSMutableDictionary *)heightAtIndexPath {
    if (!_heightAtIndexPath) {
        _heightAtIndexPath = [[NSMutableDictionary alloc] init];
    }
    return _heightAtIndexPath;
}
- (NSMutableDictionary *)heightSecondAtIndexPath {
    if (!_heightSecondAtIndexPath) {
        _heightSecondAtIndexPath = [[NSMutableDictionary alloc] init];
    }
    return _heightSecondAtIndexPath;
}

- (TTBaseTemplateTableView *)mainTableView {
    if (!_mainTableView){
        _mainTableView= [[TTBaseTemplateTableView alloc]initWithFrame:CGRectMake(0,0,0,0)];
        
        _mainTableView.showsVerticalScrollIndicator = false;
        [_mainTableView registerClass:[TTTemplateFirstTableViewCell class] forCellReuseIdentifier:tt_reuseIdentifierFirst];
        [_mainTableView registerClass:[TTTemplateSecondTableViewCell class] forCellReuseIdentifier:tt_reuseIdentifierSecond];
        [_mainTableView registerClass:[TTTemplateThreeTableViewCell class] forCellReuseIdentifier:tt_reuseIdentifierThree];
        [_mainTableView setSeparatorInset:UIEdgeInsetsMake(0, 15, 0, 15)];
        //1 禁用系统自带的分割线
        _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _mainTableView.backgroundColor = kWhiteColor;
        _mainTableView.rowHeight = UITableViewAutomaticDimension;
        _mainTableView.delegate=self;
        _mainTableView.dataSource=self;
        _mainTableView.showsVerticalScrollIndicator = NO;
//        _mainTableView.contentInset = UIEdgeInsetsMake(headViewHeight,0, 0, 0);
//        _mainTableView.backgroundColor = [UIColor clearColor];
        _mainTableView.bounces = YES;
    }
    return _mainTableView;
}

-(UIImageView *)headImageView {
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg.jpg"]];
        _headImageView.frame = CGRectMake(0, -headViewHeight ,kScreenWidth,headViewHeight);
        _headImageView.userInteractionEnabled = YES;
    }
    return _headImageView;
}


- (NSMutableArray *)itemModelArray{
    if (!_itemModelArray) {
        _itemModelArray = [[NSMutableArray alloc] init];
    }
    return _itemModelArray;
}


#pragma 数据获取
/// 获取推荐视频数据
- (void) getRecommendedVideoData{
    
    TTLog(@"获取推荐视频数据 --- %@",kUserInfo.site_id);
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setObject:kUserInfo.site_id forKey:@"site_id"];      // 小分类
    TTLog(@"parameter -- %@",parameter);
    [SCHttpTools getWithURLString:@"feed/getlist" parameter:parameter success:^(id responseObject) {
        NSDictionary *result = responseObject;
        if (result) {
            DynamicDataModel *dynamicModel = [DynamicDataModel mj_objectWithKeyValues:[result lz_objectForKey:@"data"]];
            self.itemModelArray = dynamicModel.list;
        }
        [self.mainTableView reloadData];
        [self.view dismissLoadingView];
    } failure:^(NSError *error) {
        [self.view dismissLoadingView];
    }];
}

@end

