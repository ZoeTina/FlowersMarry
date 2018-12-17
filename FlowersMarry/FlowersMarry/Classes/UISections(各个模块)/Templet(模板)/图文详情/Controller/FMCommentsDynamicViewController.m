//
//  FMCommentsDynamicViewController.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/8/22.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMCommentsDynamicViewController.h"
#import "FMPictureCollectionReplyTableViewCell.h"

static NSString * const reuseIdentifierReply = @"FMPictureCollectionReplyTableViewCell";

@interface FMCommentsDynamicViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *itemModelArray;
@property (nonatomic, strong) DynamicModel *homeData;
@property (nonatomic, strong) SCNoDataView *noDataView;


@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, assign) NSInteger pageSize;

@end

@implementation FMCommentsDynamicViewController
- (id)initHomeDataModel:(DynamicModel *) homeData{
    if ( self = [super init] ){
        self.homeData = homeData;
        self.pageSize = 20;
        self.pageIndex = 1;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initView];
    self.title = @"评论";
    [self loadHotCommentDataRequest];
}

- (void) initView{
    [Utils lz_setExtraCellLineHidden:self.tableView];
    self.view.backgroundColor = kTextColor244;

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
        [self loadHotCommentDataRequest];
    }];
    /// 上拉加载
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.pageIndex++;// 页码+1
        [self loadHotCommentDataRequest];
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

/// 获取热门评论的数据
- (void) loadHotCommentDataRequest{
    NSString *URLString = @"feed/commentlist";
    NSDictionary *parameter = @{@"feed_id":self.homeData.kid,@"p":@(self.pageIndex),@"size":@(self.pageSize)};
    [SCHttpTools getWithURLString:URLString parameter:parameter success:^(id responseObject) {
        NSDictionary *result = responseObject;
        if ([result isKindOfClass:[NSDictionary class]]) {
            TTLog(@"获取评论数据 ---- \n%@",[Utils lz_dataWithJSONObject:result]);

            FMCommentsDynamicModel *model = [FMCommentsDynamicModel mj_objectWithKeyValues:result];
            if (model.errcode == 0) {
                if (self.pageIndex==0) {
                    [self.itemModelArray removeAllObjects];
                }
                [self.itemModelArray addObjectsFromArray:model.data.info];
                [self analysisData];
            }else {
                Toast([result lz_objectForKey:@"message"]);
            }
        }
        [self.tableView reloadData];
        [self.view dismissLoadingView];
        [self.tableView.mj_footer endRefreshing];
        self.tableView.hidden = NO;
    } failure:^(NSError *error) {
        TTLog(@" -- error -- %@",error);
        [self.view dismissLoadingView];
        [self.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark - Table view data source
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FMPictureCollectionReplyTableViewCell * tools = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierReply forIndexPath:indexPath];
    tools.model = self.itemModelArray[indexPath.row];
    return tools;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return UITableViewAutomaticDimension;
}

// 多少个分组 section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

/// 返回多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.itemModelArray.count;
}

#pragma mark --- setter/getter
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.showsVerticalScrollIndicator = false;
        [_tableView registerClass:[FMPictureCollectionReplyTableViewCell class] forCellReuseIdentifier:reuseIdentifierReply];
        [_tableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = kTextColor244;
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
                                                imageName:@"live_k_pinglun"
                                            tipsLabelText:@"您没有评论任何动态哦~"];
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
