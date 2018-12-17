//
//  FMComboListDetailRightViewController.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/10/30.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMComboListDetailRightViewController.h"
#import "FMTemplateSixTableViewCell.h"

static NSString * const reuseIdentifierTemplateSix = @"FMTemplateSixTableViewCell";

@interface FMComboListDetailRightViewController()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) SCCustomMarginLabel *titleLabel;
@property (nonatomic, strong) UITableView *tableView;

@end

@implementation FMComboListDetailRightViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"套餐详情";
    [self initView];
    [self.tableView reloadData];
    
    UIView *linerView = [UIView lz_viewWithColor:kTextColor238];
    [self.view addSubview:linerView];
    [linerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.equalTo(@(0.66));
    }];
}

- (void)setTaoxiModel:(BusinessTaoxiModel *)taoxiModel{
    _taoxiModel = taoxiModel;
}

- (void) initView{
    
    [Utils lz_setExtraCellLineHidden:self.tableView];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(0.66));
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(-(kiPhoneX_T(50)));
    }];
}

#pragma mark - Table view data source
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FMTemplateSixTableViewCell *tools = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierTemplateSix forIndexPath:indexPath];
    BusinessTaoxiMetaModel *metaModel = self.taoxiModel.meta[indexPath.row];
    tools.indexPathRow = indexPath.row;
    tools.metaModel = metaModel;
    return tools;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}


// 多少个分组 section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.taoxiModel.meta.count;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.showsVerticalScrollIndicator = false;
        [_tableView registerClass:[FMTemplateSixTableViewCell class] forCellReuseIdentifier:reuseIdentifierTemplateSix];
        [_tableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = kWhiteColor;
        _tableView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    }
    return _tableView;
}
@end
