//
//  FMLikeDynamicViewController.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/9.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMLikeDynamicViewController.h"

/// 显示图片集
#import "FMShowPhotoCollectionViewController.h"

/// 图文详情
#import "FMPictureWithTextViewController.h"
/// 商家首页
#import "FMMerchantsHomeViewController.h"

/// 三亚
#import "FMTourismShootingViewController.h"

#import "FMVideoTableViewCell.h"
#import "FMImagesTableViewCell.h"
#import "FMMoreImagesTableViewCell.h"
#import "FMImagesRightTableViewCell.h"
#import "FMImagesTransverseThreeTableViewCell.h"

#import "FMConsumerProtectionViewController.h"

static NSString * const reuseIdentifierVideo = @"FMVideoTableViewCell";
static NSString * const reuseIdentifierImage = @"FMImagesTableViewCell";
static NSString * const reuseIdentifierMoreImage = @"FMMoreImagesTableViewCell";
static NSString * const reuseIdentifierRightImage = @"FMImagesRightTableViewCell";
static NSString * const reuseIdentifierThreeImage = @"FMImagesTransverseThreeTableViewCell";

@interface FMLikeDynamicViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) SCNoDataView *noDataView;
/// 每页多少数据
@property (nonatomic, assign) NSInteger pageSize;
/// 当前页
@property (nonatomic, assign) NSInteger pageIndex;
@end

@implementation FMLikeDynamicViewController

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
        make.bottom.left.right.equalTo(self.view);
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

/// 获取我喜欢的
- (void) getDataRequest{
    [SCHttpTools getWithURLString:@"user/feedcollect" parameter:nil success:^(id responseObject) {
        NSDictionary *result = responseObject;
        if ([result isKindOfClass:[NSDictionary class]]) {
            FMGeneralModel *genralModel = [FMGeneralModel mj_objectWithKeyValues:result];
            TTLog(@"获取我喜欢的数据 ---- \n%@",[Utils lz_dataWithJSONObject:result]);
            if (genralModel.errcode == 0) {
                DynamicDataModel *dynamicModel = [DynamicDataModel mj_objectWithKeyValues:result[@"data"]];
                if (self.pageIndex==1) {
                    [self.dataArray removeAllObjects];
                }
                [self.dataArray addObjectsFromArray:dynamicModel.list];
                [self analysisData];
            }else {
                Toast([result lz_objectForKey:@"message"]);
            }
            [self.tableView reloadData];
            [self.tableView.mj_header endRefreshing];
        }
        [self.view dismissLoadingView];
    } failure:^(NSError *error) {
        TTLog(@" -- error -- %@",error);
        [self.tableView.mj_header endRefreshing];
        [self.view dismissLoadingView];
    }];
}

- (void) analysisData{
    if (self.dataArray.count == 0) {
        self.noDataView.hidden = NO;
    }else {
        self.noDataView.hidden = YES;
    }
}

#pragma mark - Table view data source
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DynamicModel *dynamicModel = self.dataArray[indexPath.row];
    switch (dynamicModel.shape) {
        case 1: {/// 图文
            if (dynamicModel.thumb_num==1) {/// 图文  ---  1:一张封面图
                FMImagesRightTableViewCell* tools = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierRightImage forIndexPath:indexPath];
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

// 多少个分组 section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

/// 返回多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

/// 点击TableViewCell事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DynamicModel *dynamicModel = self.dataArray[indexPath.row];
    if (dynamicModel.shape==1) {
        FMPictureWithTextViewController *vc = [[FMPictureWithTextViewController alloc] initHomeDataModel:dynamicModel];
        TTPushVC(vc);
    }else if (dynamicModel.shape==2) {
        FMShowPhotoCollectionViewController *vc = [[FMShowPhotoCollectionViewController alloc] initHomeDataModel:dynamicModel];
        TTPushVC(vc);
    }else{
        
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.showsVerticalScrollIndicator = false;
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

- (SCNoDataView *)noDataView {
    if (!_noDataView) {
        _noDataView = [[SCNoDataView alloc] initWithFrame:self.view.bounds
                                                imageName:@"live_k_pinglun"
                                            tipsLabelText:@"您还没有喜欢的动态哦~"];
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
