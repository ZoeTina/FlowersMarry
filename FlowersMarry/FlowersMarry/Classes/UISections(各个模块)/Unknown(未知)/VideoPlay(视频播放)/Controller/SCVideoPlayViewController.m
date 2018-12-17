//
//  SCVideoPlayViewController.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/9/1.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "SCVideoPlayViewController.h"
#import "FMShowPhotoCollectionHeaderView.h"
#import "FMShowPhotoCollectionFooterView.h"
#import "FMPictureCollectionCommentsViewController.h"
#import "FMMerchantsHomeViewController.h"

#import "SCVideoPlayer.h"
#import "SCPlayerConfiguration.h"

@interface SCVideoPlayViewController ()<FMPopupViewDelegate>
@property (nonatomic, strong) FMShowPhotoCollectionHeaderView *headerView;
@property (nonatomic, strong) FMShowPhotoCollectionFooterView *footerView;

@property (nonatomic, strong) DynamicModel *homeData;
@property (nonatomic, strong) DynamicModel *dynamicModel;

@property (nonatomic, strong) SCVideoPlayer *playerView;
@property (nonatomic, strong) SCPlayerConfiguration *configuration;

@end

@implementation SCVideoPlayViewController
- (id)initHomeDataModel:(DynamicModel *) homeData{
    if ( self = [super init] ){
        self.homeData = homeData;
        [self initView];
        [self.view showLoadingViewWithText:@"加载中..."];
        int64_t delayInSeconds = 0.0;      // 延迟的时间
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            self.homeData.kid = @"88783";
            [self getDataRequest:self.homeData.kid];
        });
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = kColorWithRGB(16, 16, 16);
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.playerView deallocPlayer];
}

- (void) setupData{
    [self.headerView.avatarImage sd_setImageWithURL:kGetImageURL(self.dynamicModel.cp_logo) placeholderImage:kGetImage(mineAvatar)];
    self.headerView.titleLabel.text = self.dynamicModel.cp_fullname;
    [self.footerView.commentsButton setTitle:self.dynamicModel.comment_num forState:UIControlStateNormal];
    [self.footerView.likeButton setTitle:self.dynamicModel.collect_num forState:UIControlStateNormal];
    self.headerView.focusButton.selected = self.dynamicModel.is_collect==0?YES:NO;
    self.footerView.subtitleLabel.text = self.dynamicModel.intro;
    
    _configuration = [[SCPlayerConfiguration alloc]init];
    _configuration.shouldAutoPlay = YES;     //自动播放
    _configuration.supportedDoubleTap = YES;     //支持双击播放暂停
    _configuration.shouldAutorotate = NO;   //自动旋转
    _configuration.repeatPlay = YES;     //重复播放
    _configuration.statusBarHideState = SCStatusBarHideStateFollowControls;     //设置状态栏隐藏
    //    configuration.sourceUrl = [NSURL URLWithString:@"https://video.wed114.cn/ca615fa9183643e4b24b6d0570964fca/ce1b548248e04a8fa50e9e5d3800bde5-20a5d8d98f5b3b52ec5777f8467ec649-ld.mp4"];     //设置播放数据源
    _configuration.videoGravity = SCVideoGravityResizeAspect;   //拉伸方式
    _configuration.sourceUrl = kGetVideoURL(self.dynamicModel.videoURL);
    self.playerView = [[SCVideoPlayer alloc]initWithFrame:CGRectMake(0, 0 , kScreenWidth, kScreenHeight) configuration:_configuration];
    [self.view addSubview:self.playerView];
    [self.view sendSubviewToBack:self.playerView];

//    [self.playerView startPlayVideo];
}

/// 获取相关数据
- (void) getDataRequest:(NSString *) idx{
    NSString *URLString = @"feed/info";
    NSDictionary *parameter = @{@"id":idx,@"ref":@"1"};
    [SCHttpTools getWithURLString:URLString parameter:parameter success:^(id responseObject) {
        NSDictionary *result = responseObject;
        if ([result isKindOfClass:[NSDictionary class]]) {
            FMGeneralModel *genralModel = [FMGeneralModel mj_objectWithKeyValues:result];
            if (genralModel.errcode == 0) {
                DynamicModel *dynamicModel = [DynamicModel mj_objectWithKeyValues:result[@"data"]];
                self.dynamicModel = dynamicModel;
                [self setupData];
                self.view.backgroundColor = kBlackColor;
                self.headerView.focusButton.hidden = NO;
                self.headerView.focusButton.selected = self.dynamicModel.is_follow==0?YES:NO;
                self.footerView.likeButton.selected = self.dynamicModel.is_collect==0?YES:NO;
            }else {
                Toast([result lz_objectForKey:@"message"]);
            }
        }
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
        Toast(@"没有视频");
        [MBProgressHUD hideHUDForView:self.view];
    }
}

/// 预约商家或者领劵和优惠
- (void) loadConventionRequest{
    [MBProgressHUD showMessage:@"" toView:kKeyWindow];
    /// 类型  1:预约看店,3:优惠领取,10:客服,11:动态信息
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setObject:self.dynamicModel.cp_id forKey:@"cp_id"];
    [parameter setObject:kUserInfo.mobile forKey:@"mobile"];
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

#pragma mark ---- 界面布局设置
- (void)initView{
    
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

- (SCPlayerConfiguration *)configuration{
    if (!_configuration) {
        _configuration = [[SCPlayerConfiguration alloc]init];
        _configuration.shouldAutoPlay = YES;     //自动播放
        _configuration.supportedDoubleTap = YES;     //支持双击播放暂停
        _configuration.shouldAutorotate = NO;   //自动旋转
        _configuration.repeatPlay = YES;     //重复播放
        _configuration.statusBarHideState = SCStatusBarHideStateFollowControls;     //设置状态栏隐藏
        //    configuration.sourceUrl = [NSURL URLWithString:@"https://video.wed114.cn/ca615fa9183643e4b24b6d0570964fca/ce1b548248e04a8fa50e9e5d3800bde5-20a5d8d98f5b3b52ec5777f8467ec649-ld.mp4"];     //设置播放数据源
        _configuration.videoGravity = SCVideoGravityResizeAspect;   //拉伸方式
    }
    return _configuration;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
