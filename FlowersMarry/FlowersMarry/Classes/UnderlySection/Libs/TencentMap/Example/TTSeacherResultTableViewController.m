//
//  TTSeacherResultTableViewController.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/11/15.
//  Copyright © 2018 宁小陌. All rights reserved.
//

#import "TTSeacherResultTableViewController.h"

@interface TTSeacherResultTableViewController ()

@end

@implementation TTSeacherResultTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBar.translucent = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
}
- (void)setResultArr:(NSMutableArray<QMSSuggestionPoiData *> *)resultArr {
    
    _resultArr = resultArr;
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, self.searchBar.frame.size.height)];
    [self.tableView reloadData];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.resultArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"seacherCell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = self.resultArr[indexPath.row].title;
    cell.detailTextLabel.text = self.resultArr[indexPath.row].address;
    cell.detailTextLabel.textColor = [UIColor grayColor];
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([_SeacherResultDelegate respondsToSelector:@selector(SeacherResultBlockData:)]) {
        
        [_SeacherResultDelegate SeacherResultBlockData:self.resultArr[indexPath.row]];
    }
    // 界面跳转方式选择
    // 推出搜索结果界面
    if(_searchController) {
        _searchController.active = NO;
    } else {
        // 跳转方式
    }
}
@end
