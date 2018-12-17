//
//  FMConsumerProtectionViewController.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/5.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMConsumerProtectionViewController.h"
#import "FMConsumerProtectionCollectionViewCell.h"
static NSString* reuseIdentifier = @"FMConsumerProtectionCollectionViewCell";

@interface FMConsumerProtectionViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
{
@private
    UICollectionView * _collectionView;
    UILabel * _titleLabel;
}
@property(nonatomic,strong,readonly)UICollectionView * collectionView;
@property(nonatomic,strong,readonly)UILabel * titleLabel;
@property(nonatomic,strong)NSArray *dataArray;

/// 完成按钮
@property (nonatomic, strong) UIButton *endButton;

@end

@implementation FMConsumerProtectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initView];
}

- (void) initView{

    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.endButton];
    [self.view addSubview:self.titleLabel];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.centerY.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.endButton.mas_top).mas_offset(-12);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_offset(12);
    }];
    [self.endButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(45);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(21);
    }];
}

// MARK:- ====UICollectionViewDataSource,UICollectionViewDelegate=====
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

//每个分区有多少个数据
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.xblist.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FMConsumerProtectionCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.titleLabel.text = self.xblist[indexPath.row];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

/// 同一行的cell的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

//布局协议对应的方法实现
#pragma mark - UICollectionViewDelegateFlowLayout
//设置每个一个Item（cell）的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(kScreenWidth/3, 40);
}

//设置所有的cell组成的视图与section 上、左、下、右的间隔
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0,0,0,0);
}

//设置footer呈现的size, 如果布局是垂直方向的话，size只需设置高度，宽与collectionView一致
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    
    return CGSizeMake(0,0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return CGSizeMake(0,0);
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
//        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        //设置行间距
        flowLayout.minimumLineSpacing = 0;
        //设置列间距
        flowLayout.minimumInteritemSpacing = 0;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:[FMConsumerProtectionCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.bounces = YES;
    }
    return _collectionView;
}


- (UIButton *)endButton{
    if (!_endButton) {
        _endButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_endButton setTitle:@"完成" forState:UIControlStateNormal];
        [_endButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
        _endButton.titleLabel.font = kFontSizeMedium15;
        _endButton.backgroundColor = kColorWithRGB(255, 65, 99);
        MV(weakSelf)
        [_endButton lz_handleControlEvent:UIControlEventTouchUpInside withBlock:^{
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
        }];
    }
    return _endButton;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel lz_labelWithTitle:@"消费保障" color:kTextColor51 font:kFontSizeMedium15];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (NSArray *)dataArray{
    if (!_dataArray) {
        _dataArray = @[@"不满意退款",@"1对1服务",@"7天内选片",@"15天出精修",@"无隐形消费",@"免费送照上门",@"所有底片全送",@"婚纱礼服任选",@"产品1年包换"];
    }
    return _dataArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
