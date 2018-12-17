//
//  FMActivityDetailsViewController.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/11.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMActivityDetailsViewController.h"
#import "FMActivityDetailsHeaderCell.h"

#import "FMTemplateFourTableViewCell.h"
#import "FMMerchantsHomeTableViewCell.h"
#import "FMPictureWithTextCellText.h"
#import "FMPictureWithTextCellPicture.h"
#import "SCBaseSectionHeaderView.h"
#import "FMActivityDetailsFooterView.h"
#import "FMActivityWebViewCell.h"

static NSString * const reuseIdentifier = @"FMMerchantsHomeTableViewCell";
static NSString * const reuseIdentifierText = @"FMPictureWithTextCellText";
static NSString * const reuseIdentifierHeaderCell = @"FMActivityDetailsHeaderCell";
static NSString * const reuseIdentifierTemplateFour = @"FMTemplateFourTableViewCell";
static NSString * const reuseIdentifierTemplatePicture = @"FMPictureWithTextCellPicture";
static NSString * const reuseIdentifierTemplateWebView = @"FMActivityWebViewCell";

@interface FMActivityDetailsViewController ()<UITableViewDelegate,UITableViewDataSource,HuodongWebViewCellDelegate,FMPopupViewDelegate>
{
    dispatch_source_t _timer;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *itemModelArray;
@property (nonatomic, strong) BusinessHuodongModel *huodongModel;
@property (nonatomic, strong) BusinessModel *businessModel;
@property (nonatomic, copy) NSString *hd_id;
@property (nonatomic, strong) FMActivityDetailsFooterView *footerView;
@property (nonatomic, strong) NSMutableDictionary *heightAtIndexPath;

@end


@implementation FMActivityDetailsViewController
- (id)initBusinessModel:(BusinessModel *)businessModel hd_id:(NSString *)hd_id{
    if ( self = [super init] ){
        self.hd_id = hd_id;
        self.businessModel = businessModel;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.title = @"活动详情";
    [self initView];
    [self.view showLoadingViewWithText:@"加载中..."];
    [self loadActivityModel];
}

/// 获取活动数据
- (void) loadActivityModel{
    
    NSDictionary *parameter = @{@"hd_id":self.hd_id};
    [SCHttpTools getWithURLString:@"huodong/info" parameter:parameter success:^(id responseObject) {
        NSDictionary *result = responseObject;
        if (result) {
            FMGeneralModel *generalModel = [FMGeneralModel mj_objectWithKeyValues:result];
            if (generalModel.errcode==0) {
                BusinessHuodongModel *huodongModel = [BusinessHuodongModel mj_objectWithKeyValues:result[@"data"]];
                self.huodongModel = huodongModel;
                self.footerView.guanzhuButton.selected = self.huodongModel.is_follow ==0?NO:YES;
            }else{
                Toast(generalModel.message);
            }
        }
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
        [self.view dismissLoadingView];
        self.tableView.hidden = NO;
    } failure:^(NSError *error) {
        TTLog(@"---- %@",error);
        [self.tableView.mj_header endRefreshing];
        [self.view dismissLoadingView];
    }];
}

- (void) initView{
    
    MV(weakSelf)
    [Utils lz_setExtraCellLineHidden:self.tableView];
    [self.view addSubview:self.tableView];
    
    [self.view addSubview:self.footerView];
    [self.footerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
    
    self.footerView.block = ^(NSInteger idx) {
        [weakSelf handleButtonEvents:idx];
    };
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(kLinerViewHeight));
        make.left.right.equalTo(self.view);
        make.bottom.mas_equalTo(self.footerView.mas_top);
    }];
}

- (void) handleButtonEvents:(NSInteger)idx{

    switch (idx) {
        case 100:
            [self lz_make:@"客服"];
            break;
        case 101:
            [self.footerView didClickGuanZhu:self.businessModel.cp_id];
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

#pragma mark - Table view data source
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            FMActivityDetailsHeaderCell* tools = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierHeaderCell forIndexPath:indexPath];
            tools.huodongModel = self.huodongModel;
            [self activeCountDownAction:tools.timeLabel];
            return tools;
        }else{
            FMTemplateFourTableViewCell *tools = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierTemplateFour forIndexPath:indexPath];
            tools.businessModel = self.businessModel;
            return tools;
        }
    }else{
        FMActivityWebViewCell *tools = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierTemplateWebView forIndexPath:indexPath];
        tools.delegate = self;
        tools.indexPath = indexPath;
        [tools refreshWebView:self.huodongModel.hd_content indexPath:indexPath];
        return tools;
    }
}

// 多少个分组 section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

/// 返回多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        return IPHONE6_W(80);
    }else{
        if (self.heightAtIndexPath[indexPath]) {
            TTLog(@"当前高度 ----- %f",[self.heightAtIndexPath[indexPath] floatValue]);
            return [self.heightAtIndexPath[indexPath] floatValue];
        }
    }
    return UITableViewAutomaticDimension;
}

/// 点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark ====== FMTravelTableViewCellDelegate ======
- (void)updateTableViewCellHeight:(FMActivityWebViewCell *)cell andheight:(CGFloat)height andIndexPath:(NSIndexPath *)indexPath {
    if (![self.heightAtIndexPath[indexPath] isEqualToNumber:@(height)]) {
        self.heightAtIndexPath[indexPath] = @(height);
        [self.tableView reloadData];
    }
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.showsVerticalScrollIndicator = false;
        [_tableView registerClass:[FMPictureWithTextCellText class] forCellReuseIdentifier:reuseIdentifierText];
        [_tableView registerClass:[FMActivityDetailsHeaderCell class] forCellReuseIdentifier:reuseIdentifierHeaderCell];
        [_tableView registerClass:[FMTemplateFourTableViewCell class] forCellReuseIdentifier:reuseIdentifierTemplateFour];
        [_tableView registerClass:[FMMerchantsHomeTableViewCell class] forCellReuseIdentifier:reuseIdentifier];
        [_tableView registerClass:[FMPictureWithTextCellPicture class] forCellReuseIdentifier:reuseIdentifierTemplatePicture];
        [_tableView registerClass:[FMActivityWebViewCell class] forCellReuseIdentifier:reuseIdentifierTemplateWebView];
        _tableView.hidden = YES;
        [_tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
        //1 禁用系统自带的分割线
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = kWhiteColor;
        //        _tableView.rowHeight = UITableViewAutomaticDimension;
    }
    return _tableView;
}

- (NSMutableArray *)itemModelArray{
    if (!_itemModelArray) {
        _itemModelArray = [[NSMutableArray alloc] init];
        
    }
    return _itemModelArray;
}

- (FMActivityDetailsFooterView *)footerView{
    if (!_footerView) {
        _footerView = [[FMActivityDetailsFooterView alloc] init];
    }
    return _footerView;
}

#pragma mark - 倒计时计数
- (void)activeCountDownAction:(UILabel *) timeLabel {
    // 1.计算截止时间与当前时间差值
    // 倒计时的时间 测试数据
//    NSString *deadlineStr = @"2018-08-19 12:00:00";
    NSString *deadlineStr = [Utils lz_timeWithTimeIntervalString:self.huodongModel.hd_end_time];
    // 当前时间的时间戳
    NSString *nowStr = [Utils lz_getCurrentTime];
    // 计算时间差值
    NSInteger secondsCountDown = [Utils getDateDifferenceWithNowDateStr:nowStr deadlineStr:deadlineStr];
    
    // 2.使用GCD来实现倒计时 用GCD这个写有一个好处，跳页不会清零 跳页清零会出现倒计时错误的
    if (_timer == nil) {
        __block NSInteger timeout = secondsCountDown; // 倒计时时间
        
        if (timeout!=0) {
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
            dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0*NSEC_PER_SEC,  0); //每秒执行
            dispatch_source_set_event_handler(_timer, ^{
                if(timeout <= 0){ //  当倒计时结束时做需要的操作: 关闭 活动到期不能提交
                    dispatch_source_cancel(self->_timer);
                    self->_timer = nil;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        timeLabel.text = @"当前活动已结束";
                    });
                } else { // 倒计时重新计算 时/分/秒
                    NSInteger days = (int)(timeout/(3600*24));
                    NSInteger hours = (int)((timeout-days*24*3600)/3600);
                    NSInteger minute = (int)(timeout-days*24*3600-hours*3600)/60;
                    NSInteger second = timeout - days*24*3600 - hours*3600 - minute*60;
                    NSString *strTime = [NSString stringWithFormat:@"距结束还剩: %ld天 %02ld时 %02ld分 %02ld秒", days, hours, minute, second];

                    NSString *daysStr = [NSString stringWithFormat:@"%ld",days];
                    NSString *hoursStr = [NSString stringWithFormat:@"%ld",hours];
                    NSString *minuteStr = [NSString stringWithFormat:@"%ld",minute];
                    NSString *secondStr = [NSString stringWithFormat:@"%ld",second];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:strTime];
                        
                        /// 文字颜色
                        [attributedStr addAttribute:NSForegroundColorAttributeName
                                              value:kColorWithRGB(255, 175, 49)
                                              range:NSMakeRange(7, daysStr.length)];
                        // 文字颜色
                        [attributedStr addAttribute:NSForegroundColorAttributeName
                                              value:kColorWithRGB(255, 175, 49)
                                              range:NSMakeRange(9+daysStr.length, hoursStr.length)];
                        // 文字颜色
                        [attributedStr addAttribute:NSForegroundColorAttributeName
                                              value:kColorWithRGB(255, 175, 49)
                                              range:NSMakeRange(11+daysStr.length+hoursStr.length, minuteStr.length)];
                        // 文字颜色
                        [attributedStr addAttribute:NSForegroundColorAttributeName
                                              value:kColorWithRGB(255, 175, 49)
                                              range:NSMakeRange(13+daysStr.length+hoursStr.length+minuteStr.length, secondStr.length)];
                        
                        timeLabel.attributedText = attributedStr;
                    });
                    timeout--; // 递减 倒计时-1(总时间以秒来计算)
                }
            });
            dispatch_resume(_timer);
        }
    }
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
