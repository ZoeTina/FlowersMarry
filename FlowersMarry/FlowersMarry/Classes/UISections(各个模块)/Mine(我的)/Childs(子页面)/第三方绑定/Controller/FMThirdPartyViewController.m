//
//  FMThirdPartyViewController.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/10.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMThirdPartyViewController.h"
#import "FMThirdPartyTableViewCell.h"
#import "FMThirdModel.h"

static NSString * const reuseIdentifier = @"FMThirdPartyTableViewCell";

@interface FMThirdPartyViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *itemModelArray;
@end

@implementation FMThirdPartyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"第三方绑定";

    [self initView];
}

- (void) initView{
    [Utils lz_setExtraCellLineHidden:self.tableView];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(kLinerViewHeight));
        make.bottom.left.right.equalTo(self.view);
    }];
}


#pragma mark - Table view data source
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FMThirdPartyTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    FMThirdModel* model = self.itemModelArray[indexPath.section][indexPath.row];

    cell.titleLabel.text = model.title;
    if (indexPath.row==0) {
        cell.nicknameLabel.text = (kUserInfo.qqName.length>0)?kUserInfo.qqName:@"未绑定";
        cell.bindLabel.text = (kUserInfo.qqName.length>0)?@"解绑":@"去绑定";
    }else if(indexPath.row==1){
        cell.nicknameLabel.text = (kUserInfo.wechatName.length>0)?kUserInfo.wechatName:@"未绑定";
        cell.bindLabel.text = (kUserInfo.wechatName.length>0)?@"解绑":@"去绑定";
    }
    cell.nicknameLabel.text = model.nickname;
    cell.imagesView.image = kGetImage(model.imageText);

    if ([cell.bindLabel.text isEqualToString:@"去绑定"]) {
        cell.bindLabel.textColor = [UIColor lz_colorWithHexString:@"#409EFF"];
    }
    return cell;
}

// 多少个分组 section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

/// 返回多少
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    NSArray *subArray = [self.itemModelArray lz_safeObjectAtIndex:section];
    return 2;//subArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return IPHONE6_W(73);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.showsVerticalScrollIndicator = false;
        [_tableView registerClass:[FMThirdPartyTableViewCell class] forCellReuseIdentifier:reuseIdentifier];
        [_tableView setSeparatorInset:UIEdgeInsetsMake(0,15,0,15)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = kWhiteColor;
    }
    return _tableView;
}

- (NSMutableArray *)itemModelArray{
    if (!_itemModelArray) {
        _itemModelArray = [[NSMutableArray alloc] init];
        NSArray *titlesArray = @[@[@"QQ",@"微信",@"微博"]];
        NSArray *nicknameArray = @[@[@"九尾狐狸",@"108****865",@""]];
        NSArray *imagesArray = @[@[@"mine_btn_qq_1",@"mine_btn_weixin",@"mine_btn_weibo"]];
        NSArray *typeArray = @[@[@"0",@"0",@"1"]];
        
        for (int i=0; i<titlesArray.count; i++) {
            NSArray *subTitlesArray = [titlesArray lz_safeObjectAtIndex:i];
            NSArray *subNicknameArray = [nicknameArray lz_safeObjectAtIndex:i];
            NSArray *subImagesArray = [imagesArray lz_safeObjectAtIndex:i];
            NSArray *subTypeArray = [typeArray lz_safeObjectAtIndex:i];
            NSMutableArray *subArray = [NSMutableArray array];

            for (int j = 0; j < subTitlesArray.count; j ++) {
                FMThirdModel* personModel = [[FMThirdModel alloc] init];
                personModel.title = [subTitlesArray lz_safeObjectAtIndex:j];
                personModel.imageText = [subImagesArray lz_safeObjectAtIndex:j];
                personModel.nickname = [subNicknameArray lz_safeObjectAtIndex:j];
                personModel.type = [subTypeArray lz_safeObjectAtIndex:j];
                [subArray addObject:personModel];
            }
            [_itemModelArray addObject:subArray];
        }
    }
    return _itemModelArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
