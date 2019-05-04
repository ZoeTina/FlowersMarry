//
//  FMComboListDetailLeftViewController.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/10/30.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMComboListDetailLeftViewController.h"

#import "FMPictureWithTextCellPicture.h"
#import "FMComboListTableViewCell.h"
#import "FMWorksListTableViewCell.h"

#import "FMComboListDetailsViewController.h"
#import "FMWorksListDetailsViewController.h"

static NSString * const reuseIdentifierTemplateWorks = @"FMWorksListTableViewCell";
static NSString * const reuseIdentifierTemplateCombo = @"FMComboListViewController";
static NSString * const reuseIdentifierTemplatePicture = @"FMPictureWithTextCellPicture";
static NSString * const reuseIdentifierSectionHeaderView = @"SCTableViewSectionHeaderView";

@interface FMComboListDetailLeftViewController()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, assign) NSInteger pageSize;
@property (nonatomic, strong) NSMutableArray *itemModelArray;
@property (nonatomic, strong) NSMutableDictionary *heightAtIndexPath;
@property (nonatomic, assign) BOOL isFirstReload;

@end

@implementation FMComboListDetailLeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initView];
    self.title = @"套餐详情";
    self.isFirstReload = YES;
    UIView *linerView = [UIView lz_viewWithColor:kTextColor238];
    [self.view addSubview:linerView];
    [linerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.equalTo(@(0.66));
    }];
}

- (void) initView{
    
    [Utils lz_setExtraCellLineHidden:self.tableView];
    [self.view addSubview:self.tableView];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(0.66));
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(-(kiPhoneX_T(50)));
    }];
}

- (void)setTaoxiModel:(BusinessTaoxiModel *)taoxiModel{
    _taoxiModel = taoxiModel;
    if (self.isFirstReload) {
        [self loadCasesDataRequest];
        [self.tableView reloadData];
//        NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:1];
//        [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
        self.isFirstReload = NO;
    }
}

/// 获取套餐作品列表数据
- (void) loadCasesDataRequest{
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setObject:self.taoxiModel.tx_id forKey:@"tx_id"];
    [parameter setObject:@(self.pageSize) forKey:@"size"];
    [parameter setObject:@(self.pageIndex) forKey:@"p"];
    [SCHttpTools getWithURLString:@"zuo_pin/txreflist" parameter:parameter success:^(id responseObject) {
        NSDictionary *result = responseObject;
        if ([result isKindOfClass:[NSDictionary class]]) {
            FMGeneralModel *genralModel = [FMGeneralModel mj_objectWithKeyValues:responseObject];
            if (genralModel.errcode==0) {
                BusinessCasesListDataModel *model = [BusinessCasesListDataModel mj_objectWithKeyValues:responseObject[@"data"]];
                if (self.pageIndex==1) {
                    [self.itemModelArray removeAllObjects];
                }
                [self.itemModelArray addObjectsFromArray:model.list];
            }
            TTLog(@"itemModelArray -- %lu",(unsigned long)self.itemModelArray.count);
            
        }
        
        NSIndexSet *indexSet = [[NSIndexSet alloc] initWithIndex:2];
        [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSError *error) {
        TTLog(@"获取精品套餐数据---- %@",error);
        [self.tableView.mj_header endRefreshing];
    }];
}

#pragma mark - Table view data source
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        FMPictureWithTextCellPicture *tools = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierTemplatePicture forIndexPath:indexPath];
        tools.backgroundColor = kColorWithRGB(211, 0, 0 );
        BusinessCasesPhotoModel *photoModel = self.taoxiModel.photo[indexPath.row];
        photoModel.p_filename = @"//pic6.wed114.cn/20180531/2018053115572077512072.jpg";
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
    }else if(indexPath.section == 1){
        FMComboListTableViewCell *tools = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierTemplateCombo forIndexPath:indexPath];
//        tools.taoxiModel = self.taoxiModel.txlist[indexPath.row];
//        if (indexPath.row != 0) {
//            tools.linerViewCell.hidden = NO;
//        }
        return tools;
    }else if(indexPath.section == 2){
        FMWorksListTableViewCell *tools = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierTemplateWorks forIndexPath:indexPath];
        tools.casesModel = self.itemModelArray[indexPath.row];
        
        TTLog(@"tools.casesModel --- %@",tools.casesModel.case_thumb);
        return tools;
    }
    return [UITableViewCell new];
}

// 多少个分组 section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

/// 返回多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section==0)return self.taoxiModel.photo.count;
    if (section==1)return self.taoxiModel.txlist.count;
    if (section==2)return self.itemModelArray.count;
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        float heightAtIndexPath = [[self.heightAtIndexPath objectForKey:@(indexPath.row)] floatValue];
        NSNumber *heights = [NSNumber numberWithFloat:heightAtIndexPath];
        NSNumber *height = [NSNumber numberWithFloat:heightAtIndexPath];
        if ([heights compare:height] == -1) {
            return 180;
        }else{
            return heightAtIndexPath;
        }
    } else if (indexPath.section==1){
        return IPHONE6_W(133);
    } else if (indexPath.section==2){
        if (indexPath.row==2) return IPHONE6_W(335);
        return IPHONE6_W(320);
    }
    return UITableViewAutomaticDimension;
}

/// 点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section==1){
        BusinessTaoxiModel *taoxiModel = self.taoxiModel.txlist[indexPath.row];
        FMComboListDetailsViewController *vc = [[FMComboListDetailsViewController alloc] init];
        vc.taoxiDataModel = taoxiModel;
        TTPushVC(vc);
    }else if (indexPath.section==2) {
        BusinessCasesModel *casesModel = self.itemModelArray[indexPath.row];
        FMWorksListDetailsViewController *vc = [[FMWorksListDetailsViewController alloc] init];
        vc.casesDadaModel = casesModel;
        TTPushVC(vc);
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -------------- 设置Header高度 --------------
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) return 0.1f;
    return (section==1||section==2) ? 44.0f : 0.1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return (section==2) ? 0.f :10.f;
}

// UITableView在Plain类型下，HeaderView和FooterView不悬浮和不停留的方法
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView lz_viewWithColor:kTableViewInSectionColor];
}

#pragma mark -------------- 设置组头 --------------
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return nil;
    }
    SCTableViewSectionHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:reuseIdentifierSectionHeaderView];
    NSString *titleTextStr = @"";
    NSString *subtitleTestStr = @"";
    if (section==1) {
        titleTextStr = @"热门套餐";
    }else if (section==2) {
        titleTextStr = @"相关作品";
    }
    headerView.arrowImageView.hidden = YES;
    headerView.titleLabel.text = titleTextStr;
    headerView.subtitleLabel.text = subtitleTestStr;
    return headerView;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.showsVerticalScrollIndicator = false;
        [_tableView registerClass:[SCTableViewSectionHeaderView class] forHeaderFooterViewReuseIdentifier:reuseIdentifierSectionHeaderView];
        [_tableView registerClass:[FMComboListTableViewCell class] forCellReuseIdentifier:reuseIdentifierTemplateCombo];
        
        [_tableView registerClass:[FMWorksListTableViewCell class] forCellReuseIdentifier:reuseIdentifierTemplateWorks];
        [_tableView registerClass:[FMPictureWithTextCellPicture class] forCellReuseIdentifier:reuseIdentifierTemplatePicture];
        
        [_tableView setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
        //1 禁用系统自带的分割线
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = kWhiteColor;
    }
    return _tableView;
}

- (NSMutableArray *)itemModelArray{
    if (!_itemModelArray) {
        _itemModelArray = [[NSMutableArray alloc] init];
    }
    return _itemModelArray;
}

- (NSMutableDictionary *)heightAtIndexPath{
    if (!_heightAtIndexPath) {
        _heightAtIndexPath = [NSMutableDictionary dictionary];
    }
    return _heightAtIndexPath;
}
@end
