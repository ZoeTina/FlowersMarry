//
//  FMBasicInformationViewController.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/11/6.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMBasicInformationViewController.h"
#import "FMBasicInformationTextFieldCell.h"
#import "FMBasicInformationLabelCell.h"
#import "FMBasicInformationMapCell.h"
#import "FMPersonModel.h"
#import "FMChooseMusicViewController.h"
#import "TTTencentMapViewController.h"
#import "FMBasicInformationViewController+TencentMap.h"
#import "FMEditInvitationViewController.h"

static NSString *reuseIdentifierT = @"FMBasicInformationTextFieldCell";
static NSString *reuseIdentifierL = @"FMBasicInformationLabelCell";
static NSString *reuseIdentifierM = @"FMBasicInformationMapCell";

@interface FMBasicInformationViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIGestureRecognizerDelegate,QMapViewDelegate>
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UIView *footerView;;
@property (nonatomic, strong) InvitationModel *invitationModel;
@property (nonatomic, strong) UIButton *saveButton;
@end

@implementation FMBasicInformationViewController
- (id)initInvitationModel:(InvitationModel *)invitationModel{
    if ( self = [super init] ){
        self.invitationModel = invitationModel;
        [self loadData];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [Utils lz_setExtraCellLineHidden:self.tableView];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.saveButton];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(self.saveButton.mas_top);
    }];
    
    [self.saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.equalTo(@(44));
        make.bottom.equalTo(self.view.mas_bottom).offset(-kSafeAreaBottomHeight);
    }];
    
    [self addGesture:self.tableView];
//    [self getUserBasicInfoDataRequest];
    UIPinchGestureRecognizer *pinch = [[UIPinchGestureRecognizer alloc]init];
    pinch.delegate = self;
    [self.tableView addGestureRecognizer:pinch];
    
    self.tableView.tableFooterView = self.footerView;
    /// 设置腾讯地图
    [self initTMapView];
}

- (void)initTMapView {
    [self mapView];
    [self redPinImageView];
    [self initTencentMapLocation];
    [self.redPinImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.mapView);
    }];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer*)gestureRecognizer shouldReceiveTouch:(UITouch*)touch {
    // 判断当前View是否是百度地图的手势处理视图TapDetectingView.
    NSString *touchViewCls = NSStringFromClass([touch.view class]);
    if([touchViewCls isEqual:@"TapDetectingView"]){
        //若为百度地图的手势处理视图让TableView不滚动并相应手势
        self.tableView.scrollEnabled = NO;
        return NO;
    }
    // 取消禁止滚动
    self.tableView.scrollEnabled = YES;
    return YES;
}

- (void)loadData {
    TTLog(@"-----加载数据-----");
    self.informationModel.man = @"";
    self.informationModel.woman = @"";
    self.informationModel.mobile = @"";
    self.informationModel.barrage = 0;
    self.informationModel.music_name = @"";
    self.informationModel.date = @"";
    self.informationModel.time = @"";
    self.informationModel.address = @"";
}

- (void) getUserBasicInfoDataRequest{
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setObject:kUserInfo.site_id forKey:@"site_id"];
    [parameter setObject:self.invitationModel.kid forKey:@"id"];
    
    [SCHttpTools getWithURLString:@"invitation/GetBasic" parameter:parameter success:^(id responseObject) {
        NSDictionary *result = responseObject;
        if ([result isKindOfClass:[NSDictionary class]]) {
            FMBasicInformationModel *informationModel = [FMBasicInformationModel mj_objectWithKeyValues:result];
            if (informationModel.errcode==0) {
                self.informationModel = informationModel.data;
            }else{
//                Toast(informationModel.message);
            }
        }
        self.tableView.backgroundColor = kWhiteColor;
        [self.tableView reloadData];
        [self.view dismissLoadingView];
    } failure:^(NSError *error) {
        TTLog(@"---- %@",error);
        [self.view dismissLoadingView];
    }];
}


- (void) handleButtonTapped:(UIButton *)sender{
    if (self.informationModel.man.length==0) {
        Toast(@"请填写新郎姓名");
        return;
    }
    if (self.informationModel.woman.length==0){
        Toast(@"请填写新娘姓名");
        return;
    }
    if (self.informationModel.mobile.length==0){
        Toast(@"请填写联系电话");
        return;
    }
    if (![SCSmallTools checkTelNumber:self.informationModel.mobile]) {
        Toast(@"请输入正确的电话号码");
        return;
    }
    if (self.informationModel.music_name.length==0){
        Toast(@"请选择背景音乐");
        return;
    }
    if (self.informationModel.date.length==0){
        Toast(@"请选择结婚日期");
        return;
    }
    if (self.informationModel.time.length==0){
        Toast(@"请选择结婚时间");
        return;
    }
    if (self.informationModel.address.length==0){
        Toast(@"请定位结婚地址");
        return;
    }
        [MBProgressHUD showMessage:@"" toView:self.view];
        NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
        [parameter setObject:kUserInfo.site_id forKey:@"site_id"];
        [parameter setObject:self.invitationModel.kid forKey:@"tpl_id"];
        [parameter setObject:self.informationModel.man forKey:@"man"];//新郎名字
        [parameter setObject:self.informationModel.woman forKey:@"woman"];//新娘名字
        [parameter setObject:self.informationModel.mobile forKey:@"mobile"];//联系手机号
        [parameter setObject:@(self.informationModel.barrage) forKey:@"barrage"];//0 关闭弹幕， 1 开起弹幕
        [parameter setObject:self.informationModel.music_id forKey:@"music_id"];//音乐的id 通过 音乐列表 接口获得
        [parameter setObject:self.informationModel.date forKey:@"date"];//结婚日期
        [parameter setObject:self.informationModel.time forKey:@"time"];//结婚时间
        [parameter setObject:self.informationModel.address forKey:@"address"];//结婚地址
        [parameter setObject:self.informationModel.map forKey:@"map"];//地图坐标，以腾讯地图坐标为准@"104.059460,30.546982"
        
        [SCHttpTools getWithURLString:@"invitation/AddMyTemplate" parameter:parameter success:^(id responseObject) {
            NSDictionary *result = responseObject;
            if ([result isKindOfClass:[NSDictionary class]]) {
                FMGeneralModel *generalModel = [FMGeneralModel mj_objectWithKeyValues:result];
                if (generalModel.errcode==0) {
                    FMEditInvitationViewController *vc = [[FMEditInvitationViewController alloc] init];
                    TTPushVC(vc);
                }else{
                    Toast(generalModel.message);
                }
            }
            self.tableView.backgroundColor = kWhiteColor;
            [self.tableView reloadData];
            [self.view dismissLoadingView];
            [MBProgressHUD hideHUDForView:self.view];
        } failure:^(NSError *error) {
            TTLog(@"---- %@",error);
            [self.view dismissLoadingView];
            [MBProgressHUD hideHUDForView:self.view];
        }];
}

- (void) switchAction:(UISwitch *)sender {
    sender.on = sender.on ? NO : YES;
    self.informationModel.barrage = sender.on?1:0;
}

#pragma mark - Table view data source
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FMPersonModel* model = self.dataArray[indexPath.section][indexPath.row];
    if (indexPath.section==0) {
        FMBasicInformationTextFieldCell *tools = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierT forIndexPath:indexPath];
        tools.titleLabel.text = model.title;
        if (indexPath.row==0) {
            tools.textField.placeholder = @"请填写新郎姓名";
            tools.textField.text = self.informationModel.man;
        }else if (indexPath.row==1){
            tools.textField.placeholder = @"请填写新娘姓名";
            tools.textField.text = self.informationModel.woman;
        }else{
            tools.textField.placeholder = @"请填写联系电话";
            tools.textField.text = self.informationModel.mobile;
        }
        tools.textField.delegate = self;
        tools.textField.tag = indexPath.row;
        return tools;
    }else if(indexPath.section==2&&indexPath.row==2){
        FMBasicInformationMapCell *tools = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierM forIndexPath:indexPath];
        tools.titleLabel.text = model.title;
        tools.subtitleLabel.text = self.informationModel.address;
        return tools;
    }else{
        FMBasicInformationLabelCell *tools = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierL forIndexPath:indexPath];
        tools.titleLabel.text = model.title;
        if (indexPath.section==1&&indexPath.row==0) {
            tools.isSwitch.selected = self.informationModel.barrage==1?YES:NO;
            [tools.isSwitch addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
            tools.isSwitch.hidden = NO;
            tools.imagesView.hidden = YES;
            tools.selectionStyle = UITableViewCellSelectionStyleNone;
        }else if(indexPath.section==1&&indexPath.row==1){
            tools.subtitleLabel.text = self.informationModel.music_name;
        }else{
            if (indexPath.row==0) {
                tools.subtitleLabel.text = self.informationModel.date;
            }else if (indexPath.row==1){
                tools.subtitleLabel.text = self.informationModel.time;
            }else{
                tools.subtitleLabel.text = @"高新区天府三街288号大有智慧广场";
            }
        }
        return tools;
    }
}

// 多少个分组 section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

/// 返回多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *subArray = [self.dataArray lz_safeObjectAtIndex:section];
    return subArray.count;
}

#pragma mark -- 设置Header高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) return 0;
    return 10;
}

#pragma mark -- Section HearderView Title
// UITableView在Plain类型下，HeaderView和FooterView不悬浮和不停留的方法viewForHeaderInSection
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    SCBaseSectionHeaderView *sectionView = [[SCBaseSectionHeaderView alloc] init];
    sectionView.section = section;
    sectionView.tableView = tableView;
    return sectionView;
}

/// 点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==1&&indexPath.row==1) {
        FMChooseMusicViewController *vc = [[FMChooseMusicViewController alloc] init];
        vc.selectMusicStr = self.informationModel.music_name;
        vc.block = ^(NSString *chooseContent,NSString *muiscID){
            TTLog(@"选中后的数据：%@ ；第%@行",chooseContent,muiscID);
            self.informationModel.music_name = chooseContent;
            self.informationModel.music_id = muiscID;
            [self.tableView reloadData];
        };
        TTPushVC(vc);
    }else if (indexPath.section==2&&indexPath.row==0) {
        /**
         *  显示时间选择器
         *
         *  @param title            标题
         *  @param type             类型（时间、日期、日期和时间、倒计时）
         *  @param defaultSelValue  默认选中的时间（为空，默认选中现在的时间）
         *  @param minDateStr       最小时间（如：2015-08-28 00:00:00），可为空
         *  @param maxDateStr       最大时间（如：2018-05-05 00:00:00），可为空
         *  @param isAutoSelect     是否自动选择，即选择完(滚动完)执行结果回调，传选择的结果值
         *  @param resultBlock      选择结果的回调
         *
         */
        [LZDatePickerView showDatePickerWithTitle:@"" dateType:UIDatePickerModeDate defaultSelValue:@"" minDateStr:[Utils lz_getCurrentDate]  maxDateStr:@"" isAutoSelect:NO resultBlock:^(NSString *selectValue) {
            TTLog(@" -- -- %@",selectValue);
            self.informationModel.date = selectValue;
            [self.tableView reloadData];
        }];
    }else if(indexPath.section==2&&indexPath.row==1){
        NSDate *minDate = [NSDate tt_setHour:8 minute:10];
        NSDate *maxDate = [NSDate tt_setHour:20 minute:35];
        [TTDatePickerView showDatePickerWithTitle:@"婚礼时间" dateType:TTDatePickerModeTime defaultSelValue:self.informationModel.time minDate:minDate maxDate:maxDate isAutoSelect:YES themeColor:kClearColor resultBlock:^(NSString *selectValue) {
            self.informationModel.time = selectValue;
            [self.tableView reloadData];
        }];
    }else if(indexPath.section == 2 && indexPath.row == 2){
        TTTencentMapViewController *vc = [[TTTencentMapViewController alloc] init];
        vc.userCoordinate2D = self.userCoordinate2D;
        MV(weakSelf)
        vc.addressBlock = ^(NSString * _Nonnull address, CGFloat longitude, CGFloat latitude) {
            TTLog(@"更新后的地址：%@ \n经度：%f\n纬度：%f",address,longitude,latitude);
            weakSelf.informationModel.address = address;
            weakSelf.userCoordinate2D = CLLocationCoordinate2DMake(latitude,longitude);
            self.informationModel.map = [NSString stringWithFormat:@"%f,%f",longitude,latitude];
            [weakSelf.tableView reloadData];
            MV(weakSelf)
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.mapView setCenterCoordinate:weakSelf.userCoordinate2D zoomLevel:15.01 animated:YES];
            });
        };
        TTPushVC(vc);
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)setMapCoordinate2D:(CLLocationCoordinate2D)currentCoordinate2D{
    //初始化设置地图中心点坐标需要异步加入到主队列
    MV(weakSelf)
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf.mapView setCenterCoordinate:currentCoordinate2D zoomLevel:15.01 animated:YES];
    });
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [textField addTarget:self action:@selector(handlerTextFieldEndEdit:) forControlEvents:UIControlEventEditingDidEnd];
    return YES; // 当前 textField 可以编辑
}

#pragma mark - 处理编辑事件
- (void)handlerTextFieldEndEdit:(UITextField *)textField {
    TTLog(@"结束编辑:%@", textField.text);
    switch (textField.tag) {
        case 0:
            self.informationModel.man = textField.text;
            break;
        case 1:
            self.informationModel.woman = textField.text;
            break;
        case 2:
            self.informationModel.mobile = textField.text;
            break;
        default:
            break;
    }
}

#pragma mark - 刷新指定行的数据
- (void)reloadData:(NSInteger)section row:(NSInteger)row {
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.showsVerticalScrollIndicator = false;
        [_tableView registerClass:[FMBasicInformationTextFieldCell class] forCellReuseIdentifier:reuseIdentifierT];
        [_tableView registerClass:[FMBasicInformationLabelCell class] forCellReuseIdentifier:reuseIdentifierL];
        [_tableView registerClass:[FMBasicInformationMapCell class] forCellReuseIdentifier:reuseIdentifierM];
        
        // 拖动tableView时收起键盘
        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        [_tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = kTableViewInSectionColor;
    }
    return _tableView;
}

- (UIButton *)saveButton{
    if (!_saveButton) {
        _saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_saveButton setBackgroundImage:imageHexString(@"#FF4163") forState:UIControlStateNormal];
        [_saveButton setTitle:@"保存" forState:UIControlStateNormal];
        _saveButton.titleLabel.font = kFontSizeMedium16;
        _saveButton.tag = 101;
        MV(weakSelf);
        [_saveButton lz_handleControlEvent:UIControlEventTouchUpInside withBlock:^{
            [weakSelf handleButtonTapped:weakSelf.saveButton];
        }];
    }
    return _saveButton;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
        NSArray* titleArr = @[@[@"新郎姓名",@"新娘姓名",@"联系电话"],
                              @[@"弹      幕",@"背景音乐"],
                              @[@"婚礼日期",@"婚礼时间",@"婚礼地址"]];
//        NSArray* imagesArr = @[@[@"珠宝首饰",@"婚纱摄影"],
//                               @[@"请帖喜糖",@"婚礼礼服",@"婚礼跟妆",@"婚礼摄像",@"婚礼摄影",@"婚礼司仪",@"婚车租赁",@"婚礼策划",@"婚宴酒店"],
//                               @[@"蜜月旅行"]];
        for (int i=0; i<titleArr.count; i++) {
            NSArray *subTitlesArray = [titleArr lz_safeObjectAtIndex:i];
//            NSArray *subImagesArray = [imagesArr lz_safeObjectAtIndex:i];
            NSMutableArray *subArray = [NSMutableArray array];
            for (int j = 0; j < subTitlesArray.count; j ++) {
                FMPersonModel *personModel = [[FMPersonModel alloc] init];
                personModel.title = [subTitlesArray lz_safeObjectAtIndex:j];
//                personModel.imageText = [subImagesArray lz_safeObjectAtIndex:j];
                [subArray addObject:personModel];
            }
            [_dataArray addObject:subArray];
        }
    }
    return _dataArray;
}

- (UIView *)footerView{
    if (!_footerView) {
        _footerView = [UIView lz_viewWithColor:kColorWithRGB(238, 238, 238)];
        _footerView.frame = CGRectMake(0, 0, kScreenWidth, 200);
    }
    return _footerView;
}

- (BasicInformationModel *)informationModel {
    if (!_informationModel) {
        _informationModel = [[BasicInformationModel alloc]init];
    }
    return _informationModel;
}

#pragma mark --- --- -- - 腾讯地图 -- --- -- - -
- (QMapView *)mapView {
    if (!_mapView) {
        // 此处腾讯地图重写了 -initWithFrame: 方法
        _mapView = [[QMapView alloc] initWithFrame:self.footerView.bounds];
        _mapView.delegate = self;
        _mapView.showsUserLocation = YES;//开启服务
        _mapView.userTrackingMode = QUserTrackingModeFollow;
        _mapView.zoomEnabled = NO;  //是否支持缩放, 默认为YES
        _mapView.scrollEnabled = NO;// 是否支持平移, 默认为YES
        _mapView.showTraffic = YES;// 是否显示交通, 默认为NO
        _mapView.keepCenterEnabled = YES;// pinch时保持中心点, 默认为NO
        _mapView.userInteractionEnabled = NO;
        self.userCoordinate2D = CLLocationCoordinate2DMake(0, 0);
        [self.footerView addSubview:_mapView];
    }
    return _mapView;
}


- (UIImageView *)redPinImageView {
    if (!_redPinImageView) {
        _redPinImageView = [[UIImageView alloc] init];
        _redPinImageView.image = kGetImage(@"map_btn_position");
        [self.mapView addSubview:_redPinImageView];
        [_redPinImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.mapView);
        }];
    }
    return _redPinImageView;
}

- (TencentMapModel *)mapModel{
    if (!_mapModel) {
        _mapModel = [[TencentMapModel alloc] init];
    }
    return _mapModel;
}

@end
