//
//  TTComboListViewController.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/12/13.
//  Copyright © 2018 宁小陌. All rights reserved.
//

#import "TTComboListViewController.h"
#import "FMComboListTableViewCell.h"
#import "FMComboListDetailsViewController.h"

static NSString * const reuseIdentifier = @"TTComboListViewController";

@interface TTComboListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *itemModelArray;
@property (nonatomic, strong) SCNoDataView *noDataView;
/// 每页多少数据
@property (nonatomic, assign) NSInteger pageSize;
/// 当前页
@property (nonatomic, assign) NSInteger pageIndex;

/// 商家首页套餐列表数据的套餐信息
@property (strong, nonatomic) BusinessModel *businessModel;
@end

@implementation TTComboListViewController
- (id)initBusinessModel:(BusinessModel *)businessModel{
    if ( self = [super init] ){
        self.businessModel = businessModel;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initView];
    self.pageSize = 20;
    self.pageIndex = 1;
    self.title = @"套餐列表";
    [self.view showLoadingViewWithText:@"加载中..."];
    /// 获取列表数据
    [self getComboListData];
    // 下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //将页码重新置为1
        self.pageIndex = 1;
        [self getComboListData];
    }];
    /// 上拉加载
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.pageIndex++;// 页码+1
        [self getComboListData];
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

/// 获取套餐列表数据
- (void) getComboListData{
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setObject:self.businessModel.cp_id forKey:@"cp_id"];      // 小分类
    [parameter setObject:@(self.pageIndex) forKey:@"p"];         // 当前页
    [parameter setObject:@(self.pageSize) forKey:@"size"];       // 每页条数
    TTLog(@"parameter -- %@",parameter);
    [SCHttpTools getWithURLString:@"taoxi/getlist" parameter:parameter success:^(id responseObject) {
        NSDictionary *result = responseObject;
        if (result) {
            if (self.pageIndex == 1) {
                [self.itemModelArray removeAllObjects];
            }
            BusinessTaoxiDataModel *taoxiData = [BusinessTaoxiDataModel mj_objectWithKeyValues:[result lz_objectForKey:@"data"]];
            [self.itemModelArray addObjectsFromArray:taoxiData.list];
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

- (void) initView{
    [Utils lz_setExtraCellLineHidden:self.tableView];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.equalTo(self.view);
    }];
}

#pragma mark - Table view data source
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FMComboListTableViewCell* tools = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    BusinessTaoxiModel *taoxiModel = self.itemModelArray[indexPath.row];
    tools.taoxiModel = taoxiModel;
    return tools;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return IPHONE6_W(137);
}

#pragma mark -- 设置Header高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.itemModelArray.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FMComboListDetailsViewController *vc = [[FMComboListDetailsViewController alloc] init];
    vc.taoxiDataModel = self.itemModelArray[indexPath.row];
    TTPushVC(vc);
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.showsVerticalScrollIndicator = false;
        [_tableView registerClass:[FMComboListTableViewCell class] forCellReuseIdentifier:reuseIdentifier];
        [_tableView setSeparatorInset:UIEdgeInsetsMake(0,IPHONE6_W(180),0,0)];
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
                                            tipsLabelText:@"没有相关套餐哦~"];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
