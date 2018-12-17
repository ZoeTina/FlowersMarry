//
//  FMWorksListDetailsViewController.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/6.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMWorksListDetailsViewController.h"
#import "FMPictureWithTextCellPicture.h"
#import "FMPictureWithTextCellText.h"
#import "FMViewForHeaderInSectionTableViewCell.h"
#import "FMConsumerProtectionViewController.h"
#import "FMTemplateOneTableViewCell.h"
#import "FMTemplateFourTableViewCell.h"
/// 套餐列表
#import "FMComboListTableViewCell.h"
/// 作品列表
#import "FMWorksListTableViewCell.h"
#import "FMActivityDetailsFooterView.h"
#import "FMCombinationDetailsModel.h"
#import "FMComboListDetailsViewController.h"

static NSString * const reuseIdentifierWorksList = @"FMWorksListTableViewCell";
static NSString * const reuseIdentifierSectionHeaderView = @"SCTableViewSectionHeaderView";

static NSString * const reuseIdentifierTemplateOne = @"FMTemplateOneTableViewCell";
static NSString * const reuseIdentifierTemplateFour = @"FMTemplateFourTableViewCell";

static NSString * const reuseIdentifierTemplatePicture = @"FMPictureWithTextCellPicture";
static NSString * const reuseIdentifierText = @"FMPictureWithTextCellText";
static NSString * const reuseIdentifierInSection = @"FMViewForHeaderInSectionTableViewCell";
static NSString * const reuseIdentifierCombination = @"FMComboListTableViewCell";

@interface FMWorksListDetailsViewController ()<UITableViewDelegate,UITableViewDataSource,FMPopupViewDelegate>
@property (nonatomic, strong) UITableView *tableView;

/// 底部工具栏
@property (nonatomic, strong) FMActivityDetailsFooterView *footerView;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) BusinessCasesModel *casesModel;

@property (nonatomic, strong) NSMutableDictionary *heightAtIndexPath;

@end

@implementation FMWorksListDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"作品详情";
    [self initView];
    [self.view showLoadingViewWithText:@"加载中..."];
}

- (void)setCasesDadaModel:(BusinessCasesModel *)casesDadaModel{
    _casesDadaModel = casesDadaModel;
    [self loadCaseDetailsModel];
}

/// 获取作品详情数据
- (void) loadCaseDetailsModel{
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setObject:self.casesDadaModel.case_id forKey:@"case_id"];
    [parameter setObject:@"1" forKey:@"has_tx"];
    [parameter setObject:@"1" forKey:@"has_yh"];
    [parameter setObject:@"1" forKey:@"has_case"];
    [SCHttpTools getWithURLString:@"zuo_pin/info" parameter:parameter success:^(id responseObject) {
        NSDictionary *results = responseObject;
        if (results) {
            FMGeneralModel *genralModel = [FMGeneralModel mj_objectWithKeyValues:results];
            if (genralModel.errcode==0) {
                BusinessCasesModel *casesModel = [BusinessCasesModel mj_objectWithKeyValues:results[@"data"]];
                self.casesModel = casesModel;
            }else{
                Toast(genralModel.message);
            }
            [self.tableView reloadData];
            [self.view dismissLoadingView];
            self.tableView.hidden = NO;
        }
    } failure:^(NSError *error) {
        TTLog(@"---- %@",error);
        [self.view dismissLoadingView];
    }];
}

- (void) handleButtonEvents:(NSInteger)idx{
    /// 100:评论按钮 101:点赞按钮 102:客服按钮 103:预约按钮
    switch (idx) {
        case 100:
            [self lz_make:@"客服"];
            break;
        case 101:
            [self.footerView didClickGuanZhu:self.casesDadaModel.cp_id];
            break;
        case 102:
            [self.navigationController popViewControllerAnimated:YES];
            break;
        case 103:
            [self loadConventionRequest:@"1"];
            break;
        default:
            break;
    }
}


/// 预约商家或者领劵和优惠
- (void) loadConventionRequest:(NSString *)type{
    [MBProgressHUD showMessage:@"" toView:kKeyWindow];
    /// 类型  1:预约看店,3:优惠领取,10:客服,11:动态信息
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setObject:self.casesDadaModel.cp_id forKey:@"cp_id"];
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

- (void) initView{
    [Utils lz_setExtraCellLineHidden:self.tableView];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.bottomView];
    [self.bottomView addSubview:self.footerView];

    CGFloat bottomHeight = 50 + kSafeAreaBottomHeight;
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(bottomHeight);
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(kLinerViewHeight));
        make.left.right.equalTo(self.view);
        make.bottom.mas_equalTo(self.bottomView.mas_top);
    }];
    [self.footerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_equalTo(self.bottomView);
        make.height.mas_equalTo(50);
    }];
}

#pragma mark - Table view data source
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        FMTemplateOneTableViewCell* tools = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierTemplateOne forIndexPath:indexPath];
        tools.casesModel = self.casesModel;
        return tools;
    }else if (indexPath.section == 1) {
        if (indexPath.row==0) {
            FMPictureWithTextCellText* tools = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierText forIndexPath:indexPath];
            tools.contentLable.text = self.casesModel.case_content;
            return tools;
        }else{
            NSInteger idx = 0;
            if (self.casesModel.case_content.length>0) {
                idx = 1;
            }
            BusinessCasesPhotoModel *photoModel = self.casesModel.photo[indexPath.row-idx];
            FMPictureWithTextCellPicture *tools = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierTemplatePicture forIndexPath:indexPath];
            [tools.imagesView sd_setImageWithURL:kGetImageURL(photoModel.p_filename)
                                placeholderImage:kGetImage(imagePlaceholder)
                                       completed:^(UIImage *image, NSError *error,SDImageCacheType cacheType, NSURL *imageURL) {
                                           if (image.size.height) {
                                               /**  < 图片宽度 >  */
                                               CGFloat imageW = kScreenWidth;
                                               /**  <根据比例 计算图片高度 >  */
                                               CGFloat ratio = image.size.height / image.size.width;
                                               /**  < 图片高度 + 间距 >  */
                                               CGFloat imageH = ratio * imageW;
                                               /**  < 缓存图片高度 没有缓存则缓存 刷新indexPath >  */
                                               if (![[self.heightAtIndexPath allKeys] containsObject:@(indexPath.row)]) {
                                                   [self.heightAtIndexPath setObject:@(imageH) forKey:@(indexPath.row)];
                                                   [self.tableView beginUpdates];
                                                   [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
                                                   [self.tableView endUpdates];
                                               }
                                           }
                                       }];
            return tools;
        }
    }else if (indexPath.section==2) {
        FMComboListTableViewCell *tools = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierCombination forIndexPath:indexPath];
        tools.taoxiModel = self.casesModel.taoxi;
        return tools;
    }else{
        FMWorksListTableViewCell *tools = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierWorksList forIndexPath:indexPath];
        tools.casesModel = self.casesModel.caselist[indexPath.row];
        return tools;
    }
    return [UITableViewCell new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        return IPHONE6_W(105);
    }else if(indexPath.section==1){
        if (indexPath.row>0) {
            return [[self.heightAtIndexPath objectForKey:@(indexPath.row)] floatValue];
        }
    }else if(indexPath.section==2){
        return IPHONE6_W(133);
    }else if(indexPath.section==3){
        if (indexPath.row==2) return IPHONE6_W(335);
        return IPHONE6_W(320);
    }
    return UITableViewAutomaticDimension;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.section==1)return IPHONE6_W(300);
    return UITableViewAutomaticDimension;
}

// 多少个分组 section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

/// 返回多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==1) {
        if (self.casesModel.case_content.length>0) {
            return self.casesModel.photo.count+1;
        }else{
            return self.casesModel.photo.count;
        }
    }else if(section==3){
        return self.casesModel.caselist.count>3?3:self.casesModel.caselist.count;
    } else {
        return 1;
    }
}


#pragma mark -------------- 设置Header高度 --------------
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return (section==2||section==3) ? 44.0f : 0.1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return (section==3) ? 0.f :10.f;
}

// UITableView在Plain类型下，HeaderView和FooterView不悬浮和不停留的方法
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView lz_viewWithColor:kTableViewInSectionColor];
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
        titleTextStr = @"所属套餐";
    }else if (section==3) {
        titleTextStr = @"热门作品";
    }
    headerView.arrowImageView.hidden = YES;
    headerView.titleLabel.text = titleTextStr;
    headerView.subtitleLabel.text = subtitleTestStr;
    return headerView;
}

/// 点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==2) {
//        FMComboListDetailsViewController *vc = [[FMComboListDetailsViewController alloc] initBusinessModel:self.businessModel tx_id:self.combinationModel.tx_id];
//        [self.navigationController pushViewController:vc animated:YES];
    }else if (indexPath.section==3){
//        BusinessCasesModel *listModel = self.casesModel.caselist[indexPath.row];
//        FMWorksListDetailsViewController *vc = [[FMWorksListDetailsViewController alloc] initBusinessModel:self.businessModel Case_id:listModel.case_id];
//        [self.navigationController pushViewController:vc animated:YES];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -------------- 懒加载 --------------
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.showsVerticalScrollIndicator = false;
        [_tableView registerClass:[SCTableViewSectionHeaderView class] forHeaderFooterViewReuseIdentifier:reuseIdentifierSectionHeaderView];
        
        [_tableView registerClass:[FMTemplateFourTableViewCell class] forCellReuseIdentifier:reuseIdentifierTemplateFour];
        [_tableView registerClass:[FMTemplateOneTableViewCell class] forCellReuseIdentifier:reuseIdentifierTemplateOne];
        [_tableView registerClass:[FMPictureWithTextCellPicture class] forCellReuseIdentifier:reuseIdentifierTemplatePicture];
        [_tableView registerClass:[FMPictureWithTextCellText class] forCellReuseIdentifier:reuseIdentifierText];
        [_tableView registerClass:[FMViewForHeaderInSectionTableViewCell class] forCellReuseIdentifier:reuseIdentifierInSection];
        [_tableView registerClass:[FMComboListTableViewCell class] forCellReuseIdentifier:reuseIdentifierCombination];
        [_tableView registerClass:[FMWorksListTableViewCell class] forCellReuseIdentifier:reuseIdentifierWorksList];
        _tableView.hidden = YES;
        [_tableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
        //1 禁用系统自带的分割线
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = kWhiteColor;
        //        _tableView.estimatedRowHeight = 44;
        _tableView.rowHeight = UITableViewAutomaticDimension;
    }
    return _tableView;
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
        MV(weakSelf)
        _footerView.block = ^(NSInteger idx) {
            [weakSelf handleButtonEvents:idx];
        };
    }
    return _footerView;
}

- (NSMutableDictionary *)heightAtIndexPath{
    if (!_heightAtIndexPath) {
        _heightAtIndexPath = [NSMutableDictionary dictionary];
    }
    return _heightAtIndexPath;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
