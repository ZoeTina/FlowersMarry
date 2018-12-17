//
//  FMChooseTemplateViewController.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/11/5.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMChooseTemplateViewController.h"
#import "FMElectronicInvitationCollectionViewCell.h"
#import "FMElectronicInvitationModel.h"
#import "FMPreviewTemplateViewController.h"

static NSString* reuseIdentifier = @"FMElectronicInvitationCollectionViewCell";

@interface FMChooseTemplateViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic) UICollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray     *dataSource;
@property (nonatomic, strong) SCNoDataView *noDataView;
@property (nonatomic, strong) InvitationTemplateModel *invitationTemplateModel;

@end

@implementation FMChooseTemplateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"选择模板";
    self.view.backgroundColor = kViewColorNormal;
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.left.equalTo(self.view);
    }];
    [self getInvitationData];
}

/// 获取电子请帖列表数据
- (void) getInvitationData{
    [SCHttpTools getWithURLString:@"invitation/GetTemplateLists" parameter:nil success:^(id responseObject) {
        NSDictionary *result = responseObject;
        if ([result isKindOfClass:[NSDictionary class]]) {
            InvitationTemplateModel *invitationTemplateModel = [InvitationTemplateModel mj_objectWithKeyValues:result];
            self.invitationTemplateModel = invitationTemplateModel;
            if (self.invitationTemplateModel.lists.count==0) {
                [self analysisData];
            }
        }
        [self.collectionView reloadData];
        [self.view dismissLoadingView];
    } failure:^(NSError *error) {
        TTLog(@"---- %@",error);
        [self.view dismissLoadingView];
    }];
}

- (void)analysisData {
    if (self.invitationTemplateModel.lists.count == 0) {
        self.noDataView.hidden = NO;
    }else {
        self.noDataView.hidden = YES;
    }
}

#pragma mark -
#pragma mark UICollectionView代理
//布局协议对应的方法实现
#pragma mark - UICollectionViewDelegateFlowLayout
//设置每个一个Item（cell）的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat leftAndRight = 30;
    CGFloat margin = 15;
    CGFloat itemWidth = (collectionView.width-margin-leftAndRight)*0.5;
    CGFloat itemHeight = 265;
    return CGSizeMake(itemWidth,itemHeight);
}
//设置所有的cell组成的视图与section 上、左、下、右的间隔
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(15,15,15,15);
}

// MARK:- ====UICollectionViewDataSource,UICollectionViewDelegate=====
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

//每个分区有多少个数据
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.invitationTemplateModel.lists.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FMElectronicInvitationCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    InvitationModel *invitationModel = self.invitationTemplateModel.lists[indexPath.row];
    [cell.imagesView sd_setImageWithURL:kGetVideoURL(invitationModel.thumb) placeholderImage:kGetImage(imagePlaceholder)];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    InvitationModel *invitationModel = self.invitationTemplateModel.lists[indexPath.row];
    FMPreviewTemplateViewController* vc = [[FMPreviewTemplateViewController alloc] initInvitationModel:invitationModel];
//    vc.pageType = YES;
    vc.title = @"预览模板";
    TTPushVC(vc);
}

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        //确定横向间距(设置行间距)
        flowLayout.minimumLineSpacing = 15;
        //确定纵向间距(设置列间距)
        flowLayout.minimumInteritemSpacing = 15;
        flowLayout.sectionInset = UIEdgeInsetsMake(10,15,10,0);
        flowLayout.headerReferenceSize = CGSizeMake(0, 0);
        flowLayout.footerReferenceSize = CGSizeMake(0, 0);
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,0,0,0) collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _collectionView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        [_collectionView registerClass:[FMElectronicInvitationCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
        _collectionView.scrollsToTop = true;
    }
    return _collectionView;
}

- (SCNoDataView *)noDataView {
    if (!_noDataView) {
        _noDataView = [[SCNoDataView alloc] initWithFrame:self.view.bounds
                                                imageName:@"live_k_guanzhu"
                                            tipsLabelText:@"没有相关请帖模板哦~"];
        _noDataView.userInteractionEnabled = YES;
        [self.view insertSubview:_noDataView aboveSubview:self.collectionView];
        [self.noDataView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_offset(0);
            make.centerY.mas_equalTo(self.view.mas_centerY);
            make.height.mas_equalTo(150);
        }];
    }
    return _noDataView;
}

@end
