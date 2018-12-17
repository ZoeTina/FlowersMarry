//
//  FMMineViewController.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/6/27.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMMineViewController.h"
#import "FMMineTableViewCell.h"
#import "FMPersonModel.h"
#import "FMMineTableHeaderView.h"
#import "FMPersonalViewController.h"
#import "FMLikeMerchantsViewController.h"
#import "FMLikeDynamicViewController.h"
#import "FMTelPhoneBindViewController.h"
#import "FMTelPhoneUpdateViewController.h"
#import "FMThirdPartyViewController.h"
#import "FMLoginViewController.h"
#import "FMMineConventionViewController.h"
#import "FMMineMommentsViewController.h"
#import "FMMineReviewViewController.h"

#import "SCImagePicker.h"


static NSString * const reuseIdentifier = @"FMMineTableViewCell";

@interface FMMineViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *itemModelArray;
@property (nonatomic, strong) FMMineTableHeaderView *tableHeadView;
@property (nonatomic, strong) SCImagePicker *imagePicker;
@property (nonatomic, strong) MineModel *mineModel;
@property (nonatomic, strong) NSMutableArray<ThirdModel *> *thirdModel;

@end

@implementation FMMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initView];
    // 注册通知
    [kNotificationCenter addObserver:self selector:@selector(changeUserInfo) name:@"changeUserInfo" object:nil];
    [kNotificationCenter addObserver:self selector:@selector(loadMineModelRequest) name:@"reloadMineData" object:nil];
    [self loadMineModelRequest];
}

- (void) changeUserInfo{
    self.tableHeadView.nickNameLabel.text = kUserInfo.username;
}
- (void) initView{
    [Utils lz_setExtraCellLineHidden:self.tableView];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(kLinerViewHeight));
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(-kTabBarHeight);
    }];
    [self setupUI];
}

/// 获取作品列表数据
- (void) loadMineModelRequest{
    [SCHttpTools getWithURLString:@"user/info" parameter:nil success:^(id responseObject) {
        if (responseObject) {
            FMMineModel *model = [FMMineModel mj_objectWithKeyValues:responseObject];
            if (model.errcode==0) {
                self.mineModel = model.data;
                TTLog(@" -- - %@",self.mineModel.avatar);
                kUserInfo.avatar = self.mineModel.avatar;
                [kUserInfo dump];
                TTLog(@" -- - %@",kUserInfo.avatar);
                [self.tableHeadView.imagesView sc_setImageWithUrlString:self.mineModel.avatar
                                                       placeholderImage:kGetImage(@"mine_icon_avatar")
                                                               isAvatar:false];
            }
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        TTLog(@"获取我的数据---- %@",error);
    }];
    [SCHttpTools getWithURLString:@"user/bindlist" parameter:nil success:^(id responseObject) {
        if (responseObject) {
            ThirdPartyModel *model = [ThirdPartyModel mj_objectWithKeyValues:responseObject];
            if (model.errcode==0) {
                self.thirdModel = model.data;
            }
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        TTLog(@"获取我的数据---- %@",error);
    }];
}

-(void)setupUI{
    self.tableHeadView = [[FMMineTableHeaderView alloc] init];
    self.tableHeadView.width = kScreenWidth;
    self.tableHeadView.height = IPHONE6_W(80);
    self.tableView.tableHeaderView = self.tableHeadView;
    [self changeUserInfo];
    [self setAvatarImages];
    MV(weakSelf)
    [self.tableHeadView setMineTableHeadViewBlock:^{
        FMPersonalViewController *vc = [[FMPersonalViewController alloc] init];
        [vc setHidesBottomBarWhenPushed:YES];
        [weakSelf.navigationController pushViewController:vc animated:YES];
    }];
    
    [self.tableHeadView.avatarButton lz_handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        [weakSelf imagePicker];
    }];
}

- (void) setAvatarImages{
    TTLog(@"kUserInfo.avatar --- %@",kUserInfo.avatar);
    [self.tableHeadView.imagesView sc_setImageWithUrlString:kUserInfo.avatar
                                           placeholderImage:kGetImage(@"mine_icon_avatar")
                                                   isAvatar:false];
}

/// 上传头像
- (void) uploadHeaderImageWithImageUrl:(NSString *)imageUrl{
    MV(weakSelf)
    NSDictionary *parameter = @{@"avator":imageUrl};
    [SCHttpTools getWithURLString:updateAvatar parameter:parameter success:^(id responseObject) {
        TTLog(@"上传头像URL%@",[Utils lz_dataWithJSONObject:responseObject]);
        NSDictionary *result = responseObject;
        [MBProgressHUD hideHUDForView:self.view];
        if (result) {
            if ([[result lz_objectForKey:@"errcode"] integerValue] == 0) {
                kUserInfo.avatar = imageUrl;
                [kUserInfo dump];
                [weakSelf setAvatarImages];
            }else {
                Toast([result lz_objectForKey:@"message"]);
            }
        }else {
            Toast(@"头像上传失败");
        }
    } failure:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view];
        TTLog(@" --- %@",error);
    }];
}


#pragma mark - Table view data source
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FMMineTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    FMPersonModel* model = self.itemModelArray[indexPath.section][indexPath.row];
    model.index = indexPath.item;
    cell.personModel = model;

    if (indexPath.section==0) {
        if (indexPath.row==0) {
            cell.subtitleLabel.text = self.mineModel.count.fllow;
        }else if(indexPath.row==1){
            cell.subtitleLabel.text = self.mineModel.count.feed_collect;
        }else{
            cell.subtitleLabel.text = self.mineModel.count.feed_comment;
        }
    }else if(indexPath.section==1){
        if (indexPath.row==0) {
            cell.subtitleLabel.text = self.mineModel.count.yuyue;
        }else{
            cell.subtitleLabel.text = self.mineModel.count.comment;
        }
    }else if(indexPath.section==2){
        if (indexPath.row==0) {
            cell.subtitleLabel.text = self.mineModel.mobile.length>0?@"已绑定":@"未绑定";
        }else{
            cell.subtitleLabel.text = self.thirdModel.count>0?@"已绑定":@"未绑定";
        }
    }
    return cell;
}

// 多少个分组 section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

/// 返回多少
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *subArray = [self.itemModelArray lz_safeObjectAtIndex:section];
    return subArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return IPHONE6_W(63);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    FMPersonModel* model = self.itemModelArray[indexPath.section][indexPath.row];
    NSString *className = model.showClass;
    if ([model.showClass isEqualToString:@"FMTelPhoneBindViewController"]) {
//        className = !self.mineModel.mobile_bind?@"FMTelPhoneUpdateViewController":@"FMTelPhoneBindViewController";
    }
    
    Class controller = NSClassFromString(className);
    
    //    id controller = [[NSClassFromString(className) alloc] init];
    if (controller &&  [controller isSubclassOfClass:[UIViewController class]]){
        UIViewController *view = [[controller alloc] init];
        view.title = model.title;
        [view setHidesBottomBarWhenPushed:YES];
        [self.navigationController pushViewController:view animated:YES];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.showsVerticalScrollIndicator = false;
        [_tableView registerClass:[FMMineTableViewCell class] forCellReuseIdentifier:reuseIdentifier];
        [_tableView setSeparatorInset:UIEdgeInsetsMake(0,IPHONE6_W(65),0,0)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = kColorWithRGB(245, 244, 249);
    }
    return _tableView;
}

- (NSMutableArray *)itemModelArray{
    if (!_itemModelArray) {
        _itemModelArray = [[NSMutableArray alloc] init];
        
        NSArray* titleArr = @[@[@"关注商家",@"我喜欢的",@"我的评论"],
                              @[@"我的预约",@"我的点评"],
                              @[@"手机号绑定",@"第三方绑定"]];
        NSArray* imagesArr = @[@[@"mine_btn_follow",@"mine_btn_like",@"mine_btn_comment"],
                               @[@"mine_btn_yuyue",@"mine_btn_dianping"],
                               @[@"mine_btn_phone",@"mine_btn_Thirdparty"]];
        NSArray* subtitleArr = @[@[@"0",@"0",@"0"],
                               @[@"0",@"0"],
                               @[@"已绑定",@"未绑定"]];
        NSArray* classArr = @[@[@"FMLikeMerchantsViewController",@"FMLikeDynamicViewController",@"FMMineMommentsViewController"],
                              @[@"FMMineConventionViewController",@"FMMineReviewViewController"],
                              @[@"FMTelPhoneBindViewController",@"FMThirdPartyViewController"]];
        for (int i=0; i<titleArr.count; i++) {
            NSArray *subTitlesArray = [titleArr lz_safeObjectAtIndex:i];
            NSArray *subImagesArray = [imagesArr lz_safeObjectAtIndex:i];
            NSArray *subtitleArray = [subtitleArr lz_safeObjectAtIndex:i];
            NSArray *classArray = [classArr lz_safeObjectAtIndex:i];
            NSMutableArray *subArray = [NSMutableArray array];
            for (int j = 0; j < subTitlesArray.count; j ++) {
                FMPersonModel* personModel = [[FMPersonModel alloc] init];
                personModel.title = [subTitlesArray lz_safeObjectAtIndex:j];
                personModel.imageText = [subImagesArray lz_safeObjectAtIndex:j];
                personModel.subtitle = [subtitleArray lz_safeObjectAtIndex:j];
                personModel.showClass = [classArray lz_safeObjectAtIndex:j];
                [subArray addObject:personModel];
            }
            [_itemModelArray addObject:subArray];
        }
    }
    return _itemModelArray;
}

- (SCImagePicker *)imagePicker{
    MV(weakSelf)
    if (!_imagePicker) {
        _imagePicker = [[SCImagePicker alloc] init];
        _imagePicker.isEditor = YES;
        [_imagePicker sc_pickWithTarget:self completionHandler:^(UIImage *image, NSString *url) {
            TTLog(@"image -- %@",image);
            [weakSelf uploadHeaderImageWithImageUrl:url];
        }];
    }
    return _imagePicker;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
