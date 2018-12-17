//
//  FMMarriedBooksViewController.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/9/26.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMMarriedBooksViewController.h"
#import "FMToolsChildsHeaderView.h"
#import "FMMarriedBooksTextTableViewCell.h"
#import "FMMarriedBooksImagesTableViewCell.h"
#import "FMMarriedBooksHeaderView.h"
#import "FMRememberIncomeViewController.h"
#import "FMRememberSpendingViewController.h"

static NSString * const reuseIdentifierText = @"FMMarriedBooksTextTableViewCell";
static NSString * const reuseIdentifierImages = @"FMMerchantsHomeTableViewCell";

@interface FMMarriedBooksViewController ()<UITableViewDelegate,UITableViewDataSource,FMMarriedBooksImagesTableViewCellDelegate>

@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UILabel *headerViewTitleLable;
@property (nonatomic, strong) UIImageView *headerViewImageView;
@property (nonatomic, strong) UIButton *headerButton;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, strong) FMMarriedBooksHeaderView *tableHeadView;
/// 缓存高度
@property (nonatomic, strong) NSMutableDictionary *heightAtIndexPath;
/// 记录当前界面的状态1：礼金 2：支出 默认为：1
@property (nonatomic, assign) NSInteger currentPageStatus;
@end

@implementation FMMarriedBooksViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"结婚账本";
    [self initView];
    self.currentPageStatus = 1;
}

- (void) handleControlEvent:(UIButton *)sender{
    if (sender.tag == 103) {
        if (self.currentPageStatus==1) {
            FMRememberIncomeViewController *vc = [[FMRememberIncomeViewController alloc] init];
            vc.idxType = 1;
            TTPushVC(vc);
        }else{
            FMRememberSpendingViewController *vc = [[FMRememberSpendingViewController alloc] init];
            vc.idxType = 1;
            TTPushVC(vc);
        }
    }else{
        sender.selected = !sender.selected;
        if (sender.selected) {
            self.headerViewTitleLable.text = @"结婚支出";
            self.tableHeadView.titleLabel.text = @"礼金收入";
            self.currentPageStatus = 1;
        }else{
            self.headerViewTitleLable.text = @"礼金收入";
            self.tableHeadView.titleLabel.text = @"结婚支出";
            self.currentPageStatus = 2;
        }
    }
}

- (void) initView{
    self.tableHeadView.priceLabel.text = @"48290";
    self.tableHeadView.titleLabel.text = @"礼金收入";
    
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.headerButton];
    [self.view addSubview:self.tableHeadView];
    [self.view addSubview:self.tableView];
    [self.headerView addSubview:self.headerViewTitleLable];
    [self.headerView addSubview:self.headerViewImageView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tableHeadView.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    [self.headerViewTitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.headerView);
        make.height.equalTo(@(12));
        make.top.equalTo(self.headerView.mas_top).offset(13);
    }];
    [self.headerViewImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.headerView);
        make.top.equalTo(self.headerViewTitleLable.mas_bottom).offset(6);
    }];
}

#pragma mark ====== FMMarriedBooksImagesTableViewCellDelegate ======
- (void)updateTableViewCellHeight:(FMMarriedBooksImagesTableViewCell *)cell andheight:(CGFloat)height andIndexPath:(NSIndexPath *)indexPath {
    if (![self.heightAtIndexPath[indexPath] isEqualToNumber:@(height)]) {
        self.heightAtIndexPath[indexPath] = @(height);
        [self.tableView reloadData];
    }
}

#pragma mark - Table view data source
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row==3||indexPath.row==5) {
        FMMarriedBooksImagesTableViewCell* tools = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierImages forIndexPath:indexPath];
        tools.indexPath = indexPath;
        tools.delegate = self;
        return tools;
    }else{
        FMMarriedBooksTextTableViewCell* tools = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierText forIndexPath:indexPath];
        return tools;
    }
}

// 多少个分组 section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

/// 返回多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;//self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.heightAtIndexPath[indexPath]) {
        NSNumber *num = self.heightAtIndexPath[indexPath];
        /// collectionView 底部还有七个像素
        return [num floatValue]+7;
    }
    return 70;
}

/// 点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.currentPageStatus==1) {
        FMRememberIncomeViewController *vc = [[FMRememberIncomeViewController alloc] init];
        vc.idxType = 2;
        TTPushVC(vc);
    }else{
        FMRememberSpendingViewController *vc = [[FMRememberSpendingViewController alloc] init];
        vc.idxType = 2;
        TTPushVC(vc);
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.showsVerticalScrollIndicator = false;
        [_tableView registerClass:[FMMarriedBooksTextTableViewCell class] forCellReuseIdentifier:reuseIdentifierText];
        [_tableView registerClass:[FMMarriedBooksImagesTableViewCell class] forCellReuseIdentifier:reuseIdentifierImages];
        [_tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
        //1 禁用系统自带的分割线
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = kWhiteColor;
    }
    return _tableView;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

- (NSMutableDictionary *)heightAtIndexPath {
    if (!_heightAtIndexPath) {
        _heightAtIndexPath = [[NSMutableDictionary alloc] init];
    }
    return _heightAtIndexPath;
}

- (FMMarriedBooksHeaderView *)tableHeadView{
    if (!_tableHeadView) {
        _tableHeadView = [[FMMarriedBooksHeaderView alloc] init];
        _tableHeadView.width = kScreenWidth;
        _tableHeadView.height = IPHONE6_W(143);
        _tableHeadView.y = CGRectGetMaxY(self.headerView.frame);
        //    self.tableView.tableHeaderView = self.tableHeadView;
        MV(weakSelf)
        _tableHeadView.rememberButton.tag = 103;
        [_tableHeadView.rememberButton lz_handleControlEvent:UIControlEventTouchUpInside withBlock:^{
            [weakSelf handleControlEvent:weakSelf.tableHeadView.rememberButton];
        }];
    }
    return _tableHeadView;
}

- (UIView *)headerView{
    if (!_headerView) {
        _headerView = [[UIView alloc] init];
        _headerView.backgroundColor = kColorWithRGB(255, 219, 223);
        _headerView.frame = CGRectMake(25, 6, kScreenWidth-50, 38);
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_headerView.bounds
                                                       byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight
                                                             cornerRadii:CGSizeMake(8,8)];
        //创建 layer
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        maskLayer.frame = _headerView.bounds;
        maskLayer.path = maskPath.CGPath;
        _headerView.layer.mask = maskLayer;
    }
    return _headerView;
}

- (UIButton *)headerButton{
    if (!_headerButton) {
        _headerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _headerButton.frame = self.headerView.frame;
        _headerButton.selected = YES;
        MV(weakSelf)
        [_headerButton lz_handleControlEvent:UIControlEventTouchUpInside withBlock:^{
            [weakSelf handleControlEvent:weakSelf.headerButton];
        }];
    }
    return _headerButton;
}

- (UILabel *)headerViewTitleLable{
    if (!_headerViewTitleLable) {
        _headerViewTitleLable = [UILabel lz_labelWithTitle:@"结婚支出" color:kColorWithRGB(255, 65, 99) font:kFontSizeMedium12];
    }
    return _headerViewTitleLable;
}

- (UIImageView *)headerViewImageView{
    if (!_headerViewImageView) {
        _headerViewImageView = [[UIImageView alloc] init];
        _headerViewImageView.image = kGetImage(@"tools_header_icon");
     }
    return _headerViewImageView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
