//
//  FMBudgetDetailsViewController.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/10/10.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMBudgetDetailsViewController.h"
#import "FMBudgetDetailsHeaderView.h"
#import "FMBudgetDetailsTableViewCell.h"
#import "FMBudgetDetailsModel.h"
#import "FMModifyItemViewController.h"

static NSString *reuseIdentifier = @"FMBudgetDetailsTableViewCell";

@interface FMBudgetDetailsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) FMBudgetDetailsHeaderView *headerView;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIView *chartView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UIButton *updateButton;


@end

@implementation FMBudgetDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"预算详情";
    [self initView];
    [self addGesture:self.tableView];
    
    self.headerView.totalAmountLable.text = @"30000";
    self.headerView.totalAmountTipsLable.text = @"超过了全国21%的新人";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillAppear:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillDisAppear:) name:UIKeyboardWillHideNotification object:nil];
}

- (void) handleButtonTapped:(UIButton *)sender{
    FMModifyItemViewController *vc = [[FMModifyItemViewController alloc] init];
    vc.modifyBlock = ^(NSMutableArray * _Nonnull dataArray) {
        self.dataArray = dataArray;
        [self.tableView reloadData];
    };
    TTPushVC(vc);
}

#pragma mark - Table view data source
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    FMBudgetDetailsTableViewCell *tools = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    FMBudgetDetailsModel* model = self.dataArray[indexPath.section][indexPath.row];
    tools.imagesView.image = kGetImage(model.imageText);
    tools.titleLabel.text = model.title;
    return tools;
}

// 多少个分组 section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

/// 返回多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *subArray = [self.dataArray lz_safeObjectAtIndex:section];
    return subArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55;
}

#pragma mark -- 设置Header高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 35;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}

#pragma mark -- Section HearderView Title
// UITableView在Plain类型下，HeaderView和FooterView不悬浮和不停留的方法viewForHeaderInSection
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    SCBaseSectionHeaderView *sectionView = [[SCBaseSectionHeaderView alloc] init];
    sectionView.section = section;
    sectionView.tableView = tableView;
    UILabel *titleLable = [UILabel lz_labelWithTitle:@"" color:kTextColor102 font:kFontSizeMedium12];
    [sectionView addSubview:titleLable];
    [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(15));
        make.top.equalTo(@(20));
    }];
    if (section==0)titleLable.text = @"婚前消费";
    if (section==1)titleLable.text = @"婚礼消费";
    if (section==2)titleLable.text = @"婚后消费";
    return sectionView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    SCBaseSectionHeaderView *sectionView = [[SCBaseSectionHeaderView alloc] init];
    sectionView.section = section;
    sectionView.tableView = tableView;
    return sectionView;
}

/// 点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)keyboardWillAppear:(NSNotification *)noti {
    NSDictionary *userInfo = noti.userInfo;
    //获取键盘的frame
    CGRect keyboardFrame = [[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //获取键盘弹出的动画时间
//    NSTimeInterval animationDuration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey ] doubleValue];
    //让输入框跟随变化
//    [UIView animateWithDuration:animationDuration animations:^{
//        [_ctv mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.bottom.equalTo(@(-keyboardFrame.size.height));
//        }];
//    }];
    //设置tableview的contentInset属性，改变tableview的显示范围
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, keyboardFrame.size.height, 0);
    self.tableView.scrollEnabled = YES;
}

- (void)keyboardWillDisAppear:(NSNotification *)noti {
//    NSDictionary *userInfo = noti.userInfo;
//    NSTimeInterval animationDuration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey ] doubleValue];
//    [UIView animateWithDuration:animationDuration animations:^{
//        [_ctv mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.bottom.equalTo(@0);
//            make.height.equalTo(@52);
//        }];
//    }];
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.tableView.contentInset = contentInsets;
}

- (void) initView{
    
    UIView *hv = [UIView lz_viewWithColor:kClearColor];
    hv.frame = CGRectMake(0, 0, kScreenWidth, IPHONE6_W(236));
    self.tableView.tableHeaderView = hv;
    
    self.tableView.tableHeaderView.backgroundColor = HexString(@"#FF4163");

    
    UIView *footerView = [UIView lz_viewWithColor:kClearColor];
    footerView.frame = CGRectMake(0, 0, kScreenWidth, 65);
    self.tableView.tableFooterView = footerView;


    [hv addSubview:self.headerView];
//    [self.view addSubview:self.bottomView];
    [hv addSubview:self.chartView];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.updateButton];
    
//    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(IPHONE6_W(150));
//        make.left.right.bottom.equalTo(self.view);
//    }];
    
    [self.chartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(IPHONE6_W(117));
        make.height.mas_equalTo(IPHONE6_W(110));
        make.left.mas_equalTo(15);
        make.right.equalTo(self.view.mas_right).offset(-15);
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(self.bottomView.mas_top).offset(IPHONE6_W(88));
        make.top.left.right.bottom.equalTo(self.view);
//        make.bottom.equalTo(self.view.mas_bottom).offset(-65);
    }];
    [self.updateButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(110));
        make.height.equalTo(@(IPHONE6_W(28)));
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(-28);
    }];
}

- (UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [UIView lz_viewWithColor:kTextColor244];
    }
    return _bottomView;
}

- (FMBudgetDetailsHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[FMBudgetDetailsHeaderView alloc] init];
        _headerView.frame = CGRectMake(0, 0, kScreenWidth, IPHONE6_W(150));
        MV(weakSelf);
        [_headerView.againButton lz_handleControlEvent:UIControlEventTouchUpInside withBlock:^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }];
    }
    return _headerView;
}

- (UIView *)chartView{
    if (!_chartView) {
        _chartView = [UIView lz_viewWithColor:kWhiteColor];
        [_chartView lz_setCornerRadius:5.0];
    }
    return _chartView;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.showsVerticalScrollIndicator = false;
        [_tableView registerClass:[FMBudgetDetailsTableViewCell class] forCellReuseIdentifier:reuseIdentifier];
        [_tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = kTableViewInSectionColor;
    }
    return _tableView;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
        NSArray* titleArr = @[@[@"珠宝首饰",@"婚纱摄影"],
                              @[@"请帖喜糖",@"婚礼礼服",@"婚礼跟妆",@"婚礼摄像",@"婚礼摄影",@"婚礼司仪",@"婚车租赁",@"婚礼策划",@"婚宴酒店"],
                              @[@"蜜月旅行"]];
        NSArray* imagesArr = @[@[@"珠宝首饰",@"婚纱摄影"],
                               @[@"请帖喜糖",@"婚礼礼服",@"婚礼跟妆",@"婚礼摄像",@"婚礼摄影",@"婚礼司仪",@"婚车租赁",@"婚礼策划",@"婚宴酒店"],
                               @[@"蜜月旅行"]];
        for (int i=0; i<titleArr.count; i++) {
            NSArray *subTitlesArray = [titleArr lz_safeObjectAtIndex:i];
            NSArray *subImagesArray = [imagesArr lz_safeObjectAtIndex:i];
            NSMutableArray *subArray = [NSMutableArray array];
            for (int j = 0; j < subTitlesArray.count; j ++) {
                FMBudgetDetailsModel *personModel = [[FMBudgetDetailsModel alloc] init];
                personModel.title = [subTitlesArray lz_safeObjectAtIndex:j];
                personModel.imageText = [subImagesArray lz_safeObjectAtIndex:j];
                [subArray addObject:personModel];
            }
            [_dataArray addObject:subArray];
        }
    }
    return _dataArray;
}

- (UIButton *)updateButton{
    if (!_updateButton) {
        _updateButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_updateButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
        _updateButton.titleLabel.font = kFontSizeMedium15;
        [_updateButton setTitle:@"修改项目" forState:UIControlStateNormal];
        [_updateButton setBackgroundImage:[UIImage lz_imageWithColor:HexString(@"#FF4163")] forState:UIControlStateNormal];
        
        CALayer *layer = [CALayer layer];
        layer.shadowColor = [UIColor blackColor].CGColor;
        layer.shadowOffset = CGSizeMake(5, 5);
        layer.shadowRadius = 5;
        layer.shadowOpacity = 0.5;
        //这里self表示当前自定义的view
        [_updateButton.layer addSublayer:layer];
        MV(weakSelf);
        [_updateButton lz_setCornerRadius:IPHONE6_W(28)/2.0];
        [_updateButton lz_handleControlEvent:UIControlEventTouchUpInside withBlock:^{
            [weakSelf handleButtonTapped:weakSelf.updateButton];
        }];
    }
    return _updateButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
