//
//  FMShowPhotoCollectionViewController.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/6/29.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMShowPhotoCollectionViewController.h"
#import "FMShowPhotoCollectionViewCell.h"
#import "TYPageControl.h"
#import "FMConsumerProtectionViewController.h"
#import "FMRecommendBusinessViewController.h"

#import "FMShowPhotoCollectionHeaderView.h"
#import "FMShowPhotoCollectionFooterView.h"

#import "FMPictureCollectionCommentsViewController.h"
#import "FMGeneralModel.h"

#import "FMMerchantsHomeViewController.h"

static NSString* resuFMShowPhotoCollectionViewCell = @"resuFMShowPhotoCollectionViewCell";
static NSString* resuFMRecommendBusinessViewController = @"resuFMRecommendBusinessViewController";

@interface FMShowPhotoCollectionViewController ()<TYCyclePagerViewDataSource,TYCyclePagerViewDelegate,UIViewControllerTransitioningDelegate,FMPopupViewDelegate>

@property (nonatomic, strong) SCSwipeUpInteractiveTransition *interactiveTransition;


@property (nonatomic, strong) TYCyclePagerView *pagerView;
@property (nonatomic, strong) TYPageControl *pageControl;
@property (nonatomic, strong) DynamicModel *dynamicModel;
@property (nonatomic, strong) DynamicModel *homeData;


@property (nonatomic, strong) FMPictureCollectionCommentsViewController *commentsVC;

@property (nonatomic, strong) FMShowPhotoCollectionHeaderView *headerView;
@property (nonatomic, strong) FMShowPhotoCollectionFooterView *footerView;


@end

@implementation FMShowPhotoCollectionViewController
- (id)initHomeDataModel:(DynamicModel *) homeData{
    if ( self = [super init] ){
        self.homeData = homeData;
        [self.view showLoadingViewWithText:@"加载中..."];
        int64_t delayInSeconds = 0.0;      // 延迟的时间
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [self getDataRequest:self.homeData.kid];
        });
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.pagerView.collectionView setContentOffset:CGPointMake(0, 0) animated:false];
    
    [self initView];

}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = kColorWithRGB(16, 16, 16);
    self.navigationController.navigationBar.hidden = YES;
}

- (void) viewDidDisappear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void) setupData{

    [self.headerView.avatarImage sd_setImageWithURL:kGetImageURL(self.dynamicModel.cp_logo) placeholderImage:kGetImage(mineAvatar)];
    self.headerView.titleLabel.text = self.dynamicModel.cp_fullname;
    [self.footerView.commentsButton setTitle:self.dynamicModel.comment_num forState:UIControlStateNormal];
    [self.footerView.likeButton setTitle:self.dynamicModel.collect_num forState:UIControlStateNormal];
    self.headerView.focusButton.selected = self.dynamicModel.is_collect==0?YES:NO;
}

/// 获取图集数据
- (void) getDataRequest:(NSString *) idx{
    
    NSString *URLString = @"feed/info";
    NSDictionary *parameter = @{@"id":idx,@"ref":@"1"};
    [SCHttpTools getWithURLString:URLString parameter:parameter success:^(id responseObject) {
        NSDictionary *result = responseObject;
        if ([result isKindOfClass:[NSDictionary class]]) {
            FMGeneralModel *genralModel = [FMGeneralModel mj_objectWithKeyValues:result];
            if (genralModel.errcode == 0) {
                DynamicModel *dynamicModel = [DynamicModel mj_objectWithKeyValues:result[@"data"]];
                TTLog(@"dynamicModel -- %ld,",(long)dynamicModel.is_follow);
                TTLog(@"dynamicModel -- %ld,",(long)self.dynamicModel.is_follow);
                self.dynamicModel = dynamicModel;
                [self setupData];
                self.view.backgroundColor = kBlackColor;
                [self addPagerView];
                self.headerView.focusButton.hidden = NO;
                /// 是否关注了当前商家(0:未关注 1:已关注)
                self.headerView.focusButton.selected = self.dynamicModel.is_follow==0?NO:YES;
                self.footerView.likeButton.selected = self.dynamicModel.is_collect==0?NO:YES;
            }else {
                Toast([result lz_objectForKey:@"message"]);
            }
        }
        [self.pagerView reloadData];
        [self.view dismissLoadingView];
    } failure:^(NSError *error) {
        TTLog(@" -- error -- %@",error);
        [self.view dismissLoadingView];
    }];
}

- (void) didClickGuanZhu{
    [MBProgressHUD showMessage:@"" toView:self.view];
    NSString *URLString = @"feed/fllow";
    NSDictionary *parameter = @{@"cp_id":self.dynamicModel.cp_id};
    [SCHttpTools getWithURLString:URLString parameter:parameter success:^(id responseObject) {
        NSDictionary *result = responseObject;
        if ([result isKindOfClass:[NSDictionary class]]) {
            if ([[result lz_objectForKey:@"errcode"] integerValue] == 0) {
                self.headerView.focusButton.selected = self.headerView.focusButton.selected?NO:YES;
            }
            Toast([result lz_objectForKey:@"message"]);
        }
        [MBProgressHUD hideHUDForView:self.view];
    } failure:^(NSError *error) {
        TTLog(@" -- error -- %@",error);
        [MBProgressHUD hideHUDForView:self.view];
    }];
}

/// 收藏当前动态
- (void) didClickLike{
    [MBProgressHUD showMessage:@"" toView:self.view];
    NSString *URLString = @"feed/collect";
    if (self.dynamicModel.gallery.count>0) {
        DynamicGalleryModel *model = self.dynamicModel.gallery[0];
        NSDictionary *parameter = @{@"id":model.feed_id};
        [SCHttpTools getWithURLString:URLString parameter:parameter success:^(id responseObject) {
            NSDictionary *result = responseObject;
            if ([result isKindOfClass:[NSDictionary class]]) {
                if ([[result lz_objectForKey:@"errcode"] integerValue] == 0) {
                    self.footerView.likeButton.selected = !self.footerView.likeButton.selected;
                    if (self.footerView.likeButton.selected) {
                        NSInteger collect_num = [self.dynamicModel.collect_num integerValue];
                        NSString *latestStr = [NSString stringWithFormat:@"%ld",collect_num+1];
                        [self.footerView.likeButton setTitle:latestStr forState:UIControlStateNormal];
                        self.headerView.focusButton.selected = YES;
                    }else{
                        [self.footerView.likeButton setTitle:self.dynamicModel.collect_num forState:UIControlStateNormal];
                    }
                }
                Toast([result lz_objectForKey:@"message"]);
            }
            [MBProgressHUD hideHUDForView:self.view];
        } failure:^(NSError *error) {
            TTLog(@" -- error -- %@",error);
            [MBProgressHUD hideHUDForView:self.view];
        }];
    }else{
        Toast(@"没有图集");
    }
}

/// 预约商家或者领劵和优惠
- (void) loadConventionRequest{
    [MBProgressHUD showMessage:@"" toView:kKeyWindow];
    /// 类型  1:预约看店,3:优惠领取,10:客服,11:动态信息
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setObject:self.dynamicModel.cp_id forKey:@"cp_id"];
    [parameter setObject:kUserInfo.mobile forKey:@"phone"];
    [parameter setObject:@"11" forKey:@"type"];
    TTLog(@"parameter --- %@",parameter);
    [SCHttpTools getWithURLString:businessBooking parameter:parameter success:^(id responseObject) {
        NSDictionary *result = responseObject;
        if ([result isKindOfClass:[NSDictionary class]]) {
            FMGeneralModel *genralModel = [FMGeneralModel mj_objectWithKeyValues:result];
            if (genralModel.errcode == 0) {
                BusinessYouHuiModel *preModel = [BusinessYouHuiModel mj_objectWithKeyValues:result[@"data"]];
                FMConventionViewController *vc = [[FMConventionViewController alloc] initYouHuiModelData:preModel];
                vc.delegate = self;
                [self presentPopupViewController:vc animationType:LZPopupViewAnimationFade];
            }else {
                Toast([result lz_objectForKey:@"message"]);
            }
        }
        [MBProgressHUD hideHUDForView:kKeyWindow];
    } failure:^(NSError *error) {
        TTLog(@" -- error -- %@",error);
        [MBProgressHUD hideHUDForView:kKeyWindow];
    }];
}

- (void)dismissedButtonClicked:(FMConventionViewController *)viewController{
    [self dismissPopupViewControllerWithanimationType:LZPopupViewAnimationFade];
}

- (void) jumpBusinessHomePage{
    BusinessModel *businessModel = [[BusinessModel alloc] init];
    businessModel.cp_id = self.dynamicModel.cp_id;
    FMMerchantsHomeViewController *vc = [[FMMerchantsHomeViewController alloc] initBusinessModel:businessModel];
    TTPushVC(vc);
}

- (void) handleButtonEvents:(NSInteger)idx{
    /// 99:商家首页 100:返回按钮 101: 关注按钮 102:评论按钮 103:点赞按钮 104:客服按钮 105:预约按钮
    switch (idx) {
        case 99:
            [self jumpBusinessHomePage];
            break;
        case 100:
            [self.navigationController popViewControllerAnimated:YES];
            break;
        case 101:
            [self didClickGuanZhu];
            break;
        case 102:
            [self popupCommentsViewController];
            break;
        case 103:
            [self didClickLike];
            break;
        case 104:
            [self lz_make:@"客服按钮"];
            break;
        case 105:
            [self loadConventionRequest];
            break;
        default:
            break;
    }
}

- (void) popupCommentsViewController{
    CGFloat height = kScreenHeight-kScreenHeight/3;
    FMPictureCollectionCommentsViewController *vc = [[FMPictureCollectionCommentsViewController alloc] initDynamicModel:self.dynamicModel.kid];
    [self sc_bottomPresentController:vc presentedHeight:height completeHandle:^(BOOL presented) {
        if (presented) {
            TTLog(@"弹出了");
        }else{
            TTLog(@"消失了");
        }
    }];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}


#pragma mark ---- 滑动关闭当前页的方法
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    return [[SCPresentedAnimation alloc]init];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    return [[SCDismissAnimation alloc]init];
}

- (id<UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator {
    return (self.interactiveTransition.isInteracting ? self.interactiveTransition : nil);
}

#pragma mark ---- 界面布局设置
- (void)initView{
    
    self.pageControl.numberOfPages = self.dynamicModel.gallery.count;
    [self.pagerView reloadData];
    [self.view insertSubview:self.footerView atIndex:2];
    [self.view insertSubview:self.headerView atIndex:3];

    
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.height.equalTo(@(kNavBarHeight));
    }];
    
    /// footer 内容区域
    CGFloat height = 102 + kSafeAreaBottomHeight;
    [self.footerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.view);
        make.height.equalTo(@(height));
    }];
}

- (void)addPagerView {
    [self.view addSubview:self.pagerView];
    [self.view sendSubviewToBack:self.pagerView];
    [self addPageControl];

    [self.pagerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.view);
    }];
    
    CGFloat y = kiPhoneX ? 54 : 20;
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(-y);
        make.centerX.equalTo(self.view);
    }];
}

- (void)pagerView:(TYCyclePagerView *)pageView didSelectedItemCell:(__kindof UICollectionViewCell *)cell atIndex:(NSInteger)index {
    TTLog(@"当前点击的第-- %ld --",(long)index);
}

#pragma mark - TYCyclePagerViewDataSource
- (NSInteger)numberOfItemsInPagerView:(TYCyclePagerView *)pageView {
    return self.dynamicModel.gallery.count+1;
}

- (UICollectionViewCell *)pagerView:(TYCyclePagerView *)pagerView cellForItemAtIndex:(NSInteger)index {
    if (index==self.dynamicModel.gallery.count) {
        FMRecommendBusinessViewController *tools = [pagerView dequeueReusableCellWithReuseIdentifier:resuFMRecommendBusinessViewController forIndex:index];
        tools.dynamicModel = self.dynamicModel;
        return tools;
    }else{
        FMShowPhotoCollectionViewCell *tools = [pagerView dequeueReusableCellWithReuseIdentifier:resuFMShowPhotoCollectionViewCell forIndex:index];
        tools.galleryModel = self.dynamicModel.gallery[index];
        return tools;
    }
}

- (TYCyclePagerViewLayout *)layoutForPagerView:(TYCyclePagerView *)pageView {
    TYCyclePagerViewLayout *layout = [[TYCyclePagerViewLayout alloc]init];
    layout.itemSize = CGSizeMake(kScreenWidth, kScreenHeight);
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.itemSpacing = 0.0;//间距
    layout.itemVerticalCenter = YES;
    layout.minimumAlpha = 0.3;
    return layout;
}

/**
 *  页面滑动方法
 *
 *  @param pageView pageView
 *  @param fromIndex 当前页数字
 *  @param toIndex 下一页数字
 */
- (void)pagerView:(TYCyclePagerView *)pageView didScrollFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    _pageControl.currentPage = toIndex;
    //[_pageControl setCurrentPage:newIndex animate:YES];
//    TTLog(@"%ld ->  %ld",fromIndex,toIndex);
    NSString *total = [NSString stringWithFormat:@"/%lu",(unsigned long)self.dynamicModel.gallery.count];
    NSString *current = [NSString stringWithFormat:@"%ld",(long)toIndex+1];
    NSString *currentIndex = [NSString stringWithFormat:@"%@%@",current,total];
    self.footerView.currentIndexLabel.text = currentIndex;
//    self.footerView.subtitleLabel.text = @"       我希望有个如你一般的人，如奔赴古城道路上阳光温柔灿烂不用时刻联系 你知道他不会走 就是最好的爱情";
    if (toIndex<self.dynamicModel.gallery.count) {
        DynamicGalleryModel *model = self.dynamicModel.gallery[toIndex];
        self.footerView.subtitleLabel.text = [NSString stringWithFormat:@"%@",model.k_description];
    }
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:currentIndex];
    /// 前面文字颜色
    [attributedStr addAttribute:NSForegroundColorAttributeName
                          value:kWhiteColor
                          range:NSMakeRange(0, current.length)];
    // 前面文字大小
    [attributedStr addAttribute:NSFontAttributeName
                    value:kFontSizeMedium19
                    range:NSMakeRange(0, current.length)];

    self.footerView.currentIndexLabel.attributedText = attributedStr;
    CGFloat footerHeight = kSafeAreaBottomHeight;
    /// 重新设置footerview高度
    /// footer 内容区域
    if (toIndex==self.dynamicModel.gallery.count) {
        footerHeight += 49;
        /// 隐藏文字内容标签
        self.footerView.currentIndexLabel.hidden = YES;
        self.footerView.subtitleLabel.hidden = YES;
    }else{
        footerHeight += 102;
        /// 显示文字内容标签
        self.footerView.currentIndexLabel.hidden = NO;
        self.footerView.subtitleLabel.hidden = NO;
    }
    [self.footerView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(footerHeight));
    }];
}


#pragma mark --- setter/getter
- (TYCyclePagerView *)pagerView{
    if (!_pagerView) {
        _pagerView = [[TYCyclePagerView alloc]  init];
        [_pagerView registerClass:[FMShowPhotoCollectionViewCell class] forCellWithReuseIdentifier:resuFMShowPhotoCollectionViewCell];
        [_pagerView registerClass:[FMRecommendBusinessViewController class] forCellWithReuseIdentifier:resuFMRecommendBusinessViewController];
        _pagerView.dataSource = self;
        _pagerView.delegate = self;
        _pagerView.isInfiniteLoop = NO;//是否回到第一页
        _pagerView.autoScrollInterval = 0;//自动轮播时间
    }
    return _pagerView;
}


- (void)addPageControl {
    TYPageControl *pageControl = [[TYPageControl alloc]init];
    //pageControl.numberOfPages = _datas.count;
    pageControl.currentPageIndicatorSize = CGSizeMake(6, 6);
    pageControl.pageIndicatorSize = CGSizeMake(12, 6);
    pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    pageControl.pageIndicatorTintColor = [UIColor grayColor];
    pageControl.pageIndicatorImage = kGetImage(@"live_gunlun_nor");
    pageControl.currentPageIndicatorImage = kGetImage(@"live_gunlun_press");
    //    pageControl.contentInset = UIEdgeInsetsMake(0, 20, 0, 20);
    //    pageControl.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    //    pageControl.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    //    [pageControl addTarget:self action:@selector(pageControlValueChangeAction:) forControlEvents:UIControlEventValueChanged];
    [_pagerView addSubview:pageControl];
    pageControl.hidden = YES;
    _pageControl = pageControl;
}

- (FMShowPhotoCollectionHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[FMShowPhotoCollectionHeaderView alloc] init];
        _headerView.backgroundColor = [kBlackColor colorWithAlphaComponent:0.4];
        MV(weakSelf)
        _headerView.headerBlock = ^(NSInteger idx) {
            [weakSelf handleButtonEvents:idx];
        };
    }
    return _headerView;
}

- (UIView *)footerView{
    if (!_footerView) {
        _footerView = [[FMShowPhotoCollectionFooterView alloc] init];
        _footerView.backgroundColor = [kBlackColor colorWithAlphaComponent:0.4];
        MV(weakSelf)
        _footerView.footerBlock = ^(NSInteger idx) {
            [weakSelf handleButtonEvents:idx];
        };
    }
    return _footerView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    TTLog(@"deallloc");
}

@end
