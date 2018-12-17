//
//  FMBusinessDynamicViewController.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/8/23.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMBusinessDynamicViewController.h"

/// 显示图片集
#import "FMShowPhotoCollectionViewController.h"
/// 图文详情
#import "FMPictureWithTextViewController.h"

#import "FMVideoTableViewCell.h"
#import "FMImagesTableViewCell.h"
#import "FMMoreImagesTableViewCell.h"
#import "FMImagesRightTableViewCell.h"
#import "FMImagesTransverseThreeTableViewCell.h"

static NSString * const reuseIdentifierVideo = @"FMVideoTableViewCell";
static NSString * const reuseIdentifierImage = @"FMImagesTableViewCell";
static NSString * const reuseIdentifierMoreImage = @"FMMoreImagesTableViewCell";
static NSString * const reuseIdentifierRightImage = @"FMImagesRightTableViewCell";
static NSString * const reuseIdentifierThreeImage = @"FMImagesTransverseThreeTableViewCell";

@interface FMBusinessDynamicViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, assign) NSInteger pageSize;
@property (nonatomic, strong) NSMutableArray *itemModelArray;
@property (nonatomic, strong) BusinessModel *businessModel;
@property (nonatomic, strong) SCNoDataView *noDataView;
@end

@implementation FMBusinessDynamicViewController
- (id)initBusinessData:(BusinessModel *)businessModel{
    if ( self = [super init] ){
        self.businessModel = businessModel;
        self.pageSize = 20;
        self.pageIndex = 1;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initView];
    self.pageIndex = 1;
    self.title = @"商家动态";
    [self.view showLoadingViewWithText:@"加载中..."];
    [self loadBusinessdDynamicModel];
    /// 下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //将页码重新置为1
        self.pageIndex = 1;
        [self loadBusinessdDynamicModel];
    }];
    /// 上拉加载
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.pageIndex++;// 页码+1
        [self loadBusinessdDynamicModel];
        [self.tableView.mj_footer endRefreshing];
    }];
}

- (void) initView{
    [Utils lz_setExtraCellLineHidden:self.tableView];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(kLinerViewHeight));
        make.left.bottom.right.equalTo(self.view);
    }];
}

- (void)analysisData {
    if (self.itemModelArray.count == 0) {
        self.noDataView.hidden = NO;
    }else {
        self.noDataView.hidden = YES;
    }
}

/// 获取商家的动态数据
- (void) loadBusinessdDynamicModel{
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setObject:kUserInfo.site_id forKey:@"site_id"];
    [parameter setObject:self.businessModel.cp_id forKey:@"cp_id"];
    [parameter setObject:@(self.pageSize) forKey:@"size"];
    [parameter setObject:@(self.pageIndex) forKey:@"p"];
    [SCHttpTools getWithURLString:@"feed/getlist" parameter:parameter success:^(id responseObject) {
        NSDictionary *result = responseObject;
        if (result) {
            FMDynamicModel *model = [FMDynamicModel mj_objectWithKeyValues:result];
            if (self.pageIndex==1) {
                [self.itemModelArray removeAllObjects];
            }
            [self.itemModelArray addObjectsFromArray:model.data.list];
            [self analysisData];
            [self.tableView.mj_header endRefreshing];
        }
        [self.tableView reloadData];
        [self.view dismissLoadingView];
        self.tableView.hidden = NO;
    } failure:^(NSError *error) {
        TTLog(@" -- error -- %@",error);
        [self.tableView.mj_header endRefreshing];
        [self.view dismissLoadingView];
    }];
}

#pragma mark - Table view data source
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DynamicModel *dynamicModel = self.itemModelArray[indexPath.row];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.itemModelArray.count;
}


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
            
            break;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//点击UICollectionViewCell的代理方法
- (void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath withContent:(NSString *)content {
    [self lz_make:[NSString stringWithFormat:@"第 %ld 张图片",indexPath.row]];
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

        [_tableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
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
                                            tipsLabelText:@"当前没有任动态哦~"];
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

- (NSMutableArray *)itemModelArray{
    if (!_itemModelArray) {
        _itemModelArray = [[NSMutableArray alloc] init];
    }
    return _itemModelArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
