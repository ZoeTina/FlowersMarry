//
//  FMToolsViewController.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/6/27.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMToolsViewController.h"
#import "FMToolsModel.h"
#import "FMToolsHeaderView.h"
#import "FMToolsCollectionViewCell.h"
#import "FMToolsTopCollectionViewCell.h"
/// 记礼金
#import "FMRememberViewController.h"
#import "FMRememberTaskViewController.h"
#import "FMBindPartnerViewController.h"
static NSString * const reuseIdentifier0 = @"FMToolsCollectionViewCellT";
static NSString * const reuseIdentifier1 = @"FMToolsCollectionViewCellB";

@interface FMToolsViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) FMToolsHeaderView *headerView;
@property (nonatomic, strong) NSMutableArray *itemModelArray;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation FMToolsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.itemModelArray = [FMToolsModel loadToolsDataArray];
    self.view.backgroundColor = kViewColorNormal;
    [self initView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void) initView{
    
    [self.headerView.bindButton lz_handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        Toast(@"绑定伴侣");
        FMBindPartnerViewController *vc = [[FMBindPartnerViewController alloc] init];
        TTPushVC(vc);
    }];
    
    [self.headerView.editButton lz_handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        Toast(@"编辑");
    }];
    
    [self.view addSubview:self.headerView];
    [self.view addSubview:self.collectionView];

    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        CGFloat top = IPHONE6_W(117);
        make.height.equalTo(@(top+kNavBarHeight));
    }];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(kNavBarHeight));
        make.left.equalTo(@(15));
        make.right.equalTo(self.view.mas_right).offset(-15);
        make.bottom.equalTo(@(-kTabBarHeight));
    }];
}

- (void) handleButtonEvents:(NSInteger) idx{
    if (idx==0) {
        FMRememberTaskViewController *vc = [[FMRememberTaskViewController alloc] init];
        TTPushVC(vc);
    }else if(idx==1){
        FMRememberViewController *vc = [[FMRememberViewController alloc] init];
        TTPushVC(vc);
    }
}

// MARK:- ====UICollectionViewDataSource,UICollectionViewDelegate=====
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.itemModelArray.count;
}

//每个分区有多少个数据
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    if (section==0) return self.dataArray.count;
    NSArray *sectionRow = self.itemModelArray[section];
    return sectionRow.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MV(weakSelf)
    FMToolsModel* model = self.itemModelArray[indexPath.section][indexPath.row];
    if (indexPath.section==0) {
//        FMToolsModel *model = self.dataArray[indexPath.row];
        FMToolsTopCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier0 forIndexPath:indexPath];
        [cell.button setTitle:model.imageText forState:UIControlStateNormal];
        cell.titleLabel.text = model.title;
        cell.subtitleLabel.text = model.subtitle;
        cell.button.tag = indexPath.row;
        [cell.button lz_handleControlEvent:UIControlEventTouchUpInside withBlock:^{
            [weakSelf handleButtonEvents:indexPath.row];
        }];
        return cell;
    }else{
//        FMToolsModel *model = self.itemModelArray[indexPath.row];
        FMToolsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier1 forIndexPath:indexPath];
        cell.imagesView.image = kGetImage(model.imageText);
        cell.titleLabel.text = model.title;
        cell.subtitleLabel.text = model.subtitle;
        return cell;
    }
}

/// 点击collectionViewCell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    FMToolsModel* model = self.itemModelArray[indexPath.section][indexPath.row];
    NSString *className = model.showClass;
    Class controller = NSClassFromString(className);
    //    id controller = [[NSClassFromString(className) alloc] init];
    if (controller &&  [controller isSubclassOfClass:[UIViewController class]]){
        UIViewController *vc = [[controller alloc] init];
        vc.title = model.title;
        TTPushVC(vc)
    }
}

//布局协议对应的方法实现
#pragma mark - UICollectionViewDelegateFlowLayout
//设置每个一个Item（cell）的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return CGSizeMake((kScreenWidth-30)/2, 120);
    }else{
        return CGSizeMake((kScreenWidth-30)/2, 135);
    }
}

//设置所有的cell组成的视图与section 上、左、下、右的间隔
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0,0,10,0);
}

//设置footer呈现的size, 如果布局是垂直方向的话，size只需设置高度，宽与collectionView一致
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    
    return CGSizeMake(0,0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return CGSizeMake(0,0);
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    UIBezierPath *maskPath;
    CGRect boardRect = cell.bounds;
    CGSize sizeMake = CGSizeMake(10, 10);
    float h = cell.bounds.size.height;
    float w = cell.bounds.size.width;
    NSInteger idx = self.itemModelArray.count;
    UIRectCorner Corners = UIRectCornerAllCorners;
    if (indexPath.section==0) {
        if (indexPath.row == 0) {
            boardRect = cell.bounds;
            Corners = UIRectCornerTopLeft|UIRectCornerBottomLeft;
        } else{
            boardRect = CGRectMake(-1, 0, w+1, h);
            Corners = UIRectCornerTopRight|UIRectCornerBottomRight;
        }
    }else{
        if (indexPath.row == 0) {
            Corners = UIRectCornerTopLeft;
        } else if(indexPath.row == 1){
            boardRect = CGRectMake(-1, 0, w, h);
            Corners = UIRectCornerTopRight;
        } else if (indexPath.row == idx - 2){
            boardRect = CGRectMake(0, -1, w, h);
            Corners = UIRectCornerBottomLeft;
        }else if (indexPath.row == idx - 1){
            boardRect = CGRectMake(-1, -1, w, h);
            Corners = UIRectCornerBottomRight;
        }else{
            if (indexPath.row%2==0) {
                boardRect = CGRectMake(0, -1, w, h);
            }else{
                boardRect = CGRectMake(-1, -1, w, h);
            }
            sizeMake = CGSizeMake(0, 0);
        }
    }
    
    maskPath = [[UIBezierPath bezierPathWithRoundedRect:cell.bounds byRoundingCorners:Corners cornerRadii:sizeMake] bezierPathByReversingPath];

    
    for (CALayer *layer in cell.contentView.layer.sublayers) {
        if ([layer.name isEqualToString:@"maskLayer"]) {
            [layer removeFromSuperlayer];
        }
    }
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    
    maskLayer.name = @"maskLayer";
    maskLayer.frame = boardRect;
    maskLayer.path = maskPath.CGPath;
    maskLayer.strokeColor = [UIColor clearColor].CGColor;
    /// 虚线中的实线长度和空格长度
    maskLayer.lineDashPattern = @[@4, @0];
    maskLayer.lineWidth = 1.0f;
    maskLayer.fillColor = [UIColor whiteColor].CGColor;
    maskLayer.masksToBounds = YES;
    
    [cell.contentView.layer insertSublayer:maskLayer atIndex:0];
}


- (FMToolsHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[FMToolsHeaderView alloc] init];
        _headerView.backgroundColor = [kBlackColor colorWithAlphaComponent:0.4];
    }
    return _headerView;
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        //确定滚动方向
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
//        CGFloat margin = 15+5;
//        CGFloat spacing = 0*2;
//        CGFloat widht = (kScreenWidth-margin-spacing)/2;
//        //确定item的大小
//        flowLayout.itemSize = CGSizeMake(widht, widht);
        //确定横向间距(设置行间距)
        flowLayout.minimumLineSpacing = 0;
        //确定纵向间距(设置列间距)
        flowLayout.minimumInteritemSpacing = 0;
        //确定距离上左下右的距离
        flowLayout.sectionInset = UIEdgeInsetsMake(0,15,15,30);
        //头尾部高度
        flowLayout.headerReferenceSize = CGSizeMake(0, 0);
        flowLayout.footerReferenceSize = CGSizeMake(0, 0);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = kClearColor;
        [_collectionView registerClass:[FMToolsTopCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier0];
        [_collectionView registerClass:[FMToolsCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier1];
        _collectionView.contentInset = UIEdgeInsetsMake((IPHONE6_W(156-kNavBarHeight)), 0, 0, 0);
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.bounces = YES;
    }
    return _collectionView;
}

- (NSMutableArray *)itemModelArray{
    if (!_itemModelArray) {
        _itemModelArray = [[NSMutableArray alloc] init];
//        NSArray* titleArr = @[@"结婚预算",@"结婚吉日",@"结婚登记处",@"我的宾客",@"微信婚礼墙",@"电子请帖"];
//        NSArray* imagesArr = @[@"tools_btn_jisuanqi",@"tools_btn_jiri",@"tools_btn_dengjichu",@"tools_btn_binke",@"tools_btn_weixinqiang",@"tools_btn_qingtie"];
//        NSArray* subtitleArr = @[@"全国婚姻登记查询",@"挑选结婚黄道吉日",@"全国婚姻登记查询",@"挑选结婚黄道吉日",@"全国婚姻登记查询",@"挑选结婚黄道吉日"];
//        for (int i = 0; i < titleArr.count; i ++) {
//            FMToolsModel *tools = [[FMToolsModel alloc] init];
//            tools.title = [titleArr lz_safeObjectAtIndex:i];
//            tools.imageText = [imagesArr lz_safeObjectAtIndex:i];
//            tools.subtitle = [subtitleArr lz_safeObjectAtIndex:i];
//            [_itemModelArray addObject:tools];
//        }
    }
    return _itemModelArray;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
        FMToolsModel *model=[[FMToolsModel alloc] init];
        model.title = @"结婚任务 >";
        model.subtitle = @"全国婚姻登记查询";
        model.imageText = @"记任务";
        [_dataArray addObject:model];
        
        model=[[FMToolsModel alloc] init];
        model.title = @"结婚账本 >";
        model.subtitle = @"挑选结婚黄道吉日";
        model.imageText = @"去记账";
        [_dataArray addObject:model];
    }
    return _dataArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
