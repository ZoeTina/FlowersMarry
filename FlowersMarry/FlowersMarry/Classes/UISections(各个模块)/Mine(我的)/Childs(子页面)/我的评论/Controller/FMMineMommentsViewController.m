//
//  FMMineMommentsViewController.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/16.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMMineMommentsViewController.h"
#import "FMMineMommentsTableViewCell.h"
#import "FMMineCommentsModel.h"

static NSString * const reuseIdentifier = @"FMMineMommentsTableViewCell";
@interface FMMineMommentsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) SCNoDataView *noDataView;
/// 每页多少数据
@property (nonatomic, assign) NSInteger pageSize;
/// 当前页
@property (nonatomic, assign) NSInteger pageIndex;
@end

@implementation FMMineMommentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initView];
    self.pageIndex = 1;
    self.pageSize = 20;
    [self getDataRequest];
}

- (void) initView{
    
    [Utils lz_setExtraCellLineHidden:self.tableView];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(kLinerViewHeight));
        make.left.bottom.right.equalTo(self.view);
    }];
    [self.view showLoadingViewWithText:@"加载中..."];
    
    // 下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //将页码重新置为1
        self.pageIndex = 1;
        [self getDataRequest];
    }];
    /// 上拉加载
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.pageIndex++;// 页码+1
        [self getDataRequest];
        [self.tableView.mj_footer endRefreshing];
    }];
}

- (void)analysisData {
    if (self.dataArray.count == 0) {
        self.noDataView.hidden = NO;
    }else {
        self.noDataView.hidden = YES;
    }
}

/// 获取我的评论
- (void) getDataRequest{
    
    NSDictionary *parameter = @{@"size":@(self.pageSize),@"p":@(self.pageIndex)};
    [SCHttpTools getWithURLString:@"user/feedcomment" parameter:parameter success:^(id responseObject) {
        NSDictionary *result = responseObject;
        if ([result isKindOfClass:[NSDictionary class]]) {
            TTLog(@"获取我的评论数据 ---- \n%@",[Utils lz_dataWithJSONObject:result]);
            FMMineCommentsModel *model = [FMMineCommentsModel mj_objectWithKeyValues:result];
            if (model.errcode == 0) {
                if (self.pageIndex == 1) {
                    [self.dataArray removeAllObjects];
                }
                [self.dataArray addObjectsFromArray:model.data.list];
                [self analysisData];
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

#pragma mark - Table view data source
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FMMineMommentsTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    MineCommentsListModel *model = self.dataArray[indexPath.row];
    cell.commentsModel = model;

    return cell;
}

// 多少个分组 section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.showsVerticalScrollIndicator = false;
        [_tableView registerClass:[FMMineMommentsTableViewCell class] forCellReuseIdentifier:reuseIdentifier];
        [_tableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = kTextColor244;
    }
    return _tableView;
}

- (SCNoDataView *)noDataView {
    if (!_noDataView) {
        _noDataView = [[SCNoDataView alloc] initWithFrame:self.view.bounds
                                                imageName:@"live_k_pinglun"
                                            tipsLabelText:@"当前没有任何评论哦~"];
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

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
