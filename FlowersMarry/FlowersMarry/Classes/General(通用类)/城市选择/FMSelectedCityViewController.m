//
//  FMSelectedCityViewController.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/8/1.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMSelectedCityViewController.h"
#import "FMSelectedCityModel.h"
#import "FMHotsCityTableViewCell.h"
#import "FMGroupsCityTableViewCell.h"
#import "FMCurrentCitysTableViewCell.h"
#import "FMHomePageSectionHeaderView.h"
#import "FMCitySectionView.h"

#import "LZChineseSort.h"
#import "LZPinYinSearch.h"
#import "NSString+LZPinYin.h"

static NSString * const reuseIdentifierHots = @"FMHotsCityTableViewCell";
static NSString * const reuseIdentifierGroups = @"FMGroupsCityTableViewCell";
static NSString * const reuseIdentifierCurrent = @"FMCurrentCitysTableViewCell";

@interface FMSelectedCityViewController ()<UITableViewDelegate,UITableViewDataSource,FMCurrentCitysTableViewCellDelegate,UISearchResultsUpdating,UISearchControllerDelegate>
{
    FMCitySectionView *sectionView;
}
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) CityDataModel *cityModel;
@property (nonatomic, strong) NSMutableDictionary *heightAtIndexPath;//缓存高度
@property (strong, nonatomic) UISearchController    *searchController;
/** <排序前的整个数据源> */
@property (strong, nonatomic) NSMutableArray        *itemModelArray;
/** <排序后的整个数据源> */
@property (strong, nonatomic) NSDictionary          *letterResultDictionary;
/** <索引数据源> */
@property (strong, nonatomic) NSMutableArray        *indexArray;

/** <搜索结果排序前的整个数据源> */
@property (strong, nonatomic) NSMutableArray        *searchResultsArray;
/** <搜索结果排序后的整个数据源> */
@property (strong, nonatomic) NSDictionary          *searchResultsDictionary;
/** 搜索结果索引数据源 */
@property (strong, nonatomic) NSArray               *searchResultsIndexArray;
// 被搜索的字符串
@property (copy, nonatomic) NSString                *searchText;
@end

@implementation FMSelectedCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initView];
    
    self.title = @"城市选择";
    [self setLeftNavBarItemWithImage:@"all_btn_back_grey"];
    [MBProgressHUD showMessage:@"" toView:self.view];
//    int64_t delayInSeconds = 0.5;      // 延迟的时间
//    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
//    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self loadCityDataModel];
//    });
}

- (void)leftItemClick:(UIButton *)sender {
    [self cancelBtnClick];
}

- (void) cancelBtnClick{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void) initView{
    // 1.设置右侧索引字体颜色
    self.tableView.sectionIndexColor = [UIColor lz_colorWithHexString:@"#808080"];
    //2.设置右侧索引背景色
    self.tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [Utils lz_setExtraCellLineHidden:self.tableView];
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.searchController.searchBar.size.height)];
    [headerView addSubview:self.searchController.searchBar];
    //设置tableHeaderView
    [self.tableView setTableHeaderView:headerView];
}

/// 解决搜索结果tableView向上偏移20px
-(void)viewDidLayoutSubviews {
    if(self.searchController.active) {
        [self.tableView setFrame:CGRectMake(0, 8, kScreenWidth, self.view.height - 8)];
    }else {
        self.tableView.frame = self.view.bounds;
    }
}

#pragma mark -------- 加载城市数据Models --------
- (void)loadCityDataModel {
    // 模拟数据
    AppDelegate *delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    if (delegate.cityDataModel.errcode==0) {
        self.cityModel = delegate.cityDataModel.data;
        [self initData];
        [self.tableView reloadData];
        // 重要 - 分配回主线程。 始终在主线程上访问UI类（包括MBProgressHUD）。
//        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view];
//        });
    }else{
        TTLog(@"没有数据");
        [MBProgressHUD hideHUDForView:self.view];
    }
}

/// 数据解析
- (void) initData{
    for (int i=0; i<self.cityModel.groups.count; i++) {
        NSMutableArray *dataArray = self.cityModel.groups[i].list;
        for (int j=0; j<dataArray.count; j++) {
            CityModel *model = dataArray[j];
            [self.itemModelArray addObject:model];
        }
    }

    //通讯录分组，乱序的
    _letterResultDictionary = [LZChineseSort sortAndGroupForArray:self.itemModelArray PropertyName:@"site_name"];
    
    //抽取排序，A，B，C
    _indexArray = [LZChineseSort sortForStringAry:[_letterResultDictionary allKeys]];
    [_indexArray insertObject:@"当前城市" atIndex:0];
    [_indexArray insertObject:@"热门城市" atIndex:1];
    _searchResultsArray = [NSMutableArray new];
    _searchResultsDictionary = [NSDictionary new];
    _searchResultsIndexArray = [NSMutableArray new];
}

/// 获取城市数据
- (void) getCityDataRequest{
    [MBProgressHUD showMessage:@"" toView:self.view];
    [SCHttpTools getWithURLString:@"site/groups" parameter:nil success:^(id responseObject) {
        NSDictionary *result = responseObject;
        if ([result isKindOfClass:[NSDictionary class]]) {

            FMSelectedCityModel *model = [FMSelectedCityModel mj_objectWithKeyValues:result];
            if (model.errcode == 0) {
                self.cityModel = model.data;
                [self.itemModelArray removeAllObjects];
                [self initData];
            }else {
                Toast([result lz_objectForKey:@"message"]);
            }
            [self.tableView reloadData];
        }else{
            Toast(@"获取城市数据失败");
        }
        [MBProgressHUD hideHUDForView:self.view];
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        TTLog(@" -- error -- %@",error);
        [self.tableView.mj_header endRefreshing];
        [MBProgressHUD hideHUDForView:self.view];
    }];
}

#pragma mark - UISearchResultsUpdating - UISearchDelegate
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    //  清空搜索结果
    [_searchResultsArray removeAllObjects];
    NSArray *searchArray = [NSArray new];
    //对排序好的数据进行搜索
    searchArray = [LZChineseSort getAllValuesFromDictionary:_letterResultDictionary];
    
    if (searchController.searchBar.text.length == 0) {
        [_searchResultsArray addObjectsFromArray:searchArray];
        
        // 根据搜索结果中的数据进行name再次排序
        _searchResultsDictionary = [LZChineseSort sortAndGroupForArray:_searchResultsArray PropertyName:@"site_name"];
        _searchResultsIndexArray = [LZChineseSort sortForStringAry:[_searchResultsDictionary allKeys]];
    } else {
        // 被搜索的字符串
        self.searchText = searchController.searchBar.text;
        // 根据姓名进行搜索(name)
        searchArray = [LZPinYinSearch searchWithOriginalArray:searchArray
                                                andSearchText:self.searchText
                                      andSearchByPropertyName:@"site_name"];
        // 将搜索的数据放到数组
        [_searchResultsArray addObjectsFromArray:searchArray];
        // 根据搜索结果中的数据进行name再次排序
        _searchResultsDictionary = [LZChineseSort sortAndGroupForArray:_searchResultsArray PropertyName:@"site_name"];
        _searchResultsIndexArray = [LZChineseSort sortForStringAry:[_searchResultsDictionary allKeys]];
    }
    [self.tableView reloadData];
}

#pragma mark - Table view data source
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger idx = indexPath.section;
    NSUInteger row = [indexPath row];
    NSUInteger section = [indexPath section];
    
    //获得对应的PVTongxunluModel对象<替换为你自己的model对象>
    if (!self.searchController.active) {
        if (idx>1) {
            FMGroupsCityTableViewCell* tools = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierGroups forIndexPath:indexPath];
            NSArray *value = [self.letterResultDictionary objectForKey:[self.indexArray lz_safeObjectAtIndex:section]];
            CityModel *model = value[row];
            tools.titleLabel.text = model.site_name;
            return tools;
        }else{
            FMCurrentCitysTableViewCell* tools = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierCurrent forIndexPath:indexPath];
            tools.delegate = self;
            tools.indexPath = indexPath;
            if (idx==0) {
                tools.isIcon = YES;
                tools.currentModel = self.cityModel.current;
            }else{
                tools.isIcon = NO;
                tools.hotsModel = self.cityModel.hots;
            }
            return tools;
        }
    }else{
        FMGroupsCityTableViewCell* tools = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierGroups forIndexPath:indexPath];
        NSArray *value = [self.searchResultsDictionary objectForKey:[self.searchResultsIndexArray lz_safeObjectAtIndex:section]];
        CityModel *model = [value lz_safeObjectAtIndex:row];
        tools.titleLabel.text = model.site_name;
        return tools;
    }
//    if (idx>1) {
//        FMGroupsCityTableViewCell* tools = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierGroups forIndexPath:indexPath];
////        CityModel *model = self.cityModel.groups[idx-2].city[indexPath.row];
//        CityModel *model = self.
//        tools.titleLabel.text = model.site_name;
//    }else{
//
//    }
}

// 多少个分组 section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (!self.searchController.active) {
        return self.indexArray.count;
//        return self.letterResultDictionary.count+2;
    }else {
        return self.searchResultsIndexArray.count;
    }
}

/// 返回多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    if (section==0) return 1;
//    if (section==1) return self.cityModel.hots.count>1?1:self.cityModel.hots.count;
//    CityGroupsModel *model = self.cityModel.groups[section-2];
//    return model.city.count;
    
    if (!self.searchController.active) {
        if (section==0) return 1;
        if (section==1) return self.cityModel.hots.count>1?1:self.cityModel.hots.count;
        NSArray *value = [self.letterResultDictionary objectForKey:[self.indexArray lz_safeObjectAtIndex:section]];
        return value.count;
    }else {
        NSArray *value = [self.searchResultsDictionary objectForKey:[self.searchResultsIndexArray lz_safeObjectAtIndex:section]];
        return value.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!self.searchController.active) {
        if (self.heightAtIndexPath[indexPath]) {
            NSNumber *num = self.heightAtIndexPath[indexPath];
            return [num floatValue];
        }
    }
    return UITableViewAutomaticDimension;
}

/// 点击TableViewCell事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSUInteger row = [indexPath row];
    NSUInteger section = [indexPath section];
    CityModel *model;
    if (!self.searchController.active) {
        NSArray *value = [self.letterResultDictionary objectForKey:[self.indexArray lz_safeObjectAtIndex:section]];
        model = value[row];
    }else{
        NSArray *value = [_searchResultsDictionary objectForKey:[_searchResultsIndexArray lz_safeObjectAtIndex:section]];
        model = value[row];
    }
    TTLog(@"value[row] --- %@",model.site_name);
    kUserInfo.cityName = model.site_name;
    kUserInfo.site_id = [NSString stringWithFormat:@"%ld",(long)model.site_id];
    kUserInfo.city_id = [NSString stringWithFormat:@"%ld",(long)model.city_id];
    [kUserInfo dump];
    [kNotificationCenter postNotificationName:@"NoticeCityHasUpdate" object:nil];
    [self cancelBtnClick];[self cancelBtnClick];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -- 设置Header高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 27.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

//section右侧index数组
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    if (!self.searchController.active) {
        return self.indexArray;
    }else {
        return nil;
    }
}

//  点击右侧索引表项时调用 索引与section的对应关系
//  自定义索引与数组的对应关系 (响应点击索引时的委托方法) //索引列点击事件
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index{
    [tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    return index;
}

#pragma mark -- Section HearderView Title
// UITableView在Plain类型下，HeaderView和FooterView不悬浮和不停留的方法
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    sectionView = [[FMCitySectionView alloc] init];
    if (!self.searchController.active) {
        sectionView.labelTitle.text = [self.indexArray lz_safeObjectAtIndex:section];
    }else {
        sectionView.labelTitle.text = [_searchResultsIndexArray lz_safeObjectAtIndex:section];
    }
    return sectionView;
}

// UITableView在Plain类型下，HeaderView和FooterView不悬浮和不停留的方法
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView lz_viewWithColor:kTableViewInSectionColor];
}

#pragma mark ====== FMTravelTableViewCellDelegate ======
- (void)updateTableViewCellHeight:(FMCurrentCitysTableViewCell *)cell andheight:(CGFloat)height andIndexPath:(NSIndexPath *)indexPath {
    if (![self.heightAtIndexPath[indexPath] isEqualToNumber:@(height)]) {
        self.heightAtIndexPath[indexPath] = @(height);
        [self.tableView reloadData];
    }
}

//点击UICollectionViewCell的代理方法
- (void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath withContent:(NSString *)content {
    TTLog(@" 城市名字 -- - %ld\n---%@",(long)indexPath.row,content);
    NSDictionary *dataDic = [NSDictionary dictionaryWithObject:kUserInfo.cityName forKey:@"info"];
    [kNotificationCenter postNotificationName:@"NoticeCityHasUpdate" object:nil userInfo:dataDic];
    [self cancelBtnClick];
}

#pragma mark ----- getter/setter
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.showsVerticalScrollIndicator = false;
        [_tableView registerClass:[FMHotsCityTableViewCell class] forCellReuseIdentifier:reuseIdentifierHots];
        [_tableView registerClass:[FMGroupsCityTableViewCell class] forCellReuseIdentifier:reuseIdentifierGroups];
        [_tableView registerClass:[FMCurrentCitysTableViewCell class] forCellReuseIdentifier:reuseIdentifierCurrent];
        [_tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 34)];
        //1 禁用系统自带的分割线
        //        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = kViewColorNormal;
        _tableView.rowHeight = UITableViewAutomaticDimension;
    }
    return _tableView;
}

- (UISearchController *)searchController {
    if (!_searchController) {
        _searchController = [[UISearchController alloc]initWithSearchResultsController:nil];
        _searchController.searchResultsUpdater = self;
        _searchController.delegate = self;
        _searchController.dimsBackgroundDuringPresentation = NO;
        _searchController.hidesNavigationBarDuringPresentation = YES;
        _searchController.searchBar.placeholder = @"请输入要找的城市名称";
        //改变取消按钮字体颜色
        UIColor *color = self.navigationController.navigationBar.barTintColor;
        _searchController.searchBar.barTintColor= color;
        [_searchController.searchBar setBackgroundImage:[UIImage lz_imageWithColor:color]];
        UITextField *searchField=[_searchController.searchBar valueForKey:@"searchField"];
        searchField.backgroundColor = kColorWithRGB(246, 247, 251);
        searchField.font = kFontSizeMedium14;
        searchField.textColor = kTextColor170;
        _searchController.searchBar.contentMode = UIViewContentModeCenter;
        self.definesPresentationContext = YES;
        [_searchController.searchBar sizeToFit];
    }
    return _searchController;
}

- (NSMutableArray *)itemModelArray{
    if (!_itemModelArray) {
        _itemModelArray = [[NSMutableArray alloc] init];
    }
    return _itemModelArray;
}

- (NSMutableDictionary *)heightAtIndexPath {
    if (!_heightAtIndexPath) {
        _heightAtIndexPath = [[NSMutableDictionary alloc] init];
    }
    return _heightAtIndexPath;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
