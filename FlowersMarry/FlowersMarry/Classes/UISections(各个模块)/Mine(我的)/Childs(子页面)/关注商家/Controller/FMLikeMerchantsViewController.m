//
//  FMLikeMerchantsViewController.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/9.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMLikeMerchantsViewController.h"
#import "FMTemplateTwoTableViewCell.h"
#import "FMMerchantsHomeViewController.h"
#import "FMTableViewHeaderBlankView.h"
#import "FMBusinessTableViewCell.h"

static NSString * const reuseIdentifier = @"FMTemplateTwoTableViewCell";
static NSString * const reuseIdentifierBusiness = @"FMBusinessTableViewCell";

@interface FMLikeMerchantsViewController ()<UITableViewDelegate,UITableViewDataSource,FMBusinessTableViewCellDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) FMTableViewHeaderBlankView *headerView;
/// 关注的数据
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) BusinessDataModel *businessDataModel;


/// 每页多少数据
@property (nonatomic, assign) NSInteger pageSize;
/// 当前页
@property (nonatomic, assign) NSInteger pageIndex;
//@property (nonatomic, strong) PreferentialModel *preferentialModel;

@end

@implementation FMLikeMerchantsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.title = @"关注商家";
    self.pageIndex = 1;
    self.pageSize = 20;
    [self initView];
    [self getDataRequest];
    
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

/// 获取我的预约数据
- (void) getDataRequest{
    NSDictionary *parameter = @{@"size":@(self.pageSize),@"p":@(self.pageIndex)};
    [SCHttpTools getWithURLString:@"user/fllowlist" parameter:parameter success:^(id responseObject) {
        NSDictionary *result = responseObject;
        if ([result isKindOfClass:[NSDictionary class]]) {
            TTLog(@"获取我的关注数据 ---- \n%@",[Utils lz_dataWithJSONObject:result]);
            FMBusinessModel *model = [FMBusinessModel mj_objectWithKeyValues:result];
            self.businessDataModel = model.data;
            if (model.errcode == 0) {
                [self.dataArray removeAllObjects];
                if (self.businessDataModel.list.count>0) {
                    [self.dataArray addObjectsFromArray:self.businessDataModel.list];
                }else{
                    [self setHeaderToView];
                    [self.dataArray addObjectsFromArray:self.businessDataModel.recommend];
                }
            }else {
                Toast([result lz_objectForKey:@"message"]);
            }
            [self.view dismissLoadingView];
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
        }else{
            [self.view dismissLoadingView];
        }
    } failure:^(NSError *error) {
        TTLog(@" -- error -- %@",error);
        [self.tableView.mj_header endRefreshing];
        [self.view dismissLoadingView];
    }];
}

- (void) initView{
    [Utils lz_setExtraCellLineHidden:self.tableView];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(kLinerViewHeight));
        make.bottom.left.right.equalTo(self.view);
    }];
    [self.view showLoadingViewWithText:@"加载中..."];
}

/// 设置无数据头视图
- (void) setHeaderToView{
    FMTableViewHeaderBlankView *headerView = [[FMTableViewHeaderBlankView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, IPHONE6_W(170))];
    headerView.titleLabel.text = @"您还没有关注商家哦";
    headerView.guessLabel.text = @"猜你喜欢";
    headerView.imagesView.image = kGetImage(@"mine_btn_tu12");
    self.tableView.tableHeaderView = headerView;
}

- (void) isFllowButtonOnClick:(UIButton *) sender{
    [MBProgressHUD showMessage:@"" toView:self.view];
    NSString *URLString = @"feed/fllow";
    BusinessModel *model = self.dataArray[sender.tag];

    NSDictionary *parameter = @{@"cp_id":model.cp_id};
    [SCHttpTools getWithURLString:URLString parameter:parameter success:^(id responseObject) {
        NSDictionary *result = responseObject;
        if ([result isKindOfClass:[NSDictionary class]]) {
            if ([[result lz_objectForKey:@"errcode"] integerValue] == 0) {
                sender.selected = !sender.selected;
                //// 发送通知
                [kNotificationCenter postNotificationName:@"reloadMineData" object:nil];
            }
            Toast([result lz_objectForKey:@"message"]);
        }
        [MBProgressHUD hideHUDForView:self.view];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        TTLog(@" -- error -- %@",error);
        [MBProgressHUD hideHUDForView:self.view];
    }];
}

#pragma mark - Table view data source
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MV(weakSelf)
    if (self.businessDataModel.list.count>0) {
        FMTemplateTwoTableViewCell* tools = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
        tools.businessModel = self.dataArray[indexPath.row];
        tools.guanzhuButton.tag = indexPath.row;
        [tools.guanzhuButton lz_handleControlEvent:UIControlEventTouchUpInside withBlock:^{
            [weakSelf isFllowButtonOnClick:tools.guanzhuButton];
        }];
        return tools;
    }else{
        FMBusinessTableViewCell* tools = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierBusiness forIndexPath:indexPath];
        BusinessModel *listModel = self.dataArray[indexPath.row];
        tools.businessModel = listModel;
        tools.delegate = self;
        return tools;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.businessDataModel.list.count>0)return IPHONE6_W(90);
    return IPHONE6_W(203);
}

// 多少个分组 section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

/// 返回多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

/// 点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BusinessModel *businessModel = self.dataArray[indexPath.row];
    FMMerchantsHomeViewController *vc = [[FMMerchantsHomeViewController alloc] initBusinessModel:businessModel];
    TTPushVC(vc);
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//点击UICollectionViewCell的代理方法
- (void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath withCasesModel:(BusinessCasesModel *)model {
    BusinessModel *businessModel = self.dataArray[indexPath.row];
    FMMerchantsHomeViewController *vc = [[FMMerchantsHomeViewController alloc] initBusinessModel:businessModel];
    TTPushVC(vc);
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.showsVerticalScrollIndicator = false;
        [_tableView registerClass:[FMTemplateTwoTableViewCell class] forCellReuseIdentifier:reuseIdentifier];
        [_tableView registerClass:[FMBusinessTableViewCell class] forCellReuseIdentifier:reuseIdentifierBusiness];
        [_tableView setSeparatorInset:UIEdgeInsetsMake(0, 15, 0, 15)];
        //1 禁用系统自带的分割线
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = kViewColorNormal;
        _tableView.rowHeight = UITableViewAutomaticDimension;
    }
    return _tableView;
}

- (FMTableViewHeaderBlankView *)headerView{
    if (!_headerView) {
        _headerView = [[FMTableViewHeaderBlankView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, IPHONE6_W(170))];
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _headerView;
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
