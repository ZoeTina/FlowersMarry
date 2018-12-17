//
//  TTTemplateChildViewController.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/12/10.
//  Copyright © 2018 宁小陌. All rights reserved.
//

#import "TTTemplateChildViewController.h"
#import "TTTemplateChildTableViewCell.h"
#import "FMWorksListDetailsViewController.h"

static NSString * const reuseIdentifier = @"TTTemplateChildTableViewCell";
@interface TTTemplateChildViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic ,strong) UITableView *mainTableView;
@property (nonatomic, strong) NSMutableArray *itemModelArray;
@end

@implementation TTTemplateChildViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0,kScreenWidth,kScreenHeight-kNavBarHeight-kTabBarHeight-40)];
    [_mainTableView registerClass:[TTTemplateChildTableViewCell class] forCellReuseIdentifier:reuseIdentifier];
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    _mainTableView.backgroundColor = kWhiteColor;
    _mainTableView.showsVerticalScrollIndicator = NO;
    _mainTableView.showsHorizontalScrollIndicator = NO;
    _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_mainTableView];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TTTemplateChildTableViewCell *tools = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    tools.titleLabel.text = @"【拉斐婚纱照】十一月客片欣赏 ";
    tools.commentCountLabel.text = @"228条";
    tools.styleLabel.text = @"风格：复古典雅端庄中国风";
    tools.priceLabel.text = @"￥3498";
    return tools;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return IPHONE6_W(196);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FMWorksListDetailsViewController *vc = [[FMWorksListDetailsViewController alloc] init];
    vc.casesDadaModel = self.itemModelArray[indexPath.row];
    TTPushVC(vc);
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
