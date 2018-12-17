 //
//  FMMerchantsHomeViewController.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/2.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMMerchantsHomeViewController.h"

/// 显示图片集展示
#import "FMShowPhotoCollectionViewController.h"
/// 图文详情展示
#import "FMPictureWithTextViewController.h"
/// 视频展示
#import "SCVideoPlayViewController.h"
/// 优惠
#import "FMMerchantsHomeTableViewCell.h"

#import "FMMerchantsHomeHeaderViewCell.h"
#import "FMMerchantsHomeAddressTableViewCell.h"

/// 套餐列表
#import "FMComboListTableViewCell.h"
/// 套餐详情
#import "FMComboListDetailsViewController.h"
/// 作品列表
#import "FMWorksListTableViewCell.h"
/// 作品详情页
#import "FMWorksListDetailsViewController.h"
/// 商家动态
#import "FMBusinessDynamicViewController.h"

/// 动态类型的Cell
#import "FMVideoTableViewCell.h"
#import "FMImagesTableViewCell.h"
#import "FMMoreImagesTableViewCell.h"
#import "FMImagesRightTableViewCell.h"
#import "FMImagesTransverseThreeTableViewCell.h"


/// 电话预约
#import "FMTelephoneBookingViewController.h"
/// 活动详情
#import "FMActivityDetailsViewController.h"
/// 顶部滚动图
#import "FMMerchantsHomeHeaderView.h"
/// 店铺实景
#import "FMStoreLiveTableViewCell.h"
/// 底部工具条
#import "FMActivityDetailsFooterView.h"
/// 顶部透明
#import "FMHeaderNavigationTranspView.h"

/// 弹出消费保障
#import "FMConsumerProtectionViewController.h"
/// 点评 
#import "FMEvaluationModel.h"
#import "FMEvaluationTemplateOneTableViewCell.h"
#import "FMEvaluationTemplateTwoTableViewCell.h"
#import "FMEvaluationTemplateThreeTableViewCell.h"
#import "FMEvaluationTemplateFourTableViewCell.h"


#import "SCPublishBaseController.h"
#import "SCPublishCommentsViewController.h"

/// 空数据cell
#import "SCEmptyDataTableViewCell.h"

#import "FMGeneralModel.h"

/// 套餐列表
#import "TTComboListViewController.h"
/// 作品列表
#import "TTWorksListViewController.h"
/// 点评列表
#import "FMEvaluationListViewController.h"
/// 商家动态
#import "TTBusinessDynamicViewController.h"

/// 点评
static NSString * const reuseIdentifierOne = @"FMEvaluationTemplateOneTableViewCell";
static NSString * const reuseIdentifierTwo = @"FMEvaluationTemplateTwoTableViewCell";
static NSString * const reuseIdentifierThree = @"FMEvaluationTemplateThreeTableViewCell";
static NSString * const reuseIdentifierFour = @"FMEvaluationTemplateFourTableViewCell";

static NSString * const reuseIdentifier = @"FMMerchantsHomeTableViewCell";
static NSString * const reuseIdentifierHeaderView = @"FMMerchantsHomeHeaderView";
static NSString * const reuseIdentifierHeaderCell = @"FMMerchantsHomeHeaderCell";
static NSString * const reuseIdentifierCombination = @"FMComboListTableViewCell";
static NSString * const reuseIdentifierWorksList = @"FMWorksListTableViewCell";
static NSString * const reuseIdentifierAddress = @"FMMerchantsHomeAddressTableViewCell";
static NSString * const reuseIdentifierSectionHeaderView = @"SCTableViewSectionHeaderView";
static NSString * const reuseIdentifierSectionFooterView = @"SCTableViewSectionFooterView";

/// 空数据cell
static NSString * const reuseIdentifierEmptyData = @"SCEmptyDataTableViewCell";

/// 动态
static NSString * const reuseIdentifierVideo = @"FMVideoTableViewCell";
static NSString * const reuseIdentifierImage = @"FMImagesTableViewCell";
static NSString * const reuseIdentifierMoreImage = @"FMMoreImagesTableViewCell";
static NSString * const reuseIdentifierRightImage = @"FMImagesRightTableViewCell";
static NSString * const reuseIdentifierThreeImage = @"FMImagesTransverseThreeTableViewCell";
/// 实景
static NSString * const reuseIdentifierStoreLive = @"FMStoreLiveTableViewCell";

#define kHeaderHeight 250
@interface FMMerchantsHomeViewController ()<UITableViewDelegate,UITableViewDataSource,FMStoreLiveTableViewCellDelegate,
FMMerchantsHomeHeaderViewCellDelegate,FMPopupViewDelegate>
@property (nonatomic, strong) UITableView *tableView;

//// 礼包和劵的数组
@property (nonatomic, strong) NSMutableArray *itemModelArray;
/// 当前商家信息
@property (nonatomic, strong) BusinessModel *businessModel;
/// 底部View
@property (nonatomic, strong) FMActivityDetailsFooterView *footerView;
/// 头部View
@property (nonatomic, strong) FMHeaderNavigationTranspView *headerView;

/// 底部工具栏
@property (nonatomic, strong) UIView *bottomView;
/// 顶部试图
@property (nonatomic, strong) UIView *headerNavigationView;

/// 点评列表
@property (nonatomic, strong) EvaluationDataModel *evaluationListModel;
/// 商家动态
@property (nonatomic, strong) NSMutableArray *dynamicDataArray;

@property (nonatomic,strong) dispatch_group_t disGroup;

/// 动态数据总数
@property (nonatomic, assign) NSInteger totalCountDynamic;

@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, assign) NSInteger pageSize;
@property (nonatomic, copy) NSString *cp_id;
@end

@implementation FMMerchantsHomeViewController
- (id)initBusinessModel:(BusinessModel *)businessModel{
    if ( self = [super init] ){
        self.cp_id = businessModel.cp_id;
        self.pageSize = 10;
        self.pageIndex = 1;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initView];
    /// 商家基本信息获取
    [self loadBusinesInfoData];
    /// 商家动态数据获取
    [self loadBusinessdDynamicModel];
    [self.view showLoadingViewWithText:@"加载中..."];

    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.pageIndex++;// 页码+1
        [self loadBusinessdDynamicModel];
    }];
}

- (void)viewWillAppear:(BOOL)animated{
    self.view.backgroundColor = kWhiteColor;
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void) loadBusinesInfoData{
    
//    self.businessModel.cp_id = @"24058";
    //// 商家信息
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setObject:self.cp_id forKey:@"cp_id"];
    [parameter setObject:@(1) forKey:@"has_ct"];
    [parameter setObject:@(1) forKey:@"has_tx"];
    [parameter setObject:@(1) forKey:@"has_case"];
    [parameter setObject:@(1) forKey:@"has_hd"];
    [SCHttpTools getWithURLString:@"company/info" parameter:parameter success:^(id responseObject) {
        NSDictionary *result = responseObject;
        if ([result isKindOfClass:[NSDictionary class]]) {
            FMGeneralModel *generalModel = [FMGeneralModel mj_objectWithKeyValues:result];
            if (generalModel.errcode == 0) {
                BusinessModel *businessModel = [BusinessModel mj_objectWithKeyValues:result[@"data"]];
                self.businessModel = businessModel;
                [self dealwithBusinessModel];
            }else{
                Toast(generalModel.message);
            }
        }
        self.footerView.guanzhuButton.selected = self.businessModel.is_follow==0?YES:NO;
        [self.tableView reloadData];
        self.tableView.hidden = NO;
        [self.view dismissLoadingView];
    } failure:^(NSError *error) {
        TTLog(@"---- %@",error);
        [self.view dismissLoadingView];
    }];
}

/// 处理显示商家基本数据
- (void) dealwithBusinessModel{
    self.headerView.titleLabel.text = self.businessModel.cp_fullname;
    if (self.businessModel.youhui.gift.title.length != 0) {
        [self.itemModelArray addObject:self.businessModel.youhui.gift];
    }
    
    if (!kObjectIsEmpty(self.businessModel.youhui.coupon)) {
        [self.itemModelArray addObject:self.businessModel.youhui.coupon];
    }
}

/// 获取商家的动态数据
- (void) loadBusinessdDynamicModel{
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setObject:kUserInfo.site_id forKey:@"site_id"];
    [parameter setObject:self.cp_id forKey:@"cp_id"];
    [parameter setObject:@(self.pageSize) forKey:@"size"];
    [parameter setObject:@(self.pageIndex) forKey:@"p"];
    TTLog(@"parameter --- %@",parameter);
    [SCHttpTools getWithURLString:@"feed/getlist" parameter:parameter success:^(id responseObject) {
        NSDictionary *result = responseObject;
        if ([result isKindOfClass:[NSDictionary class]]) {
            FMDynamicModel *model = [FMDynamicModel mj_objectWithKeyValues:result];
            if (model.errcode == 0) {
                if (self.pageIndex==1) {
                    self.totalCountDynamic = model.data.totalCount;
                    [self.dynamicDataArray removeAllObjects];
                }
                [self.dynamicDataArray addObjectsFromArray:model.data.list];
            }else {
                Toast([result lz_objectForKey:@"message"]);
            }
            NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:6];
            [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
            [self.tableView.mj_footer endRefreshing];
        }
    } failure:^(NSError *error) {
        TTLog(@" -- error -- %@",error);
        [self.tableView.mj_footer endRefreshing];
    }];
}

/// 预约商家或者领劵和优惠
- (void) loadConventionRequest:(NSString *)type{
    [MBProgressHUD showMessage:@"" toView:kKeyWindow];
    /// 类型  1:预约看店,3:优惠领取,10:客服,11:动态信息
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setObject:self.businessModel.cp_id forKey:@"cp_id"];
    [parameter setObject:kUserInfo.mobile forKey:@"mobile"];
    [parameter setObject:type forKey:@"type"];
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

- (void) handleButtonEvents:(NSInteger) idx{
    /// idx ? 100:客服 101:关注 102:评论 103:免费预约 104:返回按钮 105:分享
    switch (idx) {
        case 100:
            [self lz_make:@"客服"];
            break;
        case 101:
            [self.footerView didClickGuanZhu:self.businessModel.cp_id];
            break;
        case 102:
            [self jumpCommentsViewController];
            break;
        case 103:
            [self loadConventionRequest:@"1"];
            break;
        case 104:
            [self.navigationController popViewControllerAnimated:YES];
            break;
        case 105:
            [self lz_make:@"分享"];
            break;
        default:
            break;
    }
}

/// 跳转点评
- (void) jumpCommentsViewController{
    SCPublishCommentsViewController *vc = [[SCPublishCommentsViewController alloc] initBusinessModel:self.businessModel];
    [self.navigationController pushViewController:vc animated:YES];
}

/// 跳转活动详情
- (void) jumpActivityDetailsController:(NSInteger) idx{
    BusinessHuodongModel *huodongModel = self.businessModel.huodongs[idx];
    FMActivityDetailsViewController *vc = [[FMActivityDetailsViewController alloc] initBusinessModel:self.businessModel hd_id:huodongModel.hd_id];
    TTPushVC(vc);
}

#pragma mark - Table view data sourceFMMerchantsHomeAddressTableViewCell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MV(weakSelf)
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            FMMerchantsHomeHeaderView  *tools = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierHeaderView forIndexPath:indexPath];
            tools.listModel = self.businessModel.huodongs;
            [tools setImagesTemmpletCellCallBlock:^(NSInteger idx) {
                [weakSelf jumpActivityDetailsController:idx];
            }];
            return tools;
        }else if (indexPath.row==1) {
            FMMerchantsHomeHeaderViewCell *tools = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierHeaderCell forIndexPath:indexPath];
            tools.delegate = self;
            if (self.businessModel!=nil) {
                tools.businessModel = self.businessModel;
            }
            return tools;
        }else{
            FMMerchantsHomeAddressTableViewCell *tools = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierAddress forIndexPath:indexPath];
            tools.titleLabel.text = self.businessModel.cp_address;
            return tools;
        }
    }else if(indexPath.section==1){
        BusinessYouHuiModel *youhui = self.businessModel.youhui;
        FMMerchantsHomeTableViewCell* tools = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
        if (indexPath.row==0) {
            tools.lineView.hidden = YES;
            if (youhui.coupon.num != 0) {
                tools.imagesView.image = kGetImage(@"base_merchant_coupon");
                tools.titleLabel.text = youhui.coupon.title;
            }else{
                tools.titleLabel.text = youhui.gift.title;
                tools.imagesView.image = kGetImage(@"base_merchant_gift");
            }
        }else{
            if (youhui.gift.title.length != 0) {
                tools.titleLabel.text = youhui.gift.title;
                tools.imagesView.image = kGetImage(@"base_merchant_gift");
            }
        }
        return tools;
    }else{
        if (indexPath.section==2) { /// 套餐
            FMComboListTableViewCell *tools = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierCombination forIndexPath:indexPath];
            BusinessTaoxiModel *taoxi = self.businessModel.taoxis[indexPath.row];
            tools.taoxiModel = taoxi;
            if (indexPath.row != 0) {
                tools.linerViewCell.hidden = NO;
            }
            return tools;
        }else if(indexPath.section==3){ /// 作品
            FMWorksListTableViewCell *tools = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierWorksList forIndexPath:indexPath];
            tools.casesModel = self.businessModel.cases[indexPath.row];
            return tools;
        }else if(indexPath.section==4){ /// 店铺实景
            FMStoreLiveTableViewCell *tools = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierStoreLive forIndexPath:indexPath];
            tools.delegate = self;
            tools.listModel = self.businessModel.shijing;
            return tools;
        }else if(indexPath.section==5){ /// 评论
            /// 0:评论 1:评论+回复 2:评论+图片 3:评论+图片+回复
            BusinessComment *evaluationModel = self.businessModel.comments[indexPath.row];
            if (evaluationModel.ct_re_content.length>0 && evaluationModel.photo.count==0) {/// 评论+回复
                FMEvaluationTemplateFourTableViewCell* tools = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierFour forIndexPath:indexPath];
                tools.evaluationModel = evaluationModel;
                return tools;
            }else if (evaluationModel.photo.count>0 && evaluationModel.ct_re_content.length==0){/// 评论+图片
                FMEvaluationTemplateThreeTableViewCell* tools = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierThree forIndexPath:indexPath];
                tools.evaluationModel = evaluationModel;
                return tools;
            }else if (evaluationModel.ct_re_content.length>0&&evaluationModel.photo.count>0){/// 评论+图片+回复
                FMEvaluationTemplateTwoTableViewCell* tools = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierTwo forIndexPath:indexPath];
                tools.evaluationModel = evaluationModel;
                return tools;
            }else{  /// 纯文字
                FMEvaluationTemplateOneTableViewCell* tools = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierOne forIndexPath:indexPath];
                tools.evaluationModel = evaluationModel;
                return tools;
            }
        }else {
            if (self.dynamicDataArray.count>0) {
                DynamicModel *dynamicModel = self.dynamicDataArray[indexPath.row];
                switch (dynamicModel.shape) {
                    case 1: {/// 图文
                        if (dynamicModel.thumb_num==1) {/// 图文  ---  1:一张封面图
                            FMImagesRightTableViewCell* tools = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierRightImage forIndexPath:indexPath];
                            tools.dynamicModel = dynamicModel;
                            return tools;
                        }else{
                            FMImagesTransverseThreeTableViewCell* tools = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierThreeImage forIndexPath:indexPath];
                            tools.dynamicModel = dynamicModel;
                            return tools;
                        }
                    }
                        break;
                    case 2: {/// 图集  ---  1:一张封面图
                        if (dynamicModel.thumb_num==1) {
                            FMImagesTableViewCell* tools = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierImage forIndexPath:indexPath];
                            tools.dynamicModel = dynamicModel;
                            return tools;
                        }else{
                            FMMoreImagesTableViewCell* tools = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierMoreImage forIndexPath:indexPath];
                            tools.dynamicModel = dynamicModel;
                            return tools;
                        }
                    }
                    case 3: {/// 视频
                        FMVideoTableViewCell* tools = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierVideo forIndexPath:indexPath];
                        tools.dynamicModel = dynamicModel;
                        return tools;
                    }
                }
            }else{
                SCEmptyDataTableViewCell* tools = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierEmptyData forIndexPath:indexPath];
                return tools;
            }
            return [UITableViewCell new];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0&&indexPath.row==0) {
        if (self.businessModel.huodongs.count>0) return IPHONE6_W(250);
    }else if (indexPath.section==0&&indexPath.row==1) {
        CGFloat height = self.businessModel.xblist.count==0?80:124;
        return height;
    }else if (indexPath.section==2) {
        return IPHONE6_W(132);
    }else if (indexPath.section==3){
        if (indexPath.row==2) return IPHONE6_W(335);
        return IPHONE6_W(323);
    }else if (indexPath.section==4){
        return IPHONE6_W(113);
    }else if (indexPath.section==6){
        if (self.dynamicDataArray.count==0) {
            return 400;
        }
    }
    return UITableViewAutomaticDimension;
}

// 多少个分组 section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 7;
}

/// 返回多少
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return 3;
            break;
        case 1:
            return self.itemModelArray.count;
            break;
        case 2:
            // 套餐
            return self.businessModel.taoxis.count;
            break;
        case 3:
            /// 作品
            return self.businessModel.cases.count;
            break;
        case 4:
            /// 店铺实景
            return 1;
            break;
        case 5:
            /// 评论
            return self.businessModel.comments.count;
            break;
        case 6:
            /// 动态
            return self.dynamicDataArray.count==0?1:self.dynamicDataArray.count;
            break;
        default:
            return 1;
            break;
    }
}

#pragma mark -------------- 设置Header高度 --------------
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0||section==1) return 0.0f;
    return 44.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==6) return 0.1f;
    if (section==1 && (self.itemModelArray.count ==0)) return 0.1f;
    return 10.f;
}

#pragma mark -------------- 设置组头 --------------
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section==0||section==1) {
        return nil;
    }
    SCTableViewSectionHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:reuseIdentifierSectionHeaderView];
    NSString *titleTextStr = @"";
    NSString *subtitleTestStr = @"";
    if (section==2) {
        titleTextStr = @"精品套餐";
        subtitleTestStr = [self setSubtitleValue:self.businessModel.taoxis.count unit:@"个"];
    }else if (section==3) {
        titleTextStr = @"作品精选";
        subtitleTestStr = [self setSubtitleValue:self.businessModel.cases.count unit:@"个"];
    }else if (section==4) {
        titleTextStr = @"店铺实景";
    }else if (section==5) {
        titleTextStr = @"网友点评";
        subtitleTestStr = [self setSubtitleValue:self.evaluationListModel.count unit:@"条"];
    }else if (section==6) {
        titleTextStr = @"商家动态";
        subtitleTestStr = [self setSubtitleValue:self.totalCountDynamic unit:@"条"];
    }
    if (section==4) {
        headerView.arrowImageView.hidden = YES;
    }else{
        headerView.arrowImageView.hidden = NO;
    }
    headerView.titleLabel.text = titleTextStr;
    headerView.subtitleLabel.text = subtitleTestStr;
    MV(weakSelf)
    [headerView.sectionButton lz_handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        [weakSelf jumpListViewController:section];
    }];
    return headerView;
}

- (void) jumpListViewController:(NSInteger) idx{
    switch (idx) {
        case 2:
        {
            TTComboListViewController *vc = [[TTComboListViewController alloc] initBusinessModel:self.businessModel];
            TTPushVC(vc);
        }
            break;
        case 3:
        {
            TTWorksListViewController *vc = [[TTWorksListViewController alloc] initBusinessModel:self.businessModel];
            TTPushVC(vc);
        }
            break;
        case 5:
        {
            FMEvaluationListViewController *vc = [[FMEvaluationListViewController alloc] initBusinessModel:self.businessModel];
            TTPushVC(vc);
        }
            break;
        case 6:
        {
            TTBusinessDynamicViewController *vc = [[TTBusinessDynamicViewController alloc] initBusinessModel:self.businessModel];
            TTPushVC(vc);
        }
            break;
        default:
            break;
    }
}


- (NSString *) setSubtitleValue:(NSInteger )count unit:(NSString *)unit{
    return [NSString stringWithFormat:@"共%ld%@",(long)count,unit];
}

// UITableView在Plain类型下，HeaderView和FooterView不悬浮和不停留的方法
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView lz_viewWithColor:kTableViewInSectionColor];
}

#pragma mark -------------- 当前列表Cell点击 --------------
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BusinessModel *businessModel = self.businessModel;
    if(indexPath.section==1){
        [self loadConventionRequest:@"3"];
    } else if(indexPath.section==2){
        BusinessTaoxiModel *taoxiModel =  self.businessModel.taoxis[indexPath.row];
        FMComboListDetailsViewController *vc = [[FMComboListDetailsViewController alloc]init];
        taoxiModel.cp_id = businessModel.cp_id;
        vc.taoxiDataModel = taoxiModel;
        TTPushVC(vc);
    }else if (indexPath.section==3) {
        BusinessCasesModel *casesModel = self.businessModel.cases[indexPath.row];
        FMWorksListDetailsViewController *vc = [[FMWorksListDetailsViewController alloc] init];
        vc.casesDadaModel = casesModel;
        TTPushVC(vc);
    }else if(indexPath.section==6){
        DynamicModel *model = self.dynamicDataArray[indexPath.row];
        switch (model.shape) {
            case 1:/// 图文
            {
                FMPictureWithTextViewController *vc = [[FMPictureWithTextViewController alloc] initHomeDataModel:model];
                TTPushVC(vc);
            }
                break;
            case 2:/// 图集
            {
                FMShowPhotoCollectionViewController *vc = [[FMShowPhotoCollectionViewController alloc] initHomeDataModel:model];
                TTPushVC(vc);
            }
                break;
            case 3:/// 视频
            {
                SCVideoPlayViewController *vc = [[SCVideoPlayViewController alloc] initHomeDataModel:model];
                TTPushVC(vc);
            }
                break;
        }
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//点击UICollectionViewCell的代理方法
#pragma mark -------------- 网友点评图片点击 --------------
- (void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath withContent:(NSString *)content {
    [self lz_make:[NSString stringWithFormat:@"网友点评第 %ld 张图片",(long)indexPath.row]];
}

#pragma mark -------------- 店铺实景点击事件 --------------
- (void)didSelectStoreLiveItemAtIndexPath:(NSIndexPath *)indexPath {
    TTLog(@"店铺实景点击事件 --- %ld",(long)indexPath.row);
    [self lz_make:[NSString stringWithFormat:@"店铺实景第 %ld 张图片",(long)indexPath.row]];
}

#pragma mark -------------- 消费保障点击事件 --------------
- (void)didSelectSecurityItemAtIndexPath:(NSIndexPath *)indexPath withContent:(NSString *)content {
    FMConsumerProtectionViewController *vc = [[FMConsumerProtectionViewController alloc] init];
    vc.xblist = self.businessModel.xblist;
    [self sc_bottomPresentController:vc presentedHeight:252 completeHandle:^(BOOL presented) {
        if (presented) {
            TTLog(@"弹出了");
        }else{
            TTLog(@"消失了");
        }
    }];
}


#pragma mark -------------- 设置约束  --------------
- (void) initView{

    [self.view addSubview:self.tableView];
    
    [self.view addSubview:self.headerNavigationView];
    [self.headerNavigationView addSubview:self.headerView];
    
    [self.view addSubview:self.bottomView];
    [self.bottomView addSubview:self.footerView];
    
    [self.headerNavigationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(kNavBarHeight);
    }];
    
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.headerNavigationView);
        make.height.mas_equalTo(kNavBarHeight);
    }];
    
    CGFloat bottomHeight= 50 + kSafeAreaBottomHeight;
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(bottomHeight);
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.mas_equalTo(self.bottomView.mas_top);
    }];
    
    [self.footerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.mas_equalTo(self.bottomView);
        make.height.mas_equalTo(bottomHeight-kSafeAreaBottomHeight);
    }];
}

#pragma mark -------------- 懒加载 --------------
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.showsVerticalScrollIndicator = false;
        // 拖动tableView时收起键盘
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[SCTableViewSectionHeaderView class] forHeaderFooterViewReuseIdentifier:reuseIdentifierSectionHeaderView];
        [_tableView registerClass:[SCTableViewSectionFooterView class] forHeaderFooterViewReuseIdentifier:reuseIdentifierSectionFooterView];
        
        [_tableView registerClass:[FMMerchantsHomeTableViewCell class] forCellReuseIdentifier:reuseIdentifier];
        [_tableView registerClass:[FMMerchantsHomeHeaderView class] forCellReuseIdentifier:reuseIdentifierHeaderView];
        [_tableView registerClass:[FMMerchantsHomeAddressTableViewCell class] forCellReuseIdentifier:reuseIdentifierAddress];
        [_tableView registerClass:[FMMerchantsHomeHeaderViewCell class] forCellReuseIdentifier:reuseIdentifierHeaderCell];
        [_tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
        /// 套餐
        [_tableView registerClass:[FMComboListTableViewCell class] forCellReuseIdentifier:reuseIdentifierCombination];
        /// 作品
        [_tableView registerClass:[FMWorksListTableViewCell class] forCellReuseIdentifier:reuseIdentifierWorksList];

        /// 商家动态
        [_tableView registerClass:[FMVideoTableViewCell class] forCellReuseIdentifier:reuseIdentifierVideo];
        [_tableView registerClass:[FMImagesTableViewCell class] forCellReuseIdentifier:reuseIdentifierImage];
        [_tableView registerClass:[FMMoreImagesTableViewCell class] forCellReuseIdentifier:reuseIdentifierMoreImage];
        [_tableView registerClass:[FMImagesRightTableViewCell class] forCellReuseIdentifier:reuseIdentifierRightImage];
        [_tableView registerClass:[FMImagesTransverseThreeTableViewCell class] forCellReuseIdentifier:reuseIdentifierThreeImage];
        /// 店铺实景
        [_tableView registerClass:[FMStoreLiveTableViewCell class] forCellReuseIdentifier:reuseIdentifierStoreLive];
        
        /// 点评
        [_tableView registerClass:[FMEvaluationTemplateOneTableViewCell class] forCellReuseIdentifier:reuseIdentifierOne];
        [_tableView registerClass:[FMEvaluationTemplateTwoTableViewCell class] forCellReuseIdentifier:reuseIdentifierTwo];
        [_tableView registerClass:[FMEvaluationTemplateThreeTableViewCell class] forCellReuseIdentifier:reuseIdentifierThree];
        [_tableView registerClass:[FMEvaluationTemplateFourTableViewCell class] forCellReuseIdentifier:reuseIdentifierFour];
        
        /// 空数据Cell
        [_tableView registerClass:[SCEmptyDataTableViewCell class] forCellReuseIdentifier:reuseIdentifierEmptyData];
        _tableView.hidden = YES;
        //1 禁用系统自带的分割线
        //        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = kWhiteColor;
        _tableView.rowHeight = UITableViewAutomaticDimension;
    }
    return _tableView;
}

- (NSMutableArray *)dynamicDataArray{
    if (!_dynamicDataArray) {
        _dynamicDataArray = [[NSMutableArray alloc] init];
    }
    return _dynamicDataArray;
}

- (NSMutableArray *)itemModelArray{
    if (!_itemModelArray) {
        _itemModelArray = [[NSMutableArray alloc] init];
    }
    return _itemModelArray;
}

- (UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [UIView lz_viewWithColor:kWhiteColor];
    }
    return _bottomView;
}

- (FMActivityDetailsFooterView *)footerView{
    if (!_footerView) {
        _footerView = [[FMActivityDetailsFooterView alloc] init];
        [_footerView.shangpuButton setTitle:@"评论" forState:UIControlStateNormal];
        [_footerView.shangpuButton setImage:kGetImage(@"live_btn_pinglun") forState:UIControlStateNormal];
        MV(weakSelf)
        _footerView.block = ^(NSInteger idx) {
            [weakSelf handleButtonEvents:idx];
        };
    }
    return _footerView;
}

- (UIView *)headerNavigationView{
    if (!_headerNavigationView) {
        _headerNavigationView = [UIView lz_viewWithColor:kClearColor];
    }
    return _headerNavigationView;
}

- (FMHeaderNavigationTranspView *)headerView{
    if (!_headerView) {
        _headerView = [[FMHeaderNavigationTranspView alloc] init];
        MV(weakSelf)
        _headerView.block = ^(NSInteger idx) {
            [weakSelf handleButtonEvents:idx];
        };
    }
    return _headerView;
}

/**
 *  处理滚动改变frame
 *
 *  @param scrollView scrollView代理
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > 0) {
        if (offsetY >= kNavBarHeight) {
            self.headerView.backgroundColor = kWhiteColor;
//            [self.headerView.backButton setImage:kGetImage(@"business_back") forState:UIControlStateNormal];
//            [self.headerView.shareButton setImage:kGetImage(@"mine_nav_share") forState:UIControlStateNormal];
            [self.headerView.backButton setImage:kGetImage(@"live_btn_back") forState:UIControlStateNormal];
            [self.headerView.shareButton setImage:kGetImage(@"live_btn_share_s") forState:UIControlStateNormal];
            self.headerView.titleLabel.textColor = kTextColor51;
        } else {
            CGFloat alpha = MIN(1, 1 - ((kNavBarHeight - offsetY) / kNavBarHeight));
            self.headerView.backgroundColor = [kWhiteColor colorWithAlphaComponent:alpha];
            [self.headerView.backButton setImage:kGetImage(@"live_btn_back") forState:UIControlStateNormal];
            [self.headerView.shareButton setImage:kGetImage(@"live_btn_share_s") forState:UIControlStateNormal];
            self.headerView.titleLabel.textColor = kClearColor;
        }
    }else{
        self.headerView.backgroundColor = [kWhiteColor colorWithAlphaComponent:0];
    }
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
