//
//  MVSingleChooseTableView.m
//  MerchantVersion
//
//  Created by 寜小陌 on 2018/3/2.
//  Copyright © 2018年 寜小陌. All rights reserved.
//

#import "MVSingleChooseTableView.h"
#import "MVChooseTableViewCell.h"
#import "FMChooseMusicModel.h"
#define HeaderHeight 50
#define CellHeight 50
static NSString * const reuseIdentifier = @"MVChooseTableViewCell";
@interface MVSingleChooseTableView()
@property(nonatomic,strong)NSDictionary *cellDic;//设置cell的identifier，防止重用
@end

@implementation MVSingleChooseTableView

+(MVSingleChooseTableView *)initTableWithFrame:(CGRect)frame{
    MVSingleChooseTableView * tableView = [[MVSingleChooseTableView alloc]initWithViewFrame:frame];
    return tableView;
}

-(instancetype)initWithViewFrame:(CGRect)frame{
    self = [super init];
    if(self){
        self.frame = frame;
        [self CreateTable];
    }
    return self;
}

-(void)CreateTable{
    [self addSubview:self.tableView];
}

#pragma UITableViewDelegate - UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifier = [NSString stringWithFormat:@"reuseIdentifier%ld",(long)indexPath.row];
    MVChooseTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[MVChooseTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.titleLabel.text = [_dataArr objectAtIndex:indexPath.row];
    MusicModel *musicModel = [_dataArr objectAtIndex:indexPath.row];
    cell.titleLabel.text = musicModel.musicName;
    if ([self.chooseContent isEqualToString:cell.titleLabel.text]) {
        [cell updateCellWithState:YES];
    } else{
        [cell updateCellWithState:NO];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_currentSelectIndex!=nil&&_currentSelectIndex != indexPath) {
        NSIndexPath *  beforIndexPath = [NSIndexPath indexPathForRow:_currentSelectIndex.row inSection:0];
        //如果之前decell在当前屏幕，把之前选中cell的状态取消掉
        MVChooseTableViewCell * cell = [tableView cellForRowAtIndexPath:beforIndexPath];
        [cell updateCellWithState:NO];
        cell.titleLabel.textColor = kColorWithRGB(34, 34, 34);
    }
    MVChooseTableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.titleLabel.textColor = kColorWithRGB(255, 65, 99);
    [cell updateCellWithState:!cell.isSelected];
    self.chooseContent = cell.titleLabel.text;
    MusicModel *musicModel = [_dataArr objectAtIndex:indexPath.row];
    _currentSelectIndex = indexPath;
    _block(self.chooseContent,musicModel.kid);
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenHeight, kScreenHeight-kNavBarHeight) style:UITableViewStylePlain];
        _tableView.showsVerticalScrollIndicator = false;
        [_tableView registerClass:[MVChooseTableViewCell class] forCellReuseIdentifier:reuseIdentifier];
        // 拖动tableView时收起键盘
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        [_tableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = kViewColorNormal;
    }
    return _tableView;
}

-(void)reloadData{
    [self.tableView reloadData];
}

@end
