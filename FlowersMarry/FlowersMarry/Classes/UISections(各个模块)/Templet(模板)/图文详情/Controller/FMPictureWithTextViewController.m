//
//  FMPictureWithTextViewController.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/6/29.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMPictureWithTextViewController.h"
#import "FMPictureWithTextCellPicture.h"
#import "FMPictureWithTextCellText.h"
#import "FMPictureWithTextCellHeader.h"
#import "FMPictureWithTextCellRecommended.h"
#import "SCTableViewSectionHeaderView.h"
#import "FMConsumerProtectionViewController.h"
#import "FMPictureCollectionCommentsTableViewCell.h"
#import "FMShowPhotoCollectionFooterView.h"
#import "FMPictureCollectionCommentsViewController.h"
#import "FMPictureCollectionReplyTableViewCell.h"
#import "FMPictureWithTextViewModel.h"
#import "FMTelephoneBookingViewController.h"
#import "FMTelephoneBookingView.h"

#import "FMActivityWebViewCell.h"

#import "FMCommentsDynamicModel.h"
#import "ChatKeyBoard.h"

static NSString * const reuseIdentifierSectionHeaderView = @"SCTableViewSectionHeaderView";
static NSString * const reuseIdentifierInSection = @"FMViewForHeaderInSectionTableViewCell";
static NSString * const reuseIdentifierHeader = @"FMPictureWithTextCellHeader";
static NSString * const reuseIdentifierPicture = @"FMPictureWithTextCellPicture";
static NSString * const reuseIdentifierText = @"FMPictureWithTextCellText";
static NSString * const reuseIdentifierRecommended = @"FMPictureWithTextCellRecommended";
static NSString * const reuseIdentifierComments = @"FMPictureCollectionCommentsTableViewCell";
static NSString * const reuseIdentifierReply = @"FMPictureCollectionReplyTableViewCell";
static NSString * const reuseIdentifierTemplateWebView = @"FMActivityWebViewCell";



@interface FMPictureWithTextViewController ()<ChatKeyBoardDelegate,UITableViewDelegate,UITableViewDataSource,FMTelephoneBookingViewDelegate,HuodongWebViewCellDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *itemModelArray;
@property (nonatomic, strong) DynamicModel *homeData;
@property (nonatomic, strong) DynamicModel *dynamicModel;
@property (nonatomic, strong) NSMutableArray<DynamicModel *> *dataArray;

/// 底部工具栏
@property (nonatomic, strong) FMShowPhotoCollectionFooterView *footerView;
@property (nonatomic, strong) NSMutableDictionary *heightAtIndexPath;
@property (nonatomic, copy) NSString *totalCount;

/** 聊天键盘 */
@property (nonatomic, strong) ChatKeyBoard *chatKeyBoard;
@property (strong,nonatomic) FMTelephoneBookingView  *showView;
@property (nonatomic, strong) UIButton *maskView;

@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, assign) NSInteger pageSize;
@end

@implementation FMPictureWithTextViewController
- (id)initHomeDataModel:(DynamicModel *) homeData{
    if ( self = [super init] ){
        self.homeData = homeData;
        self.totalCount = @"0";
        self.pageSize = 20;
        self.pageIndex = 1;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initView];
    self.view.backgroundColor = kTextColor244;
    [self.view showLoadingViewWithText:@"加载中..."];
    /// 基本数据
    [self getDataRequest:self.homeData.kid];
    /// 热门评论
    [self loadHotCommentDataRequest];
    
    [self.view addSubview:self.chatKeyBoard];
    [self addGesture];
    
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.pageIndex++;// 页码+1
        [self.tableView.mj_footer endRefreshing];
    }];
}

#pragma mark -- 发送文本
- (void)chatKeyBoardSendText:(NSString *)text{
    if (text.length>0) {
        [self.chatKeyBoard keyboardDownForComment];
        [self saveCommentRequest:text];
    }
}

- (void) initView{
    [Utils lz_setExtraCellLineHidden:self.tableView];
    [self.view addSubview:self.footerView];
    
    [self.view addSubview:self.tableView];
    /// footer 内容区域
    CGFloat height = 49 + kSafeAreaBottomHeight;
    [self.footerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.view);
        make.height.equalTo(@(height));
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@(kLinerViewHeight));
        make.left.right.equalTo(self.view);
        make.bottom.mas_equalTo(self.footerView.mas_top);
    }];
}

/// 提交评论
- (void) saveCommentRequest:(NSString *) contentText{
    NSString *URLString = @"feed/commentsave";
    NSDictionary *parameter = @{@"feed_id":self.dynamicModel.kid,@"content":contentText};
    [SCHttpTools getWithURLString:URLString parameter:parameter success:^(id responseObject) {
        NSDictionary *result = responseObject;
        if ([result isKindOfClass:[NSDictionary class]]) {
            FMGeneralModel *genralModel = [FMGeneralModel mj_objectWithKeyValues:result];
            if(genralModel.errcode==0){
                Toast(@"评论成功,审核通过后方能看见");
            }else{
                Toast([result lz_objectForKey:@"message"]);
            }
        }
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        TTLog(@" -- error -- %@",error);
    }];
}

/// 获取图文数据
- (void) getDataRequest:(NSString *) idx{
    NSString *URLString = @"feed/info";
    NSDictionary *parameter = @{@"id":idx,@"ref":@"1"};
    [SCHttpTools getWithURLString:URLString parameter:parameter success:^(id responseObject) {
        NSDictionary *result = responseObject;
        if ([result isKindOfClass:[NSDictionary class]]) {
            FMGeneralModel *genralModel = [FMGeneralModel mj_objectWithKeyValues:result];
            if (genralModel.errcode == 0) {
                DynamicModel *dynamicModel = [DynamicModel mj_objectWithKeyValues:result[@"data"]];
                self.dynamicModel = dynamicModel;
                
                TTLog(@"self.dynamicModel.list --- %ld",self.dynamicModel.list.count);
                self.footerView.likeButton.selected = self.dynamicModel.is_collect==0?YES:NO;
                [self.footerView.commentsButton setTitle:self.dynamicModel.comment_num forState:UIControlStateNormal];
                [self.footerView.likeButton setTitle:self.dynamicModel.collect_num forState:UIControlStateNormal];
            }else {
                Toast([result lz_objectForKey:@"message"]);
            }
        }
        [self.tableView reloadData];
        [self.view dismissLoadingView];
        self.tableView.hidden = NO;
    } failure:^(NSError *error) {
        TTLog(@" -- error -- %@",error);
        [self.view dismissLoadingView];
    }];
}

/// 获取热门评论的数据
- (void) loadHotCommentDataRequest{
    NSString *URLString = @"feed/commentlist";
    NSDictionary *parameter = @{@"feed_id":self.homeData.kid,@"p":@(self.pageIndex),@"size":@(self.pageSize)};
    [SCHttpTools getWithURLString:URLString parameter:parameter success:^(id responseObject) {
        NSDictionary *result = responseObject;
        if ([result isKindOfClass:[NSDictionary class]]) {
            FMCommentsDynamicModel *model = [FMCommentsDynamicModel mj_objectWithKeyValues:result];
            if (model.errcode == 0) {
                if (self.pageIndex==1) {
                    self.totalCount = model.data.totalCount;
                    [self.itemModelArray removeAllObjects];
                }
                [self.itemModelArray addObjectsFromArray:model.data.info];
            }else {
                Toast([result lz_objectForKey:@"message"]);
            }
        }
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSError *error) {
        TTLog(@" -- error -- %@",error);
        [self.tableView.mj_footer endRefreshing];
    }];
}

/// 收藏当前动态
- (void) didClickLike{
    [MBProgressHUD showMessage:@"" toView:self.view];
    NSString *URLString = @"feed/collect";
    NSDictionary *parameter = @{@"id":self.dynamicModel.kid};
    [SCHttpTools getWithURLString:URLString parameter:parameter success:^(id responseObject) {
        NSDictionary *result = responseObject;
        if ([result isKindOfClass:[NSDictionary class]]) {
            if ([[result lz_objectForKey:@"errcode"] integerValue] == 0) {
                /// 收藏当前动态自动关注当前商家
                self.dynamicModel.is_follow = [[result lz_objectForKey:@"is_follow"] integerValue] == 0 ? NO : YES;
                [self.tableView reloadData];
                NSInteger collect_num = [[self.footerView.likeButton currentTitle] integerValue];
                self.footerView.likeButton.selected = !self.footerView.likeButton.selected;
                if (self.footerView.likeButton.selected) {
                    NSString *latestStr = [NSString stringWithFormat:@"%d",(int)collect_num+1];
                    [self.footerView.likeButton setTitle:latestStr forState:UIControlStateNormal];
                }else{
                    NSString *latestStr = [NSString stringWithFormat:@"%d",(int)collect_num-1];
                    [self.footerView.likeButton setTitle:latestStr forState:UIControlStateNormal];
                }
            }
            Toast([result lz_objectForKey:@"message"]);
        }
        [MBProgressHUD hideHUDForView:self.view];
    } failure:^(NSError *error) {
        TTLog(@" -- error -- %@",error);
        [MBProgressHUD hideHUDForView:self.view];
    }];
}

- (void) handleButtonEvents:(NSInteger)idx{
    /// 102:评论按钮 103:点赞按钮 104:客服按钮 105:预约按钮
    switch (idx) {
        case 102:
        {
            [self.chatKeyBoard keyboardUpforComment];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:2];
            [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
        }
            break;
        case 103:
            [self didClickLike];
            break;
        case 104:
            [self lz_make:@"客服按钮"];
            break;
        case 105:
            [self.showView showInView:kKeyWindow];
            break;
        default:
            break;
    }
}

//// 关注当前商家
- (void) didGuanzhuButtonClick:(UIButton *)sender{
    [MBProgressHUD showMessage:@"" toView:self.view];
    NSString *URLString = @"feed/fllow";
    NSDictionary *parameter = @{@"cp_id":self.dynamicModel.cp_id};
    [SCHttpTools getWithURLString:URLString parameter:parameter success:^(id responseObject) {
        NSDictionary *result = responseObject;
        if ([result isKindOfClass:[NSDictionary class]]) {
            if ([[result lz_objectForKey:@"errcode"] integerValue] == 0) {
                sender.selected = !sender.selected;
                NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
                [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
            }
            Toast([result lz_objectForKey:@"message"]);
        }
        [MBProgressHUD hideHUDForView:self.view];
    } failure:^(NSError *error) {
        TTLog(@" -- error -- %@",error);
        [MBProgressHUD hideHUDForView:self.view];
    }];
}

#pragma mark - Table view data source
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        FMPictureWithTextCellHeader* tools = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierHeader forIndexPath:indexPath];
        tools.dynamicModel = self.dynamicModel;
        MV(weakSelf)
        [tools.guanzhuButton lz_handleControlEvent:UIControlEventTouchUpInside withBlock:^{
            [weakSelf didGuanzhuButtonClick:tools.guanzhuButton];
        }];
        return tools;
    }else if (indexPath.section == 1) {
        FMActivityWebViewCell *tools = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierTemplateWebView forIndexPath:indexPath];
        tools.delegate = self;
        tools.indexPath = indexPath;
        [tools refreshWebView:self.dynamicModel.content indexPath:indexPath];
        return tools;
    }else if(indexPath.section==2){
        FMPictureWithTextCellRecommended *tools = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierRecommended forIndexPath:indexPath];
        tools.dataArray = self.dynamicModel.list;
        return tools;
    }else{
        FMPictureCollectionReplyTableViewCell * tools = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierReply forIndexPath:indexPath];
        tools.model = self.itemModelArray[indexPath.row];
        return tools;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==2) {
        return 215;
    }else if (indexPath.section==1){
        if (self.heightAtIndexPath[indexPath]) {
            TTLog(@"当前高度 ----- %f",[self.heightAtIndexPath[indexPath] floatValue]);
            return [self.heightAtIndexPath[indexPath] floatValue];
        }
    }
    return UITableViewAutomaticDimension;
}

#pragma mark ====== FMTravelTableViewCellDelegate ======
- (void)updateTableViewCellHeight:(FMActivityWebViewCell *)cell andheight:(CGFloat)height andIndexPath:(NSIndexPath *)indexPath {
    if (![self.heightAtIndexPath[indexPath] isEqualToNumber:@(height)]) {
        self.heightAtIndexPath[indexPath] = @(height);
        [self.tableView reloadData];
    }
}

// 多少个分组 section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 4;
}

/// 返回多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
        return 1;
    }else if (section==1) {
        return 1;
    }else if(section==2){
        return 1;
    }else{
        return self.itemModelArray.count;
    }
}

#pragma mark -- 设置Header高度
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0||section==1) return 0;
    return 44.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==1||section==2) return 10.f;
    return 0.1f;
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
        titleTextStr = @"相关推荐";
        headerView.arrowImageView.hidden = YES;
    }else if (section==3) {
        titleTextStr = @"热门评论";
        subtitleTestStr = [NSString stringWithFormat:@"共有%@条",self.totalCount];
        headerView.arrowImageView.hidden = NO;
    }
    headerView.titleLabel.text = titleTextStr;
    headerView.subtitleLabel.text = subtitleTestStr;
    
    return headerView;
}

/// 点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark 给当前view添加识别手势
#pragma mark -- 当前tableView中带有输入框点击背景关闭键盘
-(void)addGesture {
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture)];
    [self.tableView addGestureRecognizer:tapGesture];
    tapGesture.cancelsTouchesInView = NO;
}

-(void)tapGesture {
//    [kKeyWindow endEditing:YES];
    [self.chatKeyBoard keyboardDownForComment];
}

#pragma mark --- setter/getter
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.showsVerticalScrollIndicator = false;
        [_tableView registerClass:[SCTableViewSectionHeaderView class] forHeaderFooterViewReuseIdentifier:reuseIdentifierSectionHeaderView];
        [_tableView registerClass:[FMPictureWithTextCellHeader class] forCellReuseIdentifier:reuseIdentifierHeader];
        [_tableView registerClass:[FMPictureWithTextCellPicture class] forCellReuseIdentifier:reuseIdentifierPicture];
        [_tableView registerClass:[FMPictureWithTextCellText class] forCellReuseIdentifier:reuseIdentifierText];
        [_tableView registerClass:[FMPictureWithTextCellRecommended class] forCellReuseIdentifier:reuseIdentifierRecommended];
        [_tableView registerClass:[FMPictureCollectionCommentsTableViewCell class] forCellReuseIdentifier:reuseIdentifierComments];
        [_tableView registerClass:[FMPictureCollectionReplyTableViewCell class] forCellReuseIdentifier:reuseIdentifierReply];
        [_tableView registerClass:[FMActivityWebViewCell class] forCellReuseIdentifier:reuseIdentifierTemplateWebView];
        _tableView.hidden = YES;
        [_tableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
        //1 禁用系统自带的分割线
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = kWhiteColor;
        _tableView.sectionFooterHeight = 0.1f;
        // 拖动tableView时收起键盘
//        _tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _tableView.estimatedRowHeight = 120;
        _tableView.rowHeight = UITableViewAutomaticDimension;
    }
    return _tableView;
}

- (UIView *)footerView{
    if (!_footerView) {
        _footerView = [[FMShowPhotoCollectionFooterView alloc] init];
        _footerView.backgroundColor = kWhiteColor ;
        [_footerView.commentsButton setImage:kGetImage(@"base_btn_comment") forState:UIControlStateNormal];
        [_footerView.likeButton setImage:kGetImage(@"base_btn_like") forState:UIControlStateNormal];
        [_footerView.likeButton setImage:kGetImage(@"base_btn_like_selected") forState:UIControlStateSelected];
        [_footerView.kefuButton setImage:kGetImage(@"base_btn_service") forState:UIControlStateNormal];
        [_footerView.commentsButton setTitleColor:kTextColor102 forState:UIControlStateNormal];
        [_footerView.likeButton setTitleColor:kTextColor102 forState:UIControlStateNormal];
        _footerView.linerView.hidden = NO;
        MV(weakSelf)
        self.footerView.footerBlock = ^(NSInteger idx) {
            [weakSelf handleButtonEvents:idx];
        };
    }
    return _footerView;
}

- (FMTelephoneBookingView *)showView{
    if (!_showView) {
        _showView = [[FMTelephoneBookingView alloc] initDataString:self.dynamicModel.cp_id ap_type:@"11" isPreferential:NO];
//        _showView.delegate = self;
    }
    return _showView;
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

- (UIButton *)maskView{
    if (!_maskView) {
        _maskView = [[UIButton alloc] init];
        _maskView.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        _maskView.hidden = YES;
        _maskView.backgroundColor = [kColorWithRGB(211, 0, 0) colorWithAlphaComponent:0.9];
        [_maskView lz_handleControlEvent:UIControlEventTouchUpInside withBlock:^{
            [self.chatKeyBoard keyboardDownForComment];
            self.maskView.hidden = YES;
        }];
    }
    return _maskView;
}

- (ChatKeyBoard *)chatKeyBoard{
    if (!_chatKeyBoard) {
        _chatKeyBoard = [ChatKeyBoard keyBoard];
        _chatKeyBoard.delegate = self;
        _chatKeyBoard.allowSwitchBar = NO;
        _chatKeyBoard.allowVoice = NO;
        _chatKeyBoard.allowFace = NO;
        _chatKeyBoard.allowMore = NO;
        _chatKeyBoard.keyBoardStyle = KeyBoardStyleComment;
        _chatKeyBoard.placeHolder = @"请输入消息";
    }
    return _chatKeyBoard;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
