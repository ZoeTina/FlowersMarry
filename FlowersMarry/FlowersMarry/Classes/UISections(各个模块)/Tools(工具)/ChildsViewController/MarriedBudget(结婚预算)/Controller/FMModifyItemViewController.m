//
//  FMModifyItemViewController.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/10/11.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMModifyItemViewController.h"
#import "FMModifyItemTableViewCell.h"
#import "FMBudgetDetailsModel.h"

static NSString *reuseIdentifier = @"FMModifyItemTableViewCell";

@interface FMModifyItemViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UIButton *saveButton;


@end

@implementation FMModifyItemViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"预算详情";
    [self initView];
    [self addGesture:self.tableView];
}

- (void) handleButtonTapped:(UIButton *) sender{
    NSMutableArray *upLoadArr = [NSMutableArray array];
    for (int i=0; i<self.dataArray.count; i++) {
        NSArray *secondArray = self.dataArray[i];
        NSMutableArray *subArray = [NSMutableArray array];
        for (int j=0; j<secondArray.count; j++) {
            FMBudgetDetailsModel *model = secondArray[j];
            if (model.isSelected) {
                [subArray addObject:model];
            }
        }
        [upLoadArr addObject:subArray];
    }
    
    if (self.modifyBlock) {
        self.modifyBlock(upLoadArr);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Table view data source
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FMModifyItemTableViewCell *tools = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    FMBudgetDetailsModel* model = self.dataArray[indexPath.section][indexPath.row];
//    tools.titleLabel.text = model.title;
    tools.model          = model;
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
    if (section==self.dataArray.count-1) return 0;
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
        make.top.equalTo(@(12));
    }];
    UIImageView *imageView = [[UIImageView alloc] init];
    [sectionView addSubview:imageView];
    imageView.image = kGetImage(@"矩形7拷贝");
    [titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(sectionView.mas_right).offset(-20);
        make.centerY.equalTo(titleLable);
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
    FMBudgetDetailsModel *model = self.dataArray[indexPath.section][indexPath.row];
    model.isSelected = !model.isSelected;
    [self.tableView reloadData];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void) initView{
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.saveButton];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(self.saveButton.mas_top);
    }];
    [self.saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(@(45));
    }];
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.showsVerticalScrollIndicator = false;
        [_tableView registerClass:[FMModifyItemTableViewCell class] forCellReuseIdentifier:reuseIdentifier];
        [_tableView setSeparatorInset:UIEdgeInsetsMake(0, 50, 0, 15)];
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
                FMBudgetDetailsModel *model = [[FMBudgetDetailsModel alloc] init];
                model.title = [subTitlesArray lz_safeObjectAtIndex:j];
                model.imageText = [subImagesArray lz_safeObjectAtIndex:j];
                model.isSelected = NO;
                [subArray addObject:model];
            }
            [_dataArray addObject:subArray];
        }
    }
    return _dataArray;
}

- (UIButton *)saveButton{
    if (!_saveButton) {
        _saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_saveButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
        _saveButton.titleLabel.font = kFontSizeMedium15;
        [_saveButton setTitle:@"确定" forState:UIControlStateNormal];
        [_saveButton setBackgroundImage:[UIImage lz_imageWithColor:HexString(@"#FF4163")] forState:UIControlStateNormal];
        
        MV(weakSelf);
        [_saveButton lz_handleControlEvent:UIControlEventTouchUpInside withBlock:^{
            [weakSelf handleButtonTapped:weakSelf.saveButton];
        }];
    }
    return _saveButton;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
