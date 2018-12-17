//
//  FMChooseMusicViewController.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/11/7.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMChooseMusicViewController.h"
#import "MVSingleChooseTableView.h"
#import "FMChooseMusicModel.h"

@interface FMChooseMusicViewController ()
@property(nonatomic,weak)MVSingleChooseTableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)FMChooseMusicModel *chooseMusicModel;
@property (nonatomic, strong) SCNoDataView *noDataView;

@end

@implementation FMChooseMusicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"背景音乐";
    [self.view showLoadingViewWithText:@"加载中..."];
    [self getMusicDataRequest];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = kWhiteColor;
}

- (void) getMusicDataRequest{
    [SCHttpTools getWithURLString:@"invitation/GetMusicLists" parameter:nil success:^(id responseObject) {
        NSDictionary *result = responseObject;
        if ([result isKindOfClass:[NSDictionary class]]) {
            FMChooseMusicModel *chooseMusicModel = [FMChooseMusicModel mj_objectWithKeyValues:result];
            self.chooseMusicModel = chooseMusicModel;
            if (self.chooseMusicModel.data.count==0) {
                [self analysisData];
            }
            self.tableView.dataArr = self.chooseMusicModel.data;
            self.tableView.chooseContent = self.selectMusicStr;
        }
        [self.view addSubview:self.tableView];
        self.tableView.backgroundColor = kWhiteColor;
        [self.tableView reloadData];
        [self.view dismissLoadingView];
    } failure:^(NSError *error) {
        TTLog(@"---- %@",error);
        [self.view dismissLoadingView];
    }];
}

- (void)analysisData {
    if (self.chooseMusicModel.data.count == 0) {
        self.noDataView.hidden = NO;
    }else {
        self.noDataView.hidden = YES;
    }
}

- (MVSingleChooseTableView *)tableView {
    if (!_tableView) {
        _tableView = [MVSingleChooseTableView initTableWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
//        _tableView.dataArr = self.dataArray;
//        _tableView.chooseContent = self.selectMusicStr;
        [_tableView reloadData];
        //选中内容
        _tableView.block = ^(NSString *chooseContent,NSString *muiscID){
            TTLog(@"数据：%@ ；第%@行",chooseContent,muiscID);
            self.block(chooseContent,muiscID);
            [self.navigationController popViewControllerAnimated:YES];
        };
    }
    return _tableView;
}

- (SCNoDataView *)noDataView {
    if (!_noDataView) {
        _noDataView = [[SCNoDataView alloc] initWithFrame:self.view.bounds
                                                imageName:@"live_k_guanzhu"
                                            tipsLabelText:@"没有相关音乐哦~"];
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

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] initWithCapacity:0];
    }
    return _dataArray;
}

@end
