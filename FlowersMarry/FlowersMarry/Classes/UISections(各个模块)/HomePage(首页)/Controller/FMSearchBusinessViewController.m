//
//  FMSearchBusinessViewController.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/9/1.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMSearchBusinessViewController.h"
#import "FMMerchantsHomeViewController.h"
#import "FMTableViewHeaderBlankView.h"
#import "TTBusinessTableViewCell.h"
#import "FMWorksListDetailsViewController.h"

static NSString * const reuseIdentifier = @"TTBusinessTableViewCell";

@interface FMSearchBusinessViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) FMTableViewHeaderBlankView *headerView;
@property (nonatomic, strong) BusinessDataModel *businessDataModel;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end

@implementation FMSearchBusinessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initView];
    [self getRecommendedBusinessDataRequest];
    self.title = @"搜索结果";
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

/// 获取推荐商家列表数据
- (void) getRecommendedBusinessDataRequest{
    NSDictionary *parameter = @{@"site_id":kUserInfo.site_id,@"q":self.keywords};
    [SCHttpTools getWithURLString:@"company/search" parameter:parameter success:^(id responseObject) {
        NSDictionary *result = responseObject;
        if ([result isKindOfClass:[NSDictionary class]]) {
            TTLog(@"获取搜索商家的h数据 ---- \n%@",[Utils lz_dataWithJSONObject:result]);
            FMBusinessModel *model = [FMBusinessModel mj_objectWithKeyValues:result];
            self.businessDataModel = model.data;
            if (model.errcode == 0) {
                [self.dataArray removeAllObjects];
                if (self.businessDataModel.list.count>0) {
                    [self.dataArray addObjectsFromArray:self.businessDataModel.list];
                }else{
                    self.tableView.tableHeaderView = self.headerView;
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
        [self.view dismissLoadingView];
    }];
}

#pragma mark - Table view data source
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TTBusinessTableViewCell* tools = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    BusinessModel *businessModel = self.dataArray[indexPath.row];
    tools.businessModel = businessModel;
    return tools;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    BusinessModel *businessModel = self.dataArray[indexPath.row];
    if (businessModel.youhui_num==0&&kObjectIsEmpty(businessModel.huodong)) {
        return IPHONE6_W(95);
    }else if (kObjectIsEmpty(businessModel.huodong)){
        return IPHONE6_W(115);
    }else if(businessModel.youhui_num==0){
        return IPHONE6_W(130);
    }
    return IPHONE6_W(150);
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
    FMWorksListDetailsViewController *vc = [[FMWorksListDetailsViewController alloc] init];
    model.cp_id = businessModel.cp_id;
    vc.casesDadaModel = model;
    TTPushVC(vc);
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.showsVerticalScrollIndicator = false;
        [_tableView registerClass:[TTBusinessTableViewCell class] forCellReuseIdentifier:reuseIdentifier];
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
        _headerView.imagesView.image = kGetImage(@"business_search");
        _headerView.titleLabel.text = @"没有找到相关商家";
        _headerView.guessLabel.text = @"猜你喜欢";
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
