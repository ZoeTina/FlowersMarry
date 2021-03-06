//
//  FMTourismShootingViewController.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/6/28.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMTourismShootingViewController.h"
#import "FMVideoTableViewCell.h"
#import "FMImagesTableViewCell.h"
#import "FMMoreImagesTableViewCell.h"
#import "FMImagesRightTableViewCell.h"
#import "FMImagesTransverseThreeTableViewCell.h"
#import "FMPictureWithTextViewController.h"
#import "FMShowPhotoCollectionViewController.h"
#import "SCVideoPlayViewController.h"

static NSString * const reuseIdentifierVideo = @"FMVideoTableViewCell";
static NSString * const reuseIdentifierImage = @"FMImagesTableViewCell";
static NSString * const reuseIdentifierMoreImage = @"FMMoreImagesTableViewCell";
static NSString * const reuseIdentifierRightImage = @"FMImagesRightTableViewCell";
static NSString * const reuseIdentifierThreeImage = @"FMImagesTransverseThreeTableViewCell";
@interface FMTourismShootingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *itemModelArray;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) UIView *headerView;


/// 顶部图片
@property (nonatomic, strong) UIImageView *headerImageView;
/// 头像
@property (nonatomic, strong) UIImageView *avatarImageView;
/// 城市地方
@property (nonatomic, strong) UILabel *cityLabel;
/// 地方标签
@property (nonatomic, strong) SCCustomMarginLabel *placeLabel;

@property (nonatomic, assign) CGFloat headViewHeight;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, assign) NSInteger site_id;
@end

@implementation FMTourismShootingViewController
- (id)initIndexPath:(NSIndexPath *)indexPath{
    if ( self = [super init] ){
        self.indexPath = indexPath;
        //    site_id 三亚:5 大理:207 厦门:2 丽江:4 大连:12 青岛:3
        switch (self.indexPath.row) {
            case 0:
            {
                self.site_id = 5;
            }
                break;
            case 1:
            {
                self.site_id = 3;
            }
                break;
            case 2:
            {
                self.site_id = 4;
            }
                break;
            case 3:
            {
                self.site_id = 12;
            }
                break;
            case 4:
            {
                self.site_id = 2;
            }
                break;
            case 5:
            {
                self.site_id = 207;
            }
                break;
            default:
                break;
        }
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.headViewHeight = 229;
    [self initView];
    self.cityLabel.text = self.dataArray[self.indexPath.row][@"city"];
    self.placeLabel.text = self.dataArray[self.indexPath.row][@"title"];
    self.headerImageView.image = kGetImage(self.dataArray[self.indexPath.row][@"images"]);
    self.avatarImageView.image = kGetImage(self.dataArray[self.indexPath.row][@"header"]);
    self.title = self.dataArray[self.indexPath.row][@"city"];
}

- (void) initView{
    
    [Utils lz_setExtraCellLineHidden:self.tableView];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(kLinerViewHeight));
        make.bottom.left.right.equalTo(self.view);
    }];
    self.tableView.tableHeaderView = self.headerView;
    
    [self.headerView addSubview:self.headerImageView];
    [self.headerView addSubview:self.avatarImageView];
    [self.headerView addSubview:self.cityLabel];
    [self.headerView addSubview:self.placeLabel];
    [self.headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.headerView);
    }];
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@30);
        make.bottom.equalTo(self.headerImageView.mas_bottom);
    }];
    [self.cityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.avatarImageView);
        make.bottom.equalTo(self.headerView.mas_bottom).offset(-17);
    }];
    [self.placeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.cityLabel);
        make.left.equalTo(self.cityLabel.mas_right).mas_offset(10);
        make.height.equalTo(@24);
    }];
    

}

#pragma mark - Table view data source
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row==0) {/// 图文  ---  1:一张封面图
        FMImagesRightTableViewCell* tools = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierRightImage forIndexPath:indexPath];
        tools.titleLabel.text = @"【拉斐·唯美花坊】精选客照欣赏";
        tools.nicknameLabel.text = @"三亚海漫飞丝婚纱摄影";
        tools.datetimeLabel.text = @"5分钟前";
        tools.likeCountLabel.text = @"3432";
        
        tools.imagesView.image = kGetImage(@"图层22");
        tools.avatarImageView.image = kGetImage(@"logo1");
        return tools;
    }else if (indexPath.row==1){
        FMImagesTransverseThreeTableViewCell* tools = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierThreeImage forIndexPath:indexPath];
        tools.titleLabel.text = @"【拉斐·唯美花坊】精选客照欣赏";
        tools.nicknameLabel.text = @"三亚薇爱婚纱摄影";
        tools.datetimeLabel.text = @"5分钟前";
        tools.likeCountLabel.text = @"3432";
        
        tools.imagesViewLeft.image = kGetImage(@"图1");
        tools.imagesViewCenter.image = kGetImage(@"图2");
        tools.imagesViewRight.image = kGetImage(@"图3");
        tools.avatarImageView.image = kGetImage(@"logo1");
        return tools;
    }else if (indexPath.row==2){/// 图集  ---  1:一张封面图
        FMImagesTableViewCell* tools = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierImage forIndexPath:indexPath];
        tools.titleLabel.text = @"人生只要两次幸运便好。";
        tools.nicknameLabel.text = @"三亚海漫飞丝婚纱摄影";
        tools.datetimeLabel.text = @"5分钟前";
        tools.likeCountLabel.text = @"3432";

        tools.imagesView.image = kGetImage(@"图层23");
        tools.avatarImageView.image = kGetImage(@"logo1");
        NSString *imagesCount = [NSString stringWithFormat:@"%d 图",9];
        [tools.imagesCountButton setTitle:imagesCount forState:UIControlStateNormal];
        return tools;
    }else if(indexPath.row==3){
        FMMoreImagesTableViewCell* tools = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierMoreImage forIndexPath:indexPath];
        tools.titleLabel.text = @"人生只要两次幸运便好。";
        tools.nicknameLabel.text = @"三亚海漫飞丝婚纱摄影";
        tools.datetimeLabel.text = @"5分钟前";
        tools.likeCountLabel.text = @"3432";
        
        tools.imagesViewLeft.image = kGetImage(@"图层24");
        tools.imagesViewTop.image = kGetImage(@"图层25");
        tools.imagesViewBottom.image = kGetImage(@"图层26");
        tools.avatarImageView.image = kGetImage(@"logo1");
        NSString *imagesCount = [NSString stringWithFormat:@"%d 图",9];
        [tools.imagesCountButton setTitle:imagesCount forState:UIControlStateNormal];
        return tools;
    }else{/// 视频
        FMVideoTableViewCell* tools = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierVideo forIndexPath:indexPath];
        tools.titleLabel.text = @"成都维纳斯婚纱微电影《待嫁新娘》韩国婚纱微电影婚纱mv";
        tools.nicknameLabel.text = @"成都维纳斯婚纱摄影工作室";
        tools.datetimeLabel.text = @"4天前";
        tools.likeCountLabel.text = @"3432";
        tools.imagesView.image = kGetImage(@"图3");
        tools.avatarImageView.image = kGetImage(@"logo1");

        return tools;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    DynamicModel *dynamicModel = self.itemModelArray[indexPath.row];
//    switch (dynamicModel.shape) {
//        case 1:/// 图文
//        {
//            FMPictureWithTextViewController *vc = [[FMPictureWithTextViewController alloc] initHomeDataModel:dynamicModel];
//            TTPushVC(vc);
//        }
//            break;
//        case 2:/// 图集
//        {
//            FMShowPhotoCollectionViewController *vc = [[FMShowPhotoCollectionViewController alloc] initHomeDataModel:dynamicModel];
//            TTPushVC(vc);
//        }
//            break;
//        case 3:/// 视频
//        {
//            SCVideoPlayViewController *vc = [[SCVideoPlayViewController alloc] initHomeDataModel:dynamicModel];
//            TTPushVC(vc);
//        }
//            break;
//    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark -- Section HearderView Title
//---------------------------------------------------------------------------------------------------------------------------------------------
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *sectionView = [[UIView alloc] init];
    sectionView.backgroundColor = kColorWithRGB(244, 244, 244);
    sectionView.frame = CGRectMake(0, 0, kScreenWidth,37);

    UIView *titleView = [[UIView alloc] init];
    titleView.backgroundColor = kWhiteColor;
    [sectionView addSubview:titleView];
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@7);
        make.left.right.bottom.equalTo(sectionView);
    }];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = kGetImage(@"business_biaoti");
    [titleView addSubview:imageView];

    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.centerX.equalTo(titleView);
    }];
    
    UILabel *titleLabel = [UILabel lz_labelWithTitle:@"旅拍精选"
                                               color:[UIColor lz_colorWithHexString:@"FF4163"]
                                                font:kFontSizeScBold16];
    [titleView addSubview:titleLabel];

    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.centerX.equalTo(titleView);
    }];
    return sectionView;
}

#pragma mark -- 设置Header高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}

- (UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.showsVerticalScrollIndicator = false;
        [_tableView registerClass:[FMVideoTableViewCell class] forCellReuseIdentifier:reuseIdentifierVideo];
        [_tableView registerClass:[FMImagesTableViewCell class] forCellReuseIdentifier:reuseIdentifierImage];
        [_tableView registerClass:[FMMoreImagesTableViewCell class] forCellReuseIdentifier:reuseIdentifierMoreImage];
        [_tableView registerClass:[FMImagesRightTableViewCell class] forCellReuseIdentifier:reuseIdentifierRightImage];
        [_tableView registerClass:[FMImagesTransverseThreeTableViewCell class] forCellReuseIdentifier:reuseIdentifierThreeImage];
        [_tableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
//        _tableView.contentInset = UIEdgeInsetsMake(CGRectGetMaxY(self.headerView.frame), 0, 0, 0);
//        _tableView.scrollIndicatorInsets = UIEdgeInsetsMake(CGRectGetMaxY(self.headerView.frame), 0, 0, 0);

        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = kViewColorNormal;
    }
    return _tableView;
}

- (NSMutableArray *)itemModelArray{
    if (!_itemModelArray) {
        _itemModelArray = [[NSMutableArray alloc] init];
    }
    return _itemModelArray;
}

- (UIView *)headerView{
    if (!_headerView) {
        _headerView = [UIView lz_viewWithColor:kWhiteColor];
        _headerView.frame = CGRectMake(0, 0, kScreenWidth, self.headViewHeight);
    }
    return _headerView;
}

- (UIImageView *)headerImageView{
    if (!_headerImageView) {
        _headerImageView = [[UIImageView alloc] init];
    }
    return _headerImageView;
}

- (UIImageView *)avatarImageView{
    if (!_avatarImageView) {
        _avatarImageView = [[UIImageView alloc] init];
    }
    return _avatarImageView;
}

- (UILabel *)cityLabel{
    if (!_cityLabel) {
        _cityLabel = [UILabel lz_labelWithTitle:@"" color:kBlackColor font:kFontSizeScBold20];
    }
    return _cityLabel;
}

- (SCCustomMarginLabel *)placeLabel{
    if (!_placeLabel) {
        _placeLabel = [[SCCustomMarginLabel alloc] init];
        _placeLabel.textColor = kWhiteColor;;
        _placeLabel.font = kFontSizeMedium12;
        _placeLabel.edgeInsets = UIEdgeInsetsMake(4, 8, 4, 8);
        _placeLabel.backgroundColor = [UIColor lz_colorWithHexString:@"#FDA73F"];
        [self.placeLabel setCornerRadius:24.0/2.0];

    }
    return _placeLabel;
}

- (NSArray *)dataArray{
    if (!_dataArray) {
        _dataArray = @[@{@"images":@"lv_header_sanyabc",@"header":@"lv_header_sanyaphoto",@"title":@"东方夏威夷",@"city":@"三亚"},
                       @{@"images":@"lv_header_qingdao",@"header":@"lv_header_qingdaophoto",@"title":@"绝美金沙滩",@"city":@"青岛"},
                       @{@"images":@"lv_header_xiamen",@"header":@"lv_header_xiamenphoto",@"title":@"文艺小资海上花园",@"city":@"厦门"},
                       @{@"images":@"lv_header_dalian",@"header":@"lv_header_dalianphoto",@"title":@"异国风情浪漫之都",@"city":@"大连"},
                       @{@"images":@"lv_header_lijiang",@"header":@"lv_header_lijiangphoto",@"title":@"文艺旅拍圣地",@"city":@"丽江"},
                        @{@"images":@"lv_header_dali",@"header":@"lv_header_daliphoto",@"title":@"东方瑞士",@"city":@"大理"}];
    }
    return _dataArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
