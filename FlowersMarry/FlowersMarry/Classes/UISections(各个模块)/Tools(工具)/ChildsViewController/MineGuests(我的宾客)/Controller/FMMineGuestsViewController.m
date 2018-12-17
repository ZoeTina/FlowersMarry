//
//  FMMineGuestsViewController.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/9/26.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMMineGuestsViewController.h"
#import "FMMineGuestsFooterView.h"

#import "FMMineGuestsTableViewCell.h"
static NSString * const reuseIdentifier = @"FMMineGuestsTableViewCell";

@interface FMMineGuestsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UILabel *tipsLabel;
@property (nonatomic, strong) UIButton *invitationButton;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) FMMineGuestsFooterView *footerView;

@end

@implementation FMMineGuestsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initView];
}

- (void) handleButtonEvents:(NSInteger)idx{
    /// 100:搜索 101:加桌 102:预览 103:查座 104:发送
    switch (idx) {
        case 100:
            [self lz_make:@"搜索按钮"];
            break;
        case 101:
            [self lz_make:@"加桌按钮"];
            break;
        case 102:
            [self lz_make:@"预览按钮"];
            break;
        case 103:
            [self lz_make:@"查座按钮"];
            break;
        case 104:
            [self lz_make:@"发送按钮"];
            break;
        default:
            break;
    }
}

#pragma mark - Table view data source
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FMMineGuestsTableViewCell* tools = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
//    WorksListModel *model = self.itemModelArray[indexPath.row];
//    tools.listModel = model;
    return tools;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return IPHONE6_W(117);
}

// 多少个分组 section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

/// 返回多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;//self.dataArray.count;
}

/// 点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void) initView{
    [self.view addSubview:self.headerView];
    [self.headerView addSubview:self.tipsLabel];
    [self.headerView addSubview:self.invitationButton];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.footerView];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.equalTo(@(40));
    }];
    
    [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(20));
        make.centerY.equalTo(self.headerView);
    }];
    
    [self.invitationButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.headerView);
        make.right.equalTo(self.headerView);
        make.width.equalTo(@(50));
        make.height.equalTo(@(22));
    }];
    
    [self.footerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(kiPhoneX_T(50));
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.headerView.mas_bottom);
        make.bottom.equalTo(self.footerView.mas_top);
    }];
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.showsVerticalScrollIndicator = false;
        [_tableView registerClass:[FMMineGuestsTableViewCell class] forCellReuseIdentifier:reuseIdentifier];
        [_tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
        //1 禁用系统自带的分割线
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = kViewColorNormal;
        _tableView.rowHeight = UITableViewAutomaticDimension;
    }
    return _tableView;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (UIView *)headerView{
    if (!_headerView) {
        _headerView = [UIView lz_viewWithColor:HexString(@"#FEF3E1")];
    }
    return _headerView;
}

- (UILabel *)tipsLabel{
    if (!_tipsLabel) {
        _tipsLabel = [UILabel lz_labelWithTitle:@"邀请另一半，一起安排宾客~"
                                          color:HexString(@"#DA8A5B")
                                           font:kFontSizeMedium13];
    }
    return _tipsLabel;
}

- (UIButton *)invitationButton{
    if (!_invitationButton) {
        _invitationButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _invitationButton.titleLabel.font = kFontSizeMedium12;
        [_invitationButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [_invitationButton setTitle:@"去邀请" forState:UIControlStateNormal];
        [_invitationButton lz_setCornerRadius:11.0];
        [_invitationButton setBackgroundImage:[UIImage lz_imageWithColor:HexString(@"#F9A16E")] forState:UIControlStateNormal];
    }
    return _invitationButton;
}

- (FMMineGuestsFooterView *)footerView{
    if (!_footerView) {
        _footerView = [[FMMineGuestsFooterView alloc] init];
        MV(weakSelf)
        _footerView.block = ^(NSInteger idx) {
            [weakSelf handleButtonEvents:idx];
        };
    }
    return _footerView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
