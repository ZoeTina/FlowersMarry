//
//  FMCustomTaskViewController.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/10/13.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMCustomTaskViewController.h"
#import "FMTaskTableViewCell.h"
#import "FMMarriedTaskModel.h"
#import "FMTaskSectionHeaderView.h"

static NSString *reuseIdentifier = @"FMTaskTableViewCell";

@interface FMCustomTaskViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation FMCustomTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
    UIView *linerView =[UIView lz_viewWithColor:HexString(@"#EEEEEE")];
    [self.view addSubview:linerView];
    [linerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.equalTo(@(0.7));
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(linerView);
    }];
}

#pragma mark - Table view data source
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FMTaskTableViewCell *tools = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
//    FMMarriedTaskModel* model = self.dataArray[indexPath.section][indexPath.row];
    tools.titleLabel.text = @"向公司请好婚假";
    tools.subtitleLabel.text = @"结婚吉日";
    if (indexPath.row==1) {
        tools.tagButton.hidden = NO;
    }else{
        tools.tagButton.hidden = YES;
    }
    return tools;
}

// 多少个分组 section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 5;//self.dataArray.count;
}

/// 返回多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *subArray = [self.dataArray lz_safeObjectAtIndex:section];
    return 20;//subArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55;
}

#pragma mark -- 设置Header高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return section == 0 ? 35 : 45;
}

#pragma mark -- Section HearderView Title
// UITableView在Plain类型下，HeaderView和FooterView不悬浮和不停留的方法viewForHeaderInSection
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    FMTaskSectionHeaderView *sectionView = [[FMTaskSectionHeaderView alloc] init];
    sectionView.section = section;
    sectionView.tableView = tableView;
    
    UIView *view = [UIView lz_viewWithColor:kWhiteColor];
    [sectionView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(sectionView);
        make.height.equalTo(@(35));
    }];
    UILabel *titleLabel = [UILabel lz_labelWithTitle:@"" color:kTextColor51 font:kFontSizeScBold14];
    [view addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(15));
        make.centerY.equalTo(view);
    }];
    
    titleLabel.text = @"婚纱摄影";
    return sectionView;
}

//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    SCBaseSectionHeaderView *sectionView = [[SCBaseSectionHeaderView alloc] init];
//    sectionView.section = section;
//    sectionView.tableView = tableView;
//    sectionView.type = 1;
//    return sectionView;
//}

/// 点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.showsVerticalScrollIndicator = false;
        [_tableView registerClass:[FMTaskTableViewCell class] forCellReuseIdentifier:reuseIdentifier];
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
//                FMBudgetDetailsModel *personModel = [[FMBudgetDetailsModel alloc] init];
//                personModel.title = [subTitlesArray lz_safeObjectAtIndex:j];
//                personModel.imageText = [subImagesArray lz_safeObjectAtIndex:j];
//                [subArray addObject:personModel];
            }
            [_dataArray addObject:subArray];
        }
    }
    return _dataArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
