//
//  FMEvaluationListViewController.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/20.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMEvaluationListViewController.h"
#import "FMEvaluationTemplateTableViewCell.h"
#import "FMEvaluationModel.h"

#import "FMEvaluationTemplateOneTableViewCell.h"
#import "FMEvaluationTemplateTwoTableViewCell.h"
#import "FMEvaluationTemplateThreeTableViewCell.h"
#import "FMEvaluationTemplateFourTableViewCell.h"

static NSString * const reuseIdentifier = @"FMEvaluationTemplateTableViewCell";
static NSString * const reuseIdentifierOne = @"FMEvaluationTemplateOneTableViewCell";
static NSString * const reuseIdentifierTwo = @"FMEvaluationTemplateTwoTableViewCell";
static NSString * const reuseIdentifierThree = @"FMEvaluationTemplateThreeTableViewCell";
static NSString * const reuseIdentifierFour = @"FMEvaluationTemplateFourTableViewCell";

@interface FMEvaluationListViewController ()<UITableViewDelegate,UITableViewDataSource,FMEvaluationTemplateTableViewCellDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *itemModelArray;
@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, assign) NSInteger pageSize;
@property (nonatomic, strong) BusinessModel *businessModel;

@end

@implementation FMEvaluationListViewController
- (id)initBusinessModel:(BusinessModel *)businessModel{
    if ( self = [super init] ){
        self.businessModel = businessModel;
        self.pageSize = 20;
        self.pageIndex = 1;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self initView];
    self.pageIndex = 1;
    self.title = @"网友点评";
    [self.view showLoadingViewWithText:@"加载中..."];
    [self loadEvaluationModel];
    /// 下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //将页码重新置为1
        self.pageIndex = 1;
        [self loadEvaluationModel];
    }];
    /// 上拉加载
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.pageIndex++;// 页码+1
        [self loadEvaluationModel];
        [self.tableView.mj_footer endRefreshing];
    }];
}

- (void) initView{
    [Utils lz_setExtraCellLineHidden:self.tableView];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(kLinerViewHeight));
        make.left.bottom.right.equalTo(self.view);
    }];
}

/// 获取点评数据
- (void) loadEvaluationModel{
    NSMutableDictionary *parameter = [[NSMutableDictionary alloc] init];
    [parameter setObject:self.businessModel.cp_id forKey:@"cp_id"];
    [parameter setObject:@(self.pageSize) forKey:@"size"];
    [parameter setObject:@(self.pageIndex) forKey:@"p"];
    [SCHttpTools getWithURLString:@"comment/getlist" parameter:parameter success:^(id responseObject) {
        NSDictionary *result = responseObject;
        if (result) {
            FMEvaluationModel *model = [FMEvaluationModel mj_objectWithKeyValues:result];
            if (self.pageIndex==1) {
                [self.itemModelArray removeAllObjects];
            }
            [self.itemModelArray addObjectsFromArray:model.data.list];
            [self.tableView.mj_header endRefreshing];
        }
        [self.tableView reloadData];
        [self.view dismissLoadingView];
        self.tableView.hidden = NO;
    } failure:^(NSError *error) {
        TTLog(@"---- %@",error);
        [self.tableView.mj_header endRefreshing];
        [self.view dismissLoadingView];
    }];
}

#pragma mark - Table view data source
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    BusinessComment *model = self.itemModelArray[indexPath.row];
    /*EvaluationModel *mdss = self.itemModelArray[3];
    if (indexPath.row==1) {
        model.ct_re_content = @"已经拿到片子了，乐坏了，很满意，本来就属于裸婚一族，所以资金有限，选择婚纱套系是比较实惠一点的，说实话有点担心，怕他们服务上不那么尽心。但后期的接触来看，完全多虑了，他们家的服务和质量挺好的，还有礼服也挺多的，妆容也很自然，我挺喜欢的。 助理也很细心，拍照的过程中一直在提醒我要小心脚下，小心楼梯什么的，总体来说他们家挺好的，我很喜欢。";
    }else if (indexPath.row==3) {
        EvaluationPhotoModel *md = [[EvaluationPhotoModel alloc] init];
        md = mdss.photo[0];

        [model.photo addObject:md];
        [model.photo addObject:md];
        [model.photo addObject:md];
        [model.photo addObject:md];
        [model.photo addObject:md];
        [model.photo addObject:md];
        model.ct_re_content = @"2222222222";
    }*/
    /// 0:评论 1:评论+回复 2:评论+图片 3:评论+图片+回复
    if (model.ct_re_content.length>0 && model.photo.count==0) {/// 评论+回复
        FMEvaluationTemplateFourTableViewCell* tools = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierFour forIndexPath:indexPath];
        tools.evaluationModel = self.itemModelArray[indexPath.row];
        return tools;
    }else if (model.photo.count>0 && model.ct_re_content.length==0){/// 评论+图片
        FMEvaluationTemplateThreeTableViewCell* tools = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierThree forIndexPath:indexPath];
        tools.evaluationModel = self.itemModelArray[indexPath.row];
        return tools;
    }else if (model.ct_re_content.length>0&&model.photo.count>0){/// 评论+图片+回复
        FMEvaluationTemplateTwoTableViewCell* tools = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierTwo forIndexPath:indexPath];
        tools.evaluationModel = self.itemModelArray[indexPath.row];
        return tools;
    }else{  /// 纯文字
        FMEvaluationTemplateOneTableViewCell* tools = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierOne forIndexPath:indexPath];
        tools.evaluationModel = self.itemModelArray[indexPath.row];
        return tools;
    }
}

// 多少个分组 section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.itemModelArray.count;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

//点击UICollectionViewCell的代理方法
- (void)didSelectItemAtIndexPath:(NSIndexPath *)indexPath withContent:(NSString *)content {
    [self lz_make:[NSString stringWithFormat:@"第 %ld 张图片",(long)indexPath.row]];
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.showsVerticalScrollIndicator = false;
        [_tableView registerClass:[FMEvaluationTemplateTableViewCell class] forCellReuseIdentifier:reuseIdentifier];
        [_tableView registerClass:[FMEvaluationTemplateOneTableViewCell class] forCellReuseIdentifier:reuseIdentifierOne];
        [_tableView registerClass:[FMEvaluationTemplateTwoTableViewCell class] forCellReuseIdentifier:reuseIdentifierTwo];
        [_tableView registerClass:[FMEvaluationTemplateThreeTableViewCell class] forCellReuseIdentifier:reuseIdentifierThree];
        [_tableView registerClass:[FMEvaluationTemplateFourTableViewCell class] forCellReuseIdentifier:reuseIdentifierFour];
        [_tableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = kTextColor244;
    }
    return _tableView;
}

- (NSMutableArray *)itemModelArray{
    if (!_itemModelArray) {
        _itemModelArray = [[NSMutableArray alloc] init];
    }
    return _itemModelArray;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
