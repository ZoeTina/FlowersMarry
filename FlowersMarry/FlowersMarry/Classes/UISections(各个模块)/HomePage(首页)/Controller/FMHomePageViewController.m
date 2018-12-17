//
//  FMHomePageViewController.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/6/27.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMHomePageViewController.h"

/// 显示图片集
#import "FMShowPhotoCollectionViewController.h"
/// 图文详情
#import "FMPictureWithTextViewController.h"
/// 商家首页
#import "FMMerchantsHomeViewController.h"

/// 三亚
#import "FMTourismShootingViewController.h"
/// 全球旅拍
#import "FMTravelTableViewCell.h"

#import "FMVideoTableViewCell.h"
#import "FMImagesTableViewCell.h"
#import "FMMoreImagesTableViewCell.h"
#import "FMImagesRightTableViewCell.h"
#import "FMImagesTransverseThreeTableViewCell.h"

#import "YMCitySelect.h"
/// 搜索页面
#import "PYSearchViewController.h"
#import "FMConsumerProtectionViewController.h"
#import "FMHomePageSectionHeaderView.h"
#import "FMHomePageHeaderView.h"
#import "FMSelectedCityViewController.h"

#import "SCVideoPlayViewController.h"

#import "FMSearchBusinessViewController.h"

static NSString * const reuseIdentifierTravel = @"FMTravelTableViewCell";

static NSString * const reuseIdentifierVideo = @"FMVideoTableViewCell";
static NSString * const reuseIdentifierImage = @"FMImagesTableViewCell";
static NSString * const reuseIdentifierMoreImage = @"FMMoreImagesTableViewCell";
static NSString * const reuseIdentifierRightImage = @"FMImagesRightTableViewCell";
static NSString * const reuseIdentifierThreeImage = @"FMImagesTransverseThreeTableViewCell";

@interface FMHomePageViewController ()<UITableViewDelegate,UITableViewDataSource,PYSearchViewControllerDelegate,FMTravelTableViewCellDelegate,YMCitySelectDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *itemModelArray;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) FMHomePageHeaderView *homeHeaderView;
/// 0:推荐 1:关注
@property (nonatomic, assign) NSInteger pageType;

@property (nonatomic, strong) NSMutableDictionary *heightAtIndexPath;//缓存高度
/// 当前页
@property (nonatomic,assign) NSInteger pageIndex;
/// 每页多少条数据
@property (nonatomic,assign) NSInteger pageSize;
@end

@implementation FMHomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.pageSize = 20;
    self.pageIndex = 1;
    self.pageType = 0;
    [self initView];
    [self.view showLoadingViewWithText:@""];
    [self getDataRequest];
    [self initViewConstraints];
    // 注册通知
    [kNotificationCenter addObserver:self selector:@selector(updateLocation) name:@"NoticeCityHasUpdate" object:nil];
    
    /// 上拉加载
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.pageIndex++;// 页码+1
        [self getDataRequest];
        [self.tableView.mj_footer endRefreshing];
    }];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void) updateLocation{
    NSString* localityName = [kUserDefaults objectForKey:@"locality"];
    
    if ([localityName isEqualToString:@"定位失败"]) {
        [self lz_make:[NSString stringWithFormat:@"请手动选择"]];
    }else{
        self.homeHeaderView.cityLabel.text = localityName;
    }
    self.homeHeaderView.cityLabel.text = kUserInfo.cityName;
}

/// 获取首页的数据
- (void) getDataRequest{
    
    NSString *URLString = (self.pageType==0)?@"feed/getlist":@"feed/fllowfeedlist";
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setObject:kUserInfo.site_id forKey:@"site_id"];
    [parameter setObject:@(self.pageSize) forKey:@"size"];
    [parameter setObject:@(self.pageIndex) forKey:@"p"];
    [SCHttpTools getWithURLString:URLString parameter:parameter success:^(id responseObject) {
        NSDictionary *result = responseObject;
        if ([result isKindOfClass:[NSDictionary class]]) {
            FMDynamicModel *model = [FMDynamicModel mj_objectWithKeyValues:result];
            if (model.errcode == 0) {
                [self.itemModelArray removeAllObjects];
                [self.itemModelArray addObjectsFromArray:model.data.list];
            }else {
                Toast([result lz_objectForKey:@"message"]);
            }
        }
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.view dismissLoadingView];
    } failure:^(NSError *error) {
        TTLog(@" -- error -- %@",error);
        [self.tableView.mj_header endRefreshing];
        [self.view dismissLoadingView];
    }];
}


/// 选择的城市
- (void)ym_ymCitySelectCityName:(NSString *)cityName {
    TTLog(@"------ %@",cityName);
    self.homeHeaderView.cityLabel.text = cityName;
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

- (void) initView{
    self.homeHeaderView.cityLabel.text = kUserInfo.cityName;
    [self.view addSubview:self.homeHeaderView];
    [Utils lz_setExtraCellLineHidden:self.tableView];
    [self.view addSubview:self.tableView];
}

#pragma mark - Table view data source
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        FMTravelTableViewCell* tools = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierTravel forIndexPath:indexPath];
        tools.delegate = self;
        tools.indexPath = indexPath;
        tools.dataArray = self.dataArray;
        return tools;
    }else{
        DynamicModel *dynamicModel = self.itemModelArray[indexPath.row];
        switch (dynamicModel.shape) {
            case 1: {/// 图文
                if (dynamicModel.thumb_num==1) {/// 图文  ---  1:一张封面图
                    FMImagesRightTableViewCell* tools = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierRightImage forIndexPath:indexPath];
//                    [tools.imagesView sd_setShowActivityIndicatorView:YES];
//                    [tools.imagesView sd_setIndicatorStyle:UIActivityIndicatorViewStyleGray];
                    tools.dynamicModel = dynamicModel;
                    return tools;
                }else{
                    FMImagesTransverseThreeTableViewCell* tools = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierThreeImage forIndexPath:indexPath];
                    tools.dynamicModel = dynamicModel;
                    return tools;
                }
            }
                break;
            case 2: {/// 图集  ---  1:一张封面图
                if (dynamicModel.thumb_num==1) {
                    FMImagesTableViewCell* tools = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierImage forIndexPath:indexPath];
                    tools.dynamicModel = dynamicModel;
                    return tools;
                }else{
                    FMMoreImagesTableViewCell* tools = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierMoreImage forIndexPath:indexPath];
                    tools.dynamicModel = dynamicModel;
                    return tools;
                }
            }
            case 3: {/// 视频
                FMVideoTableViewCell* tools = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierVideo forIndexPath:indexPath];
                tools.dynamicModel = dynamicModel;
                return tools;
            }
        }
        return [UITableViewCell new];
    }
}

// 多少个分组 section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

/// 返回多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) return 1;
    return self.itemModelArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.heightAtIndexPath[indexPath]) {
        NSNumber *num = self.heightAtIndexPath[indexPath];
        /// collectionView 底部还有七个像素
        return [num floatValue]+7;
    } else {
        return UITableViewAutomaticDimension;
    }
}

/// 点击TableViewCell事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DynamicModel *dynamicModel = self.itemModelArray[indexPath.row];
    switch (dynamicModel.shape) {
        case 1:/// 图文
        {
            FMPictureWithTextViewController *vc = [[FMPictureWithTextViewController alloc] initHomeDataModel:dynamicModel];
            TTPushVC(vc);
        }
            break;
        case 2:/// 图集
        {
            FMShowPhotoCollectionViewController *vc = [[FMShowPhotoCollectionViewController alloc] initHomeDataModel:dynamicModel];
            TTPushVC(vc);
        }
            break;
        case 3:/// 视频
        {
            SCVideoPlayViewController *vc = [[SCVideoPlayViewController alloc] initHomeDataModel:dynamicModel];
            TTPushVC(vc);
        }
            break;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -- 设置Header高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return (section==0) ? 0 : 33;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return (section==0) ? 10 : 0;
}

#pragma mark -- Section HearderView Title
// UITableView在Plain类型下，HeaderView和FooterView不悬浮和不停留的方法
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    FMHomePageSectionHeaderView *sectionView = [[FMHomePageSectionHeaderView alloc] init];
    sectionView.backgroundColor = kWhiteColor;
    sectionView.frame = CGRectMake(0, 0, kScreenWidth, 33);
    MV(weakSelf)
    UIView *lv = [UIView lz_viewWithColor:kColorWithRGB(221, 221, 221)];
    [sectionView addSubview:lv];
    
    [lv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(sectionView);
        make.height.mas_equalTo(0.5);
    }];
    
    [sectionView.recommendButton lz_handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        [weakSelf getDataRequest];
        sectionView.recommendButton.selected = YES;
        sectionView.guanzhuButton.selected = NO;
        weakSelf.pageIndex = 1;
        weakSelf.pageType = 0;
    }];
    [sectionView.guanzhuButton lz_handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        [weakSelf getDataRequest];
        sectionView.recommendButton.selected = NO;
        sectionView.guanzhuButton.selected = YES;
        weakSelf.pageType = 1;
        weakSelf.pageIndex = 1;
    }];
    
    if (self.pageType==0) {
        sectionView.recommendButton.selected = YES;
    }else{
        sectionView.guanzhuButton.selected = YES;
    }
    return sectionView;
}

// UITableView在Plain类型下，HeaderView和FooterView不悬浮和不停留的方法
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView lz_viewWithColor:kTableViewInSectionColor];
}

#pragma mark ====== FMTravelTableViewCellDelegate ======
- (void)updateTableViewCellHeight:(FMTravelTableViewCell *)cell andheight:(CGFloat)height andIndexPath:(NSIndexPath *)indexPath {
    if (![self.heightAtIndexPath[indexPath] isEqualToNumber:@(height)]) {
        self.heightAtIndexPath[indexPath] = @(height);
        [self.tableView reloadData];
    }
}

//点击UICollectionViewCell的代理方法  ---- 热门城市 ----
- (void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    FMTourismShootingViewController *vc = [[FMTourismShootingViewController alloc] initIndexPath:indexPath];
    TTPushVC(vc);
}

#pragma mark ---- 约束布局
- (void) initViewConstraints{
    [self.homeHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(kLinerViewHeight));
        make.left.right.equalTo(self.view);
        make.height.equalTo(@(kNavBarHeight));
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.homeHeaderView.mas_bottom);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(-kTabBarHeight);
    }];
}
#pragma mark ----- getter/setter
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.showsVerticalScrollIndicator = false;
        [_tableView registerClass:[FMTravelTableViewCell class] forCellReuseIdentifier:reuseIdentifierTravel];
        [_tableView registerClass:[FMVideoTableViewCell class] forCellReuseIdentifier:reuseIdentifierVideo];
        [_tableView registerClass:[FMImagesTableViewCell class] forCellReuseIdentifier:reuseIdentifierImage];
        [_tableView registerClass:[FMMoreImagesTableViewCell class] forCellReuseIdentifier:reuseIdentifierMoreImage];
        [_tableView registerClass:[FMImagesRightTableViewCell class] forCellReuseIdentifier:reuseIdentifierRightImage];
        [_tableView registerClass:[FMImagesTransverseThreeTableViewCell class] forCellReuseIdentifier:reuseIdentifierThreeImage];
        [_tableView setSeparatorInset:UIEdgeInsetsMake(0, 15, 0, 15)];
        //1 禁用系统自带的分割线
        //        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = kViewColorNormal;
        _tableView.rowHeight = UITableViewAutomaticDimension;
    }
    return _tableView;
}

- (NSMutableArray *)itemModelArray{
    if (!_itemModelArray) {
        _itemModelArray = [[NSMutableArray alloc] init];
    }
    return _itemModelArray;
}

- (NSArray *)dataArray{
    if (!_dataArray) {
        _dataArray = @[@[@"三亚",@"大理"],@[@"厦门",@"丽江",@"大连",@"青岛"]];
    }
    return _dataArray;
}

- (FMHomePageHeaderView *)homeHeaderView{
    if (!_homeHeaderView) {
        MV(weakSelf)
        _homeHeaderView = [[FMHomePageHeaderView alloc] init];
        [_homeHeaderView.cityLabel whenTapped:^{
            TTLog(@"单击事件");
//            [weakSelf presentViewController:[[YMCitySelect alloc] initWithDelegate:weakSelf] animated:YES completion:nil];
            FMSelectedCityViewController *vc = [[FMSelectedCityViewController alloc] init];
            LZNavigationController *nav = [[LZNavigationController alloc] initWithRootViewController:vc];
            [weakSelf.navigationController presentViewController:nav animated:YES completion:^{
                TTLog(@"城市选择");
            }];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
