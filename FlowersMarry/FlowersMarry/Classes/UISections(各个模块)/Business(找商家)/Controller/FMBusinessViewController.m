//
//  FMBusinessViewController.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/6/27.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMBusinessViewController.h"
#import "TTBusinessTableViewCell.h"
#import "FMToolsModel.h"
#import "FMTourismShootingViewController.h"
/// 商家首页
#import "FMMerchantsHomeViewController.h"
#import "SCDropDownMenuView.h"

#import "FMWorksListDetailsViewController.h"

#import "FMRegionModel.h"
#import "FMBusinessModel.h"
#import "FMChannelModel.h"
static NSString * const reuseIdentifier = @"TTBusinessTableViewCell";

@interface FMBusinessViewController ()<UITableViewDelegate,UITableViewDataSource,SCDropDownMenuViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *itemModelArray;
@property (nonatomic, strong) SCNoDataView *noDataView;

/// 大分类名称
@property (nonatomic, strong) NSMutableArray *maxNameArray;
/// 大分类ID
@property (nonatomic, strong) NSMutableArray *maxIdArray;
/// 小分类名称
@property (nonatomic, strong) NSMutableArray *smallNameArray;
/// 小分类ID
@property (nonatomic, strong) NSMutableArray *smallIdArray;
/// 区域名称ID
@property (nonatomic, strong) NSMutableArray *regionArray;
/// 区域ID编号
@property (nonatomic, strong) NSMutableArray *regionIdArray;

@property (nonatomic,strong) dispatch_group_t disGroup;

/// 婚纱:1 婚庆:2 婚宴:3
@property (nonatomic, copy) NSString *channel_id;
/// 分类ID
@property (nonatomic, copy) NSString *class_id;
/// 区域ID
@property (nonatomic, copy) NSString *regional_id;
/// 排序
@property (nonatomic, copy) NSString *sorting;
/// 每页多少数据
@property (nonatomic, assign) NSInteger pageSize;
/// 当前页
@property (nonatomic, assign) NSInteger pageIndex;

@end

@implementation FMBusinessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initView];
    // 婚纱:1 婚庆:2 婚宴:3
    self.channel_id = @"1";
    self.pageSize = 20;
    self.pageIndex = 1;
    self.regional_id = @"";
    self.class_id = @"";
    self.sorting = @"";
    
    [self.view showLoadingViewWithText:@"加载中..."];
    /// 获取筛选的数据
    [self getChannelDataRequest];
    /// 获取列表数据
    [self getListData];
    // 下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //将页码重新置为1
        self.pageIndex = 1;
        [self getListData];
    }];
    /// 上拉加载
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.pageIndex++;// 页码+1
        [self getListData];
        [self.tableView.mj_footer endRefreshing];
    }];
}

- (void)analysisData {
    if (self.itemModelArray.count == 0) {
        self.noDataView.hidden = NO;
    }else {
        self.noDataView.hidden = YES;
    }
}

/// 获取渠道数据
- (void) getChannelDataRequest{
    
    //信号量
    //创建全局并行
    self.disGroup = dispatch_group_create();
    dispatch_queue_t mainqueue = dispatch_get_main_queue();

    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_enter(self.disGroup);
    dispatch_group_enter(self.disGroup);
    //网络请求一
    dispatch_group_async(self.disGroup, queue, ^{
        [self getGroupChannelData];
    });
    //网络请求二
    dispatch_group_async(self.disGroup, queue, ^{
        [self loadRegionData];
    });
    
    
    dispatch_group_notify(self.disGroup, mainqueue, ^{
//            NSMutableArray *array1 = [NSMutableArray arrayWithObjects:@"婚纱摄影", @"婚礼策划", @"婚纱礼服", @"婚宴酒店", nil];
//            NSMutableArray *array2 = [NSMutableArray arrayWithObjects:@"全城", @"成都市", @"达州市", @"绵阳市", @"南充市", @"自贡市", @"巴中市", @"攀枝花", nil];
        NSMutableArray *array3 = [NSMutableArray arrayWithObjects:@"综合排序", @"保障最好", @"作品最多", @"人气最高", nil];
//            NSArray *array11 = @[@[@"婚纱影楼",@"摄影工作室", @"儿童摄影"],@[@"婚礼策划"],@[@"婚纱礼服"],@[@"婚宴酒店"]];
//            NSArray *array11 = @[@[@"婚纱影楼",@"摄影工作室",@"儿童摄影"], @[@"婚礼策划",@"婚纱礼服",@"新娘跟妆",@"婚礼跟拍",@"婚礼司仪"],
//                                 @[@"五星级酒店",@"四星级酒店",@"三星级酒店",@"二星级酒店",@"特色餐厅",@"主题会所"]];
        NSMutableArray *data1 = [NSMutableArray arrayWithObjects:self.maxNameArray, self.regionArray, array3, nil];
        NSMutableArray *data2 = [NSMutableArray arrayWithObjects:self.smallNameArray, @[], @[], @[], nil];
        SCDropDownMenuView *menu = [[SCDropDownMenuView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 40) firstArray:data1 secondArray:data2];
        menu.delegate = self;
        menu.separatorColor = kColorWithRGB(221, 221, 221);
        menu.bottomLineView.hidden = YES;
        menu.cellSelectBackgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
        menu.ratioLeftToScreen = 0.35;
        [self.view addSubview:menu];
        /*风格*/
        menu.menuStyleArray = [NSMutableArray arrayWithObjects:[NSNumber numberWithInteger:SCDropDownMenuStyleTableView],
                               [NSNumber numberWithInteger:SCDropDownMenuStyleTableView],
                               [NSNumber numberWithInteger:SCDropDownMenuStyleTableView], nil];

    });
}

- (void) getGroupChannelData{
    [SCHttpTools getWithURLString:@"datasource/channels" parameter:nil success:^(id responseObject) {
        if (responseObject) {
            FMChannelModel *channelModel = [FMChannelModel mj_objectWithKeyValues:responseObject];
            /// 添加数据到可变数组
            /// 得到大分类名称和channel_id
            for (ChannelModel *model in channelModel.data) {
                [self.maxNameArray addObject:model.name];
                [self.maxIdArray addObject:model.channel_id];
                
                NSMutableArray *dataNameArray = [[NSMutableArray alloc] init];
                NSMutableArray *dataIdArray = [[NSMutableArray alloc] init];
                for (ChannelChild *md in model.child) {
                    /// 得到消费分类名称和class_id
                    [dataNameArray addObject:md.class_name];
                    [dataIdArray addObject:md.class_id];
                }
                [self.smallNameArray addObject:dataNameArray];
                [self.smallIdArray addObject:dataIdArray];
            }
            dispatch_group_leave(self.disGroup);
        }
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
    }];
}

- (void) loadRegionData{
    NSDictionary *parameter = @{@"site_id":kUserInfo.site_id,@"city_id":kUserInfo.city_id};
    [SCHttpTools getWithURLString:@"datasource/qu" parameter:parameter success:^(id responseObject) {
        if (responseObject) {
            FMRegionModel *regionModel = [FMRegionModel mj_objectWithKeyValues:responseObject];
            // 添加数据到可变数组
            [self.regionArray addObject:@"全城"];
            for (RegionModel *model in regionModel.data) {
                [self.regionArray addObject:model.name];
                [self.regionIdArray addObject:model.cid];
            }
            dispatch_group_leave(self.disGroup);
        }
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
    }];
}

- (void) getListData{
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setObject:kUserInfo.site_id forKey:@"site_id"];   // 站点
    [parameter setObject:self.channel_id forKey:@"channel_id"];  // 1:婚纱 2:婚庆 3:婚宴
    [parameter setObject:self.class_id forKey:@"class_id"];      // 小分类
    [parameter setObject:@(self.pageIndex) forKey:@"p"];         // 当前页
    [parameter setObject:@(self.pageSize) forKey:@"size"];       // 每页条数
    [parameter setObject:self.regional_id forKey:@"qu_id"];      // 区域
    [parameter setObject:self.sorting forKey:@"order"];          // 排序
    [parameter setObject:@"1" forKey:@"has_case"];               // 是否有作品
    [parameter setObject:@"1" forKey:@"has_hd"];                 // 是否有活动
    TTLog(@"parameter -- %@",parameter);
    [SCHttpTools getWithURLString:@"company/getlist" parameter:parameter success:^(id responseObject) {
        if (responseObject) {
            FMBusinessModel *businessModel = [FMBusinessModel mj_objectWithKeyValues:responseObject];
            if (self.pageIndex == 1) {
                [self.itemModelArray removeAllObjects];
            }
            [self.itemModelArray addObjectsFromArray:businessModel.data.list];
        }
        [self analysisData];
        [self.tableView reloadData];
        [self.tableView.mj_header endRefreshing];
        [self.view dismissLoadingView];
    } failure:^(NSError *error) {
        [self.tableView.mj_header endRefreshing];
        [self.view dismissLoadingView];
    }];
}

//点击UICollectionViewCell的代理方法
- (void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath withCasesModel:(BusinessCasesModel *)model {
    BusinessModel *businessModel = self.itemModelArray[indexPath.row];
    FMWorksListDetailsViewController *vc = [[FMWorksListDetailsViewController alloc] init];
    model.cp_id = businessModel.cp_id;
    vc.casesDadaModel = model;
    TTPushVC(vc);
}

- (void)menuView:(SCDropDownMenuView *)menu selectIndex:(SCIndexPatch *)index {
    TTLog(@"商家首页 - index.row: %ld  index.column：%ld index.section： %ld", index.row,index.column,index.section);
    if (index.column==0) {
        self.class_id = self.smallIdArray[index.section][index.column];
        self.channel_id = self.maxIdArray[index.section];
        TTLog(@"元数据 ----- %@ \n self.channel_id --- %@",self.smallIdArray,self.channel_id);
    }else if (index.column==1) {
        if (index.section==0) {
            self.regional_id = @"";
        }else{
            self.regional_id = self.regionIdArray[index.section-1];
        }
    }else if(index.column==2){
        if (index.section==0) {
            self.sorting = @"";             /// 综合排序
        }else if (index.section==1) {
            self.sorting = @"xb";           /// 保障最好
        }else if (index.section==2) {
            self.sorting = @"casenum";      /// 作品最多
        }else if (index.section==3) {
            self.sorting = @"hits";         /// 人气最高
        }
    }
    [self getListData];
}

- (void)menuView:(SCDropDownMenuView *)menu tfColumn:(NSInteger)column {
//    TTLog(@"商家首页-- 点击的第几项 - column: %ld", column);
}

- (void) initView{
    [Utils lz_setExtraCellLineHidden:self.tableView];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(40));
        make.left.right.equalTo(@(0));
        make.bottom.equalTo(self.view.mas_bottom).offset(-kTabBarHeight);
    }];
}

#pragma mark - Table view data source
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TTBusinessTableViewCell* tools = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    BusinessModel *businessModel = self.itemModelArray[indexPath.section];
    tools.businessModel = businessModel;
    return tools;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    BusinessModel *businessModel = self.itemModelArray[indexPath.section];
    if (businessModel.youhui_num==0&&kObjectIsEmpty(businessModel.huodong)) {
        return IPHONE6_W(95);
    }else if (kObjectIsEmpty(businessModel.huodong)){
        return IPHONE6_W(115);
    }else if(businessModel.youhui_num==0){
        return IPHONE6_W(130);
    }
    return IPHONE6_W(150);
}

#pragma mark -- 设置Header高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 7;
}

#pragma mark -- Section HearderView Title
// UITableView在Plain类型下，HeaderView和FooterView不悬浮和不停留的方法viewForHeaderInSection
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    SCBaseSectionHeaderView *sectionView = [[SCBaseSectionHeaderView alloc] init];
    sectionView.section = section;
    sectionView.tableView = tableView;
    return sectionView;
}

// 多少个分组 section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.itemModelArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BusinessModel *businessModel = self.itemModelArray[indexPath.section];
    FMMerchantsHomeViewController *vc = [[FMMerchantsHomeViewController alloc] initBusinessModel:businessModel];
    TTPushVC(vc);
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.showsVerticalScrollIndicator = false;
        [_tableView registerClass:[TTBusinessTableViewCell class] forCellReuseIdentifier:reuseIdentifier];
        [_tableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = kViewColorNormal;
    }
    return _tableView;
}

- (NSMutableArray *)itemModelArray{
    if (!_itemModelArray) {
        _itemModelArray = [[NSMutableArray alloc] init];
    }
    return _itemModelArray;
}

- (SCNoDataView *)noDataView {
    if (!_noDataView) {
        _noDataView = [[SCNoDataView alloc] initWithFrame:self.view.bounds
                                                imageName:@"live_k_guanzhu"
                                            tipsLabelText:@"没有相关商家哦~"];
        _noDataView.userInteractionEnabled = YES;
        [self.view insertSubview:_noDataView aboveSubview:self.tableView];
        [self.noDataView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_offset(0);
            make.centerY.mas_equalTo(self.view.mas_centerY);
            make.height.mas_equalTo(150);
        }];
    }
    return _noDataView;
}


- (NSMutableArray *)maxNameArray{
    if (!_maxNameArray) {
        _maxNameArray = [[NSMutableArray alloc] init];
    }
    return _maxNameArray;
}

- (NSMutableArray *)maxIdArray{
    if (!_maxIdArray) {
        _maxIdArray = [[NSMutableArray alloc] init];
    }
    return _maxIdArray;
}

- (NSMutableArray *)smallNameArray{
    if (!_smallNameArray) {
        _smallNameArray = [[NSMutableArray alloc] init];
    }
    return _smallNameArray;
}

- (NSMutableArray *)smallIdArray{
    if (!_smallIdArray) {
        _smallIdArray = [[NSMutableArray alloc] init];
    }
    return _smallIdArray;
}

- (NSMutableArray *)regionArray{
    if (!_regionArray) {
        _regionArray = [[NSMutableArray alloc] init];
    }
    return _regionArray;
}

- (NSMutableArray *)regionIdArray{
    if (!_regionIdArray) {
        _regionIdArray = [[NSMutableArray alloc] init];
    }
    return _regionIdArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
