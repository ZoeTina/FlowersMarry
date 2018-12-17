//
//  FMElectronicInvitationViewController.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/9/26.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMElectronicInvitationViewController.h"
#import "FMElectronicInvitationCollectionViewCell.h"
#import "FMElectronicInvitationModel.h"
#import "FMEditInvitationViewController.h"
#import "FMChooseTemplateViewController.h"

static NSString* reuseIdentifier = @"FMElectronicInvitationCollectionViewCell";

@interface FMElectronicInvitationViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIButton        *guestButton;
@property (nonatomic, strong) UIButton        *helpButton;
/// 创建请帖按钮
@property (nonatomic, strong) UIButton        *invitationBtn;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray    *dataSource;


@property (nonatomic, strong) SCNoDataView *noDataView;
@property (nonatomic, strong) FMElectronicInvitationModel *invitationDataModel;

@end

@implementation FMElectronicInvitationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initView];
    [self.view showLoadingViewWithText:@"加载中..."];
    [self getInvitationData];
}

/// 获取电子请帖列表数据
- (void) getInvitationData{
    [SCHttpTools getWithURLString:@"invitation/GetMyLists" parameter:nil success:^(id responseObject) {
        NSDictionary *result = responseObject;
        if ([result isKindOfClass:[NSDictionary class]]) {
            FMElectronicInvitationModel *invitationDataModel = [FMElectronicInvitationModel mj_objectWithKeyValues:result];
            self.invitationDataModel = invitationDataModel;
            if (self.invitationDataModel.data.lists.count==0) {
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
    if (self.invitationDataModel.data.lists.count == 0) {
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
    return self.invitationDataModel.data.lists.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FMElectronicInvitationCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    InvitationModel *invitationModel = self.invitationDataModel.data.lists[indexPath.row];
    [cell.imagesView sd_setImageWithURL:kGetVideoURL(invitationModel.thumb) placeholderImage:kGetImage(imagePlaceholder)];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    FMEditInvitationViewController *vc = [[FMEditInvitationViewController alloc] init];
    vc.invitationModel = self.invitationDataModel.data.lists[indexPath.row];
    TTPushVC(vc);
}

- (void) initView{
    [self.view addSubview:self.headerView];
    [self.headerView addSubview:self.guestButton];
    [self.headerView addSubview:self.helpButton];
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.invitationBtn];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(84));
        make.top.left.right.equalTo(self.view);
    }];
    
    [self.guestButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.headerView);
        make.left.equalTo(self.view.mas_left).offset(89);
    }];
    
    [self.helpButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.headerView);
        make.right.equalTo(self.view.mas_right).offset(-78);
    }];
    
    [self.invitationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(-20);
    }];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.headerView.mas_bottom).offset(0);
    }];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void) handleButtonTapped:(UIButton *)sender{
    if(sender.tag == 100){
//        GuestsReplyViewController *vc = [[GuestsReplyViewController alloc] init];
//        [self.navigationController pushViewController:vc animated:YES];
    }else if(sender.tag == 101){
//        FMHelperViewController *vc = [[FMHelperViewController alloc] init];
//        [self.navigationController pushViewController:vc animated:YES];
    }else{
        FMChooseTemplateViewController *vc = [[FMChooseTemplateViewController alloc] init];
        TTPushVC(vc);
    }
}


- (UIView *)headerView{
    if(!_headerView){
        _headerView = [UIView lz_viewWithColor:kColorWithRGB(255, 65, 99)];
    }
    return _headerView;
}

- (UIButton *)guestButton{
    if (!_guestButton) {
        _guestButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_guestButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _guestButton.titleLabel.font = kFontSizeMedium13;
        _guestButton.tag = 100;
        [_guestButton setTitle:@"宾客" forState:UIControlStateNormal];
        [_guestButton setImage:kGetImage(@"tools_btn_guest") forState:UIControlStateNormal];
        MV(weakSelf);
        [_guestButton lz_handleControlEvent:UIControlEventTouchUpInside withBlock:^{
            [weakSelf handleButtonTapped:weakSelf.guestButton];
        }];
        CGFloat spacing = 6;
        //image在左，文字在右，default
        [Utils lz_setButtonTitleWithImageEdgeInsets:_guestButton postition:kMVImagePositionTop spacing:spacing];
    }
    return _guestButton;
}

- (UIButton *)helpButton{
    if (!_helpButton) {
        _helpButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_helpButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _helpButton.titleLabel.font = kFontSizeMedium13;
        _helpButton.tag = 101;
        [_helpButton setTitle:@"帮助" forState:UIControlStateNormal];
        [_helpButton setImage:kGetImage(@"tools_btn_help") forState:UIControlStateNormal];
        MV(weakSelf);
        [_helpButton lz_handleControlEvent:UIControlEventTouchUpInside withBlock:^{
            [weakSelf handleButtonTapped:weakSelf.helpButton];
        }];
        CGFloat spacing = 6;
        //image在左，文字在右，default
        [Utils lz_setButtonTitleWithImageEdgeInsets:_helpButton postition:kMVImagePositionTop spacing:spacing];
    }
    return _helpButton;
}


- (UIButton *)invitationBtn{
    if (!_invitationBtn){
        _invitationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_invitationBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_invitationBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [_invitationBtn setBackgroundImage:kGetImage(@"invitation_btn_add") forState:UIControlStateNormal];
        [_invitationBtn setTitle:@"创建请帖" forState:UIControlStateNormal];
        _invitationBtn.titleLabel.font = kFontSizeMedium13;
        _invitationBtn.tag = 102;
        MV(weakSelf);
        [_invitationBtn lz_handleControlEvent:UIControlEventTouchUpInside withBlock:^{
            [weakSelf handleButtonTapped:weakSelf.invitationBtn];
        }];
    }
    return _invitationBtn;
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
                                            tipsLabelText:@"没有相关请帖哦~"];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
