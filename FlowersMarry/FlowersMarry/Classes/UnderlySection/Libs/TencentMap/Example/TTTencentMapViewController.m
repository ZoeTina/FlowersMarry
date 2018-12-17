//
//  TTTencentMapViewController.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/11/15.
//  Copyright © 2018 宁小陌. All rights reserved.
//

#import "TTTencentMapViewController.h"
#import "TTSeacherResultTableViewController.h"
#import <TencentLBS/TencentLBS.h>
#import "FMBasicInformationViewController.h"

#define HsearchBar self.searchController.searchBar.frame.size.height

#define HMapView (292/667.0*kScreenHeight)
#define NHMapView (HMapView*0.5)

#define YTableView (HsearchBar + HMapView)
#define HTableView (kScreenHeight - ([self hightAboutStatusbarAndNavigationbar] + YTableView))

#define NYTableView (HsearchBar + NHMapView)
#define NHTableView (kScreenHeight - ([self hightAboutStatusbarAndNavigationbar] + NYTableView))

#define TMapCenter CGPointMake(self.mapView.frame.size.width * 0.5, self.mapView.frame.size.height * 0.5 - 16)

#define TTintColor [UIColor colorWithRed:31/255.0 green:185/255.0 blue:34/255.0 alpha:1.0]
#define TBarTintColor [UIColor colorWithRed:239/255.0 green:239/255.0 blue:244/255.0 alpha:1.0]

@interface TTTencentMapViewController ()<UISearchResultsUpdating,UISearchControllerDelegate,UITableViewDelegate,UITableViewDataSource,QMapViewDelegate,QMSSearchDelegate,TTSeacherResultTableViewControllerDelegete,UISearchBarDelegate,TencentLBSLocationManagerDelegate>
/// 管理定位权限
@property (nonatomic, strong) TencentLBSLocationManager *locationManager;
@property (nonatomic, assign) CLAuthorizationStatus authorizationStatus;
@property (nonatomic, strong) UISearchController *searchController;
/// 地图
@property (nonatomic, strong) QMapView *mapView;
/// 地理信息搜索
@property (nonatomic, strong) QMSSearcher *mapSearcher;
/// 逆地理编码结果
@property (nonatomic, strong) QMSReverseGeoCodeSearchResult *reGeoResult;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImageView *redPinImageView;
@property (nonatomic, strong) UIButton *foucsBtn;
/// 记录查询界面返回的结果
@property (nonatomic, strong) QMSSuggestionPoiData *searcherPoiData;

/// 记录被选中的行数
@property (nonatomic, assign) NSInteger selectRow;
/// 缓存位移，用于判断是向下偏移还是向下偏移
@property (nonatomic, assign) CGFloat oldOffset;
/// 记录地图放缩前的大小
@property (nonatomic, assign) double zoomLevel;
/// 用于标记是否是点击cell造成的位移，如果是，则不进行反地理编码操作，默认为NO
@property (nonatomic, assign) BOOL isDidSelectRow;
/// 用于标记是否是搜索界面回掉产生的位移，默认为NO
@property (nonatomic, assign) BOOL isSearchResult;
/// 用于标记是否是因为拖拽tableView产生的位移
@property (nonatomic, assign) BOOL isDraggingTableView;
@end

@implementation TTTencentMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"选择地理位置";
    UIBarButtonItem *rightBarBtn = [[UIBarButtonItem alloc] initWithTitle:@"确定" style:UIBarButtonItemStyleDone target:self action:@selector(clickRightBarBtn)];
    self.navigationItem.rightBarButtonItem = rightBarBtn;
    [self locationManager];
    [self mapViewAuthorization];
    [self startUpdatingLocation];
    [self initTMapView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.view.backgroundColor = kWhiteColor;
    self.authorizationStatus = [CLLocationManager authorizationStatus];
}

- (void)setUserCoordinate2D:(CLLocationCoordinate2D)userCoordinate2D{
    _userCoordinate2D = userCoordinate2D;
    //初始化设置地图中心点坐标需要异步加入到主队列
    MV(weakSelf)
    dispatch_async(dispatch_get_main_queue(), ^{
        [weakSelf.mapView setCenterCoordinate:self.userCoordinate2D zoomLevel:20.01 animated:YES];
    });
}

- (void) mapViewAuthorization{
    switch (self.authorizationStatus) {
        case kCLAuthorizationStatusNotDetermined:
        {
            TTLog(@"用户尚未进行选择");
            [self.locationManager requestAlwaysAuthorization];        // NSLocationAlwaysUsageDescription
            [self.locationManager requestWhenInUseAuthorization];     // NSLocationWhenInUseDescription
        }
            break;
        case kCLAuthorizationStatusDenied:
        {
            TTLog(@"用户不允许定位");
        }
        case kCLAuthorizationStatusRestricted:
        {
            TTLog(@"定位权限被限制");
            [self showLocationAlert];
        }
            break;
        case kCLAuthorizationStatusAuthorizedWhenInUse:
        case kCLAuthorizationStatusAuthorizedAlways:
        {
            TTLog(@"用户允许定位");
            [self initTMapView];
        }
            break;
        default:
            break;
    }
}

- (void)clickRightBarBtn {
    NSString *messageStr;
    NSString *addressStr = @"";
    CGFloat longitude,latitude = 0.0;
    if (self.selectRow == 0) {
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        if (!self.searcherPoiData) {
            messageStr = [NSString stringWithFormat:@"地名:%@\n坐标:<%lf,%lf>\n详细地址:%@",
                          cell.textLabel.text,
                          self.searcherPoiData.location.latitude,
                          self.searcherPoiData.location.longitude,
                          cell.detailTextLabel.text];
            addressStr = cell.textLabel.text;
            longitude = self.searcherPoiData.location.longitude;
            latitude = self.searcherPoiData.location.latitude;
        } else {
            messageStr = [NSString stringWithFormat:@"地名:%@\n坐标:<%lf,%lf>\n详细地址:%@",
                          self.reGeoResult.formatted_addresses.recommend,
                          self.lastCoordinate2D.latitude,
                          self.lastCoordinate2D.longitude,
                          self.reGeoResult.address];
            addressStr = self.reGeoResult.address;
            longitude = self.lastCoordinate2D.longitude;
            latitude = self.lastCoordinate2D.latitude;
        }
    } else {
        QMSReGeoCodePoi *poi = ((QMSReGeoCodePoi *)self.reGeoResult.poisArray[self.selectRow - 1]);
        messageStr = [NSString stringWithFormat:@"地名:%@\n坐标:<%lf,%lf>\n详细地址:%@",
                      poi.title,poi.location.latitude,
                      poi.location.longitude,poi.address];
        addressStr = poi.address;
        longitude = poi.location.longitude;
        latitude = poi.location.latitude;
    }
    if (self.addressBlock) {
        self.addressBlock(addressStr, longitude, latitude);
    }
    [self.navigationController popViewControllerAnimated:YES];
    TTLog(@" messageStr -- -%@",messageStr);
}

#pragma mark ---- QMapView 代理方法区
/*!
 *  @brief  地图区域即将改变时会调用此接口
 *  触发条件：地图显示区域大小发生变化或者拖动地图内容视图
 *  @param mapView  地图view
 *  @param animated 是否采用动画
 */
- (void)mapView:(QMapView *)mapView regionWillChangeAnimated:(BOOL)animated {
    self.zoomLevel = self.mapView.zoomLevel;
    TTLog(@"Region:\ncenter:[%f,%f]\nspan:[%f,%f]",
          _mapView.region.center.latitude,
          _mapView.region.center.longitude,
          _mapView.region.span.latitudeDelta,
          _mapView.region.span.longitudeDelta);
}

/*!
 *  @brief  地图区域改变完成时会调用此接口
 *  触发条件：地图显示区域大小发生变化或者拖动地图内容视图
 *  @param mapView  地图view
 *  @param animated 是否采用动画
 */
- (void)mapView:(QMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    TTLog(@"Region:\ncenter:[%f,%f]\nspan:[%f,%f]",
          _mapView.region.center.latitude,
          _mapView.region.center.longitude,
          _mapView.region.span.latitudeDelta,
          _mapView.region.span.longitudeDelta);
    // 如果正在放缩，则不查询
    if (self.mapView.zoomLevel != self.zoomLevel) {return;}
    // 如果是点击cell造成的移动，则不查询
    if (self.isDidSelectRow) {
        self.isDidSelectRow = NO;
        [self changeFoucsBtnStatusWithCoordinate2D:self.mapView.centerCoordinate];
        return;
    }
    
    // 如果是拖拽tableView产生的位移，不查询
    if (self.isDraggingTableView) {return;}
    // 如果不是点击cell造成的移动，则应更新地理信息
    // 如果不是搜索界面造成的位移，则应消除相关数据
    // 如果是搜索界面造成的位移，则应在数据使用后（生成相应的cell后）标记为NO
    if(!self.isSearchResult){
        self.searcherPoiData = nil;
    }
    
    // 无效定位数据,不做任何响应
    if (self.lastCoordinate2D.latitude == 0 && self.lastCoordinate2D.longitude == 0) {
        return;
    }
    
    // 如果最后一次有效定位与当前因响应若干因素而返回的坐标不一致，那么就扩大地图显示区域，更新lastCoordinate2D和foucsBtn.selected的状态，需要注意的是：当界面中心地址确为用户地址时状态应为yes
    if (self.lastCoordinate2D.latitude != self.mapView.centerCoordinate.latitude || self.lastCoordinate2D.longitude != self.mapView.centerCoordinate.longitude) {
        self.lastCoordinate2D = self.mapView.centerCoordinate;
//        [self mapViewBigTableViewSmall];
//        [self changeFoucsBtnStatusWithCoordinate2D:self.lastCoordinate2D];
    }
    
    // 配置"经纬度"搜索参数(注：代理方法最多只返回周边十条数据)
    QMSReverseGeoCodeSearchOption *reGeoSearchOption = [[QMSReverseGeoCodeSearchOption alloc] init];
    [reGeoSearchOption setLocationWithCenterCoordinate:self.lastCoordinate2D];
    [reGeoSearchOption setGet_poi:YES];
    [self.mapSearcher searchWithReverseGeoCodeSearchOption:reGeoSearchOption];
}

/// @brief 变更地图右下侧区域的按钮状态 @param coordinate2D 地图中心点的经纬度
- (void)changeFoucsBtnStatusWithCoordinate2D:(CLLocationCoordinate2D)coordinate2D {
    /* 此更新foucsBtn.selected状态的方式要允许存在偏差 */
    CLLocationDegrees latitude = self.userCoordinate2D.latitude - coordinate2D.latitude;
    CLLocationDegrees longitude = self.userCoordinate2D.longitude - coordinate2D.longitude;
    if(latitude > -0.00001 && latitude < 0.00001  && longitude > -0.00001 && longitude < 0.00001){
        self.foucsBtn.selected = YES;
    } else {
        self.foucsBtn.selected = NO;
    }
}

/*!
 *  @brief  定位失败后，会调用此函数
 *
 *  @param mapView 地图view
 *  @param error   错误号，参考CLError.h中定义的错误号
 */
- (void)mapView:(QMapView *)mapView didFailToLocateUserWithError:(NSError *)error {
    TTLog(@"error --- %@",error);
}

/*!
 *  @brief  位置或者设备方向更新后，会调用此函数
 *  触发条件：定位，返回用户当前位置
 *  @param mapView          地图view
 *  @param userLocation     用户定位信息(包括位置与设备方向等数据)
 *  @param updatingLocation 标示是否是location数据更新, YES:location数据更新 NO:heading数据更新
 */
- (void)mapView:(QMapView *)mapView didUpdateUserLocation:(QUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation {
    //刷新位置  如果这块不关闭的话，会一直调用这个代理函数
    //    [self.mapView setShowsUserLocation:NO];
    TTLog(@"longitude -- %f,latitude -- %f",userLocation.location.coordinate.longitude,userLocation.location.coordinate.latitude);
    self.userCoordinate2D = userLocation.coordinate;
    // lastCoordinate2D 第一次出现事应该是用户的定位数据，且此数据只在此处获取一次，后面会在其他位置被其他数据覆盖
    if (self.lastCoordinate2D.latitude == 0 && self.lastCoordinate2D.longitude == 0) {
        self.lastCoordinate2D = userLocation.coordinate;
    }
}

/*!
 *  @brief  在地图view将要启动定位时，会调用此函数
 *
 *  @param mapView 地图view
 */
- (void)mapViewWillStartLocatingUser:(QMapView *)mapView{
    //获取开始定位的状态
    TTLog(@"在地图view将要启动定位时mapView --- %f",mapView.centerCoordinate.latitude);
}

/*!
 *  @brief  在地图view定位停止后，会调用此函数
 *
 *  @param mapView 地图view
 */
- (void)mapViewDidStopLocatingUser:(QMapView *)mapView{
    //获取停止定位的状态
}

#pragma mark ---- QMSSearch 代理方法区
/*!
 *  @brief  查询出现错误
 *
 *  @param searchOption 查询参数
 *  @param error        错误
 */
- (void)searchWithSearchOption:(QMSSearchOption *)searchOption didFailWithError:(NSError *)error {
    TTLog(@"查询出现错误 --- error:%@", error);
}

/*!
 *  @brief  逆地理解析(坐标位置描述)结果回调接口
 *  反地理编码查询结果(经纬度查询位置信息)
 *  @param reverseGeoCodeSearchOption 查询参数
 *  @param reverseGeoCodeSearchResult 查询结果
 */
- (void)searchWithReverseGeoCodeSearchOption:(QMSReverseGeoCodeSearchOption *)reverseGeoCodeSearchOption didReceiveResult:(QMSReverseGeoCodeSearchResult *)reverseGeoCodeSearchResult {
    self.reGeoResult = reverseGeoCodeSearchResult;
    [self mapViewRedPinImageViewAnimate];
    [self.tableView reloadData];
    self.selectRow = 0;
    // 更新数据后应回滚到一个Cell
    NSIndexPath *scrollIndexPath = [NSIndexPath indexPathForRow:self.selectRow inSection:0];
    [self.tableView scrollToRowAtIndexPath:scrollIndexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

/*!
 *  @brief  关键字的补完与提示回调接口(关键词查询结果)
 *
 *  @param suggestionSearchOption 查询参数
 *  @param suggestionSearchResult 查询结果
 */
- (void)searchWithSuggestionSearchOption:(QMSSuggestionSearchOption *)suggestionSearchOption didReceiveResult:(QMSSuggestionResult *)suggestionSearchResult {
    TTLog(@"suggest result:%@", suggestionSearchResult);
    ((TTSeacherResultTableViewController *)(self.searchController.searchResultsController)).searchBar = self.searchController.searchBar;
    ((TTSeacherResultTableViewController *)(self.searchController.searchResultsController)).searchController = self.searchController;
    ((TTSeacherResultTableViewController *)(self.searchController.searchResultsController)).resultArr = [suggestionSearchResult.dataArray mutableCopy];
}

#pragma mark ---- UISearchResultsUpdating(输入内容时触发)
// 搜索栏内容发生变化时触发
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    if (searchController.searchBar.text.length > 0) {
        // 配置"关键词查询"搜索参数
        QMSSuggestionSearchOption *suggetionOption = [[QMSSuggestionSearchOption alloc] init];
        [suggetionOption setKeyword:searchController.searchBar.text];
        
        [self.mapSearcher searchWithSuggestionSearchOption:suggetionOption];
    }
}

- (void)willPresentSearchController:(UISearchController *)searchController {
    [UIView animateWithDuration:0.25f animations:^{
        [self setPositonAdjustmentWithSearchBar:self.searchController.searchBar isCenter:NO];
    }];
}

- (void)willDismissSearchController:(UISearchController *)searchController {
    [UIView animateWithDuration:0.25f animations:^{
        [self setPositonAdjustmentWithSearchBar:self.searchController.searchBar isCenter:YES];
    }];
}
#pragma mark ---- UISearchBarDelegate
// 点击键盘搜索按钮
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    if (searchBar.text.length > 0) {
        // 配置"关键词查询"搜索参数
        QMSSuggestionSearchOption *suggetionOption = [[QMSSuggestionSearchOption alloc] init];
        [suggetionOption setKeyword:searchBar.text];
        [self.mapSearcher searchWithSuggestionSearchOption:suggetionOption];
    }
}

#pragma mark ---- TTSeacherResultTableViewController 代理方法区
- (void)SeacherResultBlockData:(QMSSuggestionPoiData *)Poi {
    self.isSearchResult = YES;
    self.searcherPoiData = Poi;
    self.searchController.searchBar.text = @"";
    [self.searchController.searchBar resignFirstResponder];
    [self.mapView setCenterCoordinate:Poi.location animated:YES];
}

#pragma mark ---- UITableView 代理方法区
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1 + self.reGeoResult.poisArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 51;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"TTTencentMapViewController";
    UITableViewCell *tools=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!tools) {
        tools = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    if (indexPath.row != 0) {
        tools.textLabel.text = ((QMSReGeoCodePoi *)self.reGeoResult.poisArray[indexPath.row - 1]).title;
        tools.detailTextLabel.text = ((QMSReGeoCodePoi *)self.reGeoResult.poisArray[indexPath.row - 1]).address;
    } else {
        if (!self.searcherPoiData) {// 用户当前定位，第一条数据不设置副标题
            tools.textLabel.text = self.reGeoResult.formatted_addresses.recommend;
            tools.detailTextLabel.text = @"";
        } else {
            if (self.isSearchResult) {
                tools.textLabel.text = self.searcherPoiData.title;
                tools.detailTextLabel.text = self.searcherPoiData.address;
                self.isSearchResult = NO;
            } else {
                tools.textLabel.text = self.reGeoResult.formatted_addresses.recommend;
                tools.detailTextLabel.text = self.reGeoResult.address;
            }
        }
    }
    tools.detailTextLabel.textColor = [UIColor grayColor];
    tools.selectionStyle = UITableViewCellSelectionStyleGray;
    tools.accessoryType = UITableViewCellAccessoryNone;
    tools.tintColor = TTintColor;
    
    if (self.selectRow == indexPath.row) {
        tools.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    return tools;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSIndexPath *tmpIndexPath = [NSIndexPath indexPathForRow:self.selectRow inSection:0];
    UITableViewCell *tmpCell = [tableView cellForRowAtIndexPath:tmpIndexPath];
    tmpCell.accessoryType = UITableViewCellAccessoryNone;
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    self.selectRow = indexPath.row;
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    
    self.isDidSelectRow = YES;
    if (indexPath.row == 0) {
        if (!self.searcherPoiData) {
            [self.mapView setCenterCoordinate:self.lastCoordinate2D animated:YES];
        } else {
            
            [self.mapView setCenterCoordinate:self.searcherPoiData.location animated:YES];
        }
    } else {
        [self.mapView setCenterCoordinate:((QMSReGeoCodePoi *)self.reGeoResult.poisArray[indexPath.row - 1]).location animated:YES];
    }
}

// 开始拖拽视图
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    self.isDraggingTableView = YES;
}

// 完成拖拽
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
}

// 减速停止时执行，手触摸时执行执行
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    self.isDraggingTableView = NO;
}

// 拖动过程中触发
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.tableView.contentOffset.y < -20) { //地图变大，tableView变小
        [self mapViewBigTableViewSmall];
    }
    
    if (self.tableView.contentOffset.y > 0) { //地图变小，tableView变大
        if (self.tableView.contentOffset.y > self.oldOffset) {// 如果当前位移大于缓存位移，说明scrollView向上滑动
            [self mapViewSmallTableViewBig];
        }
    }
    // 将当前位移变成缓存位移
    self.oldOffset = self.tableView.contentOffset.y;
}

#pragma mark ---- 动画方法区
/// 地图变大，tableView变小
- (void)mapViewBigTableViewSmall {
    [UIView animateWithDuration:0.5f animations:^{
        self.mapView.frame = CGRectMake(0, HsearchBar, kScreenWidth, HMapView);
        self.tableView.frame = CGRectMake(0, YTableView, kScreenWidth, HTableView);
        self.redPinImageView.center = TMapCenter;
        self.foucsBtn.frame = CGRectMake(kScreenWidth - 50 - 10, HMapView - 50 - 20, 50, 50);
    } completion:^(BOOL finished) {
    }];
}

/// 地图变小，tableView变大
- (void)mapViewSmallTableViewBig {
    [UIView animateWithDuration:0.5f animations:^{
        self.mapView.frame = CGRectMake(0, HsearchBar, kScreenWidth, NHMapView);
        self.tableView.frame = CGRectMake(0, NYTableView, kScreenWidth, NHTableView);
        self.redPinImageView.center = TMapCenter;
        self.foucsBtn.frame = CGRectMake(kScreenWidth - 50 - 10, NHMapView - 50 - 20, 50, 50);
    } completion:^(BOOL finished) {
    }];
}

/// 小图钉动画
- (void)mapViewRedPinImageViewAnimate {
    [UIView animateKeyframesWithDuration:0.5 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:1 / 2.0 animations:^{
            self.redPinImageView.center = CGPointMake(self.mapView.frame.size.width * 0.5, self.mapView.frame.size.height * 0.5 - 16 - 15);
        }];
        
        [UIView addKeyframeWithRelativeStartTime:1 / 2.0 relativeDuration:1 / 2.0 animations:^{
            self.redPinImageView.center = TMapCenter;
        }];
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark ---- 腾讯地图定位以及授权 --- ---
- (TencentLBSLocationManager *)locationManager {
    if (!_locationManager) {
        _locationManager = [[TencentLBSLocationManager alloc] init];
        _locationManager.delegate = self;
        /// 指定定位是否会被系统自动暂停。默认为 YES 。
        _locationManager.pausesLocationUpdatesAutomatically = NO;
        /// 是否允许后台定位。默认为 NO。
        _locationManager.allowsBackgroundLocationUpdates = YES;
        _locationManager.apiKey = kTencentAppKey;
    }
    return _locationManager;
}

#pragma mark - TencentLBSLocationManagerDelegate
- (void)tencentLBSLocationManager:(TencentLBSLocationManager *)manager didFailWithError:(NSError *)error {
    [self mapViewAuthorization];
}

- (void)tencentLBSLocationManager:(TencentLBSLocationManager *)manager didUpdateLocation:(TencentLBSLocation *)location {
    CLLocation *currentLocation = location.location;
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    fmt.dateFormat = @"yyyy-MM-dd hh:mm:ss";
    NSString *dateString = [fmt stringFromDate:currentLocation.timestamp];
    NSString *displayLabel = [NSString stringWithFormat:@" latitude:%f, longitude:%f\n horizontalAccuracy:%f \n verticalAccuracy:%f\n speed:%f\n course:%f\n altitude:%f\n timestamp:%@",currentLocation.coordinate.latitude, currentLocation.coordinate.longitude, currentLocation.horizontalAccuracy, currentLocation.verticalAccuracy, currentLocation.speed, currentLocation.course, currentLocation.altitude, dateString];
    TTLog(@"displayLabel  ---- %@",displayLabel);
    self.userCoordinate2D = currentLocation.coordinate;
    // lastCoordinate2D 第一次出现事应该是用户的定位数据，且此数据只在此处获取一次，后面会在其他位置被其他数据覆盖
    if (self.lastCoordinate2D.latitude == 0 && self.lastCoordinate2D.longitude == 0) {
        self.lastCoordinate2D = currentLocation.coordinate;
        [self stopUpdatingLocation]; //停止定位
    }
//    //初始化设置地图中心点坐标需要异步加入到主队列
    MV(weakSelf)
    dispatch_async(dispatch_get_main_queue(), ^{
        //        CLLocationCoordinate2D currentCoordinate2D = CLLocationCoordinate2DMake(30.546962,104.059443);
//        [weakSelf.mapView setCenterCoordinate:self.lastCoordinate2D zoomLevel:20.01 animated:YES];
    });
}

/// 开启定位
- (void)startUpdatingLocation {
    [self.locationManager startUpdatingLocation];
}

/// 停止定位
- (void)stopUpdatingLocation {
    [self.locationManager stopUpdatingLocation];
}

/// 弹窗提示
- (void)showLocationAlert {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"定位权限未开启，是否开启？" preferredStyle:  UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"是" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if( [[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]] ) {
#if  __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
            if (@available(iOS 10.0, *)) {
                [[UIApplication sharedApplication]openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{}completionHandler:^(BOOL success) {
                }];
            } else {
                // Fallback on earlier versions
            }
#elif __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
#endif
        }
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"否" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }]];
    
    [self presentViewController:alert animated:true completion:nil];

}

- (void)initTMapView {
    [self.view addSubview:self.searchController.searchBar];
    [self mapView];
    [self tableView];
    [self redPinImageView];
    [self foucsBtn];
}

- (UISearchController *)searchController {
    if (!_searchController) {
        TTSeacherResultTableViewController *seacherResultTableViewController = [[TTSeacherResultTableViewController alloc] init];
        _searchController = [[UISearchController alloc] initWithSearchResultsController:seacherResultTableViewController];
        _searchController.searchResultsUpdater = self;
        _searchController.delegate = self;
        ((TTSeacherResultTableViewController *)(self.searchController.searchResultsController)).SeacherResultDelegate = self;
        _searchController.searchBar.placeholder = @"搜索地点";
        _searchController.searchBar.tintColor = TTintColor;
        _searchController.searchBar.barTintColor = TBarTintColor;
        // 此处去除searchBar底部黑线
        _searchController.searchBar.layer.borderWidth = 1.0;
        _searchController.searchBar.layer.borderColor = TBarTintColor.CGColor;
        _searchController.searchBar.delegate = self;
        [_searchController.searchBar sizeToFit];
        [self setPositonAdjustmentWithSearchBar:_searchController.searchBar isCenter:YES];
        self.definesPresentationContext = YES;
        [[UIBarButtonItem appearanceWhenContainedIn:[UISearchBar class], nil] setTitle:@"取消"];
    }
    return _searchController;
}

/// 将放大镜和占位字符居中/居左（仅对系统iOS11.0后有效）@param searchBar 将要对相关元素居中/居左的searchBar @param isCenter 是否居中，YSE：居中，NO：居左
- (void)setPositonAdjustmentWithSearchBar:(UISearchBar *)searchBar isCenter:(BOOL)isCenter {
    if (@available(iOS 11.0, *)) {
        if (isCenter) {
            [searchBar setPositionAdjustment:UIOffsetMake((kScreenWidth - 32) * 0.5 - [self widthWithdtPlaceholder:searchBar.placeholder] * 0.5,0) forSearchBarIcon:UISearchBarIconSearch];
        } else {
            [searchBar setPositionAdjustment:UIOffsetZero forSearchBarIcon:UISearchBarIconSearch];
        }
        // 让动画动起来
        [self.searchController.searchBar setNeedsLayout];
        [self.searchController.searchBar layoutIfNeeded];
    }
}

/// @brief 计算placeholder、icon、间距的总宽度，系统默认字体大小15 @param placeholder 用于计算宽度的字符串 @return 字符串的宽度
- (CGFloat)widthWithdtPlaceholder:(NSString *)placeholder {
    CGSize size = [placeholder boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil].size;
    return size.width + 20 + 10;
}

- (QMapView *)mapView {
    if (!_mapView) {
        // 此处腾讯地图重写了 -initWithFrame: 方法
        _mapView = [[QMapView alloc] initWithFrame:CGRectMake(0, HsearchBar, kScreenWidth, HMapView + self.hightAboutStatusbarAndNavigationbar)];
        TTLog(@"%lf,%lf", kScreenWidth, HMapView);
        _mapView.delegate = self;
        _mapView.showsUserLocation = YES;//开启服务
        _mapView.userTrackingMode = QUserTrackingModeFollow;
        _mapView.keepCenterEnabled = YES;
//        self.userCoordinate2D = CLLocationCoordinate2DMake(0, 0);
        
        self.lastCoordinate2D = CLLocationCoordinate2DMake(0, 0);
        self.searcherPoiData = nil;
        self.isDidSelectRow = NO;
        self.isSearchResult = NO;
        self.isDraggingTableView = NO;
        [self.view addSubview:_mapView];
        self.mapSearcher = [[QMSSearcher alloc] initWithDelegate:self];
    }
    return _mapView;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, YTableView, kScreenWidth, HTableView) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        self.selectRow = 0;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

/// 获取状态栏和导航栏的总高度
- (CGFloat)hightAboutStatusbarAndNavigationbar {
    // 获取状态栏的高度
    CGRect rectOfStatusbar = [[UIApplication sharedApplication] statusBarFrame];
    // 获取导航栏的高度
    CGRect rectOfNavigationbar = self.navigationController.navigationBar.frame;
    // 状态栏 + 导航栏
    return rectOfStatusbar.size.height + rectOfNavigationbar.size.height;
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

- (UIButton *)foucsBtn {
    if (!_foucsBtn) {
        _foucsBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.mapView addSubview:_foucsBtn];
        _foucsBtn.selected = YES;
        _foucsBtn.hidden = YES;
        [_foucsBtn setImage:kGetImage(@"map_btn_normal") forState:UIControlStateNormal];
        [_foucsBtn setImage:kGetImage(@"map_btn_selected") forState:UIControlStateSelected];
        [_foucsBtn setImage:kGetImage(@"map_btn_highlighted") forState:UIControlStateHighlighted];
        [_foucsBtn addTarget:self action:@selector(foucsBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_foucsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.mapView.mas_right).offset(-10);
            make.bottom.equalTo(self.mapView.mas_bottom).offset(-20);
        }];
    }
    return _foucsBtn;
}

- (void)foucsBtnClick:(UIButton *)sender {
    if (!sender.selected) {
        sender.selected = YES;
        self.searcherPoiData = nil;
        [self.mapView setCenterCoordinate:self.userCoordinate2D animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
