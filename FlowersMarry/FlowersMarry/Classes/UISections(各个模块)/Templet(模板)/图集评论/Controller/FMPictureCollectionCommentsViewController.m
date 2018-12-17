//
//  FMPictureCollectionCommentsViewController.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/18.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMPictureCollectionCommentsViewController.h"
#import "FMPictureCollectionCommentsTableViewCell.h"
#import "FMPictureCollectionReplyTableViewCell.h"
#import "FMGeneralModel.h"
/** 键盘 */
#import "ChatKeyBoardMacroDefine.h"
#import "ChatKeyBoard.h"

#import "FMCommentsDynamicModel.h"
static NSString * const reuseIdentifier = @"FMPictureCollectionCommentsTableViewCell";
static NSString * const reuseIdentifierReply = @"FMPictureCollectionReplyTableViewCell";

@interface FMPictureCollectionCommentsViewController ()<ChatKeyBoardDelegate,UITableViewDelegate,UITableViewDataSource>
/// 完成按钮
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<CommentsDynamicListModel *> *listArray;

@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UILabel *countLabel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UIView *linerView;
@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) UILabel *tips;
@property (nonatomic, strong) SCNoDataView *noDataView;

@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
/** 聊天键盘 */
@property (nonatomic, strong) ChatKeyBoard *chatKeyBoard;
@property (nonatomic, copy) NSString *feed_id;
@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, assign) NSInteger pageSize;
@end

@implementation FMPictureCollectionCommentsViewController
- (id) initDynamicModel:(NSString *)feed_id{
    if ( self = [super init] ){
        self.feed_id = feed_id;
        self.pageIndex = 1;
        self.pageSize = 20;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kWhiteColor;
    [self setCornerRadius:self.view];
    [self initView];
    [self initViewConstraints];
    self.title = @"评论";
    [self.activityIndicator startAnimating];
    int64_t delayInSeconds = 2.0;      // 延迟的时间
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [self getListDataRequest];
    });
    
    /// 下拉刷新
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //将页码重新置为1
        self.pageIndex = 1;
        [self getListDataRequest];
    }];
    /// 上拉加载
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        self.pageIndex++;// 页码+1
        [self getListDataRequest];
        [self.tableView.mj_footer endRefreshing];
    }];
}


- (void) initView{
    [self.view addSubview:self.headerView];
    [self.headerView addSubview:self.countLabel];
    [self.headerView addSubview:self.titleLabel];
    [self.headerView addSubview:self.lineView];
    [self.headerView addSubview:self.linerView];
    [self.headerView addSubview:self.closeButton];
    
    /// 底部
    [Utils lz_setExtraCellLineHidden:self.tableView];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.chatKeyBoard];
    [self addGesture];
}

- (void) getListDataRequest{
    NSString *URLString = @"feed/commentlist";
    NSDictionary *parameter = @{@"feed_id":self.feed_id,@"p":@(self.pageIndex),@"size":@(self.pageSize)};
    [SCHttpTools getWithURLString:URLString parameter:parameter success:^(id responseObject) {
        NSDictionary *result = responseObject;
        if ([result isKindOfClass:[NSDictionary class]]) {
            FMCommentsDynamicModel *model = [FMCommentsDynamicModel mj_objectWithKeyValues:result];
            if (model.errcode == 0) {
                if (self.pageIndex==1) {
                    [self.listArray removeAllObjects];
                }
                [self.listArray addObjectsFromArray:model.data.info];
                [self analysisData];
                self.countLabel.text = [NSString stringWithFormat:@"%@条评论",model.data.totalCount];
            }else {
                Toast([result lz_objectForKey:@"message"]);
            }
        }
        [self.tableView reloadData];
        [self.activityIndicator stopAnimating];
        [self.tableView.mj_header endRefreshing];
        self.tips.hidden = YES;
    } failure:^(NSError *error) {
        TTLog(@" -- error -- %@",error);
        [self.activityIndicator stopAnimating];
        [self.tableView.mj_header endRefreshing];
        self.tips.hidden = YES;
    }];
}

- (void)analysisData {
    if (self.listArray.count == 0) {
        self.noDataView.hidden = NO;
    }else {
        self.noDataView.hidden = YES;
    }
}

#pragma mark -- 发送文本
- (void)chatKeyBoardSendText:(NSString *)text{
    if (text.length>0 && text.length<51) {
        [self.chatKeyBoard keyboardDown];
        [self saveCommentRequest:text];
    }
}

/// 提交评论
- (void) saveCommentRequest:(NSString *) contentText{
    NSString *URLString = @"feed/commentsave";
    NSDictionary *parameter = @{@"feed_id":self.feed_id,@"content":contentText};
    [SCHttpTools getWithURLString:URLString parameter:parameter success:^(id responseObject) {
        NSDictionary *result = responseObject;
        if ([result isKindOfClass:[NSDictionary class]]) {
            FMGeneralModel *genralModel = [FMGeneralModel mj_objectWithKeyValues:result];
            if(genralModel.errcode==0){
//                Toast(@"");z
                [kKeyWindow lz_make:@"评论成功,审核通过后方能看见"];
            }else{
                Toast([result lz_objectForKey:@"message"]);
            }
        }
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        TTLog(@" -- error -- %@",error);
    }];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self.chatKeyBoard keyboardDown];
}

- (void) setCornerRadius:(UIView *)needView{
    
    // 这里设置需要绘制的圆角
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.view.bounds
                                                   byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(4,4)];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.view.bounds;
    maskLayer.path = maskPath.CGPath;
    needView.layer.mask = maskLayer;
}

#pragma mark - Table view data source
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FMPictureCollectionReplyTableViewCell * tools = [tableView dequeueReusableCellWithIdentifier:reuseIdentifierReply forIndexPath:indexPath];

    tools.model = self.listArray[indexPath.row];
    return tools;
}

// 多少个分组 section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.listArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (void) initViewConstraints{
    
    CGFloat margin = 15;
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(IPHONE6_W(32));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.mas_equalTo(self.headerView);
    }];
    
    [self.countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(margin);
        make.centerY.mas_equalTo(self.headerView);
    }];
    
    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-5);
        make.centerY.mas_equalTo(self.headerView);
        make.height.width.mas_equalTo(self.headerView.mas_height);
    }];
    
    [self.linerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(@(kLinerViewHeight));
        make.width.bottom.mas_equalTo(self.headerView);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.titleLabel);
        make.height.mas_equalTo(3);
        make.width.mas_equalTo(margin);
        make.bottom.mas_equalTo(self.headerView);
    }];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.headerView.mas_bottom);
        make.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.chatKeyBoard.mas_top);
    }];
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.showsVerticalScrollIndicator = false;
        [_tableView registerClass:[FMPictureCollectionCommentsTableViewCell class] forCellReuseIdentifier:reuseIdentifier];
        [_tableView registerClass:[FMPictureCollectionReplyTableViewCell class] forCellReuseIdentifier:reuseIdentifierReply];
        [_tableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = kTextColor244;
    }
    return _tableView;
}

- (UIView *)headerView{
    if (!_headerView) {
        _headerView = [UIView lz_viewWithColor:kClearColor];
    }
    return _headerView;
}

- (UILabel *)countLabel{
    if (!_countLabel) {
        _countLabel = [UILabel lz_labelWithTitle:@"0条评论" color:kTextColor153 font:kFontSizeMedium12];
    }
    return _countLabel;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel lz_labelWithTitle:@"热门评论" color:kTextColor34 font:kFontSizeMedium12];
    }
    return _titleLabel;
}

- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [UIView lz_viewWithColor:kColorWithRGB(255, 65, 99)];
    }
    return _lineView;
}

- (UIView *)linerView{
    if (!_linerView) {
        _linerView = [UIView lz_viewWithColor:kLinerViewColor];
    }
    return _linerView;
}

- (UIButton *)closeButton{
    if (!_closeButton) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _closeButton.tag = 100;
        [_closeButton setImage:kGetImage(@"live_btn_close") forState:UIControlStateNormal];
        [_closeButton setImage:kGetImage(@"live_btn_close") forState:UIControlStateHighlighted];
        MV(weakSelf)
        [_closeButton lz_handleControlEvent:UIControlEventTouchUpInside withBlock:^{
            [weakSelf dismissViewControllerAnimated:YES completion:nil];
        }];
    }
    return _closeButton;
}

-(ChatKeyBoard *)chatKeyBoard{
    if (!_chatKeyBoard) {
        _chatKeyBoard = [ChatKeyBoard keyBoardWithStyleCommentTrill:kScreenHeight/3];
        _chatKeyBoard.delegate = self;
        _chatKeyBoard.allowSwitchBar = NO;
        _chatKeyBoard.allowVoice = NO;
        _chatKeyBoard.allowFace = NO;
        _chatKeyBoard.allowMore = NO;
        _chatKeyBoard.keyBoardStyle = KeyBoardStyleChat;
        _chatKeyBoard.placeHolder = @"请输入消息";
        _chatKeyBoard.borderWidth = 0.0;
        [_chatKeyBoard setBorderColor:kWhiteColor];
    }
    return _chatKeyBoard;
}


- (SCNoDataView *)noDataView {
    if (!_noDataView) {
        _noDataView = [[SCNoDataView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)
                                                imageName:@""
                                            tipsLabelText:@"暂无评论，还不快抢沙发"];
        _noDataView.userInteractionEnabled = YES;
        [self.view insertSubview:_noDataView aboveSubview:self.tableView];
        [self.noDataView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.centerX.equalTo(self.view);
            make.height.equalTo(@20);
        }];
    }
    return _noDataView;
}

- (UIActivityIndicatorView *)activityIndicator{
    if (!_activityIndicator) {
        _activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleGray)];
        //设置小菊花的frame
//        _activityIndicator.frame= CGRectMake(100, 100, 100, 100);
        //设置小菊花颜色
//        _activityIndicator.color = [UIColor redColor];
        //设置背景颜色
        _activityIndicator.backgroundColor = kClearColor;
        //刚进入这个界面会显示控件，并且停止旋转也会显示，只是没有在转动而已，没有设置或者设置为YES的时候，刚进入页面不会显示
//        _activityIndicator.hidesWhenStopped = NO;
        [self.view addSubview:_activityIndicator];
        [_activityIndicator mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.centerY.equalTo(self.view.mas_centerY).offset(-11);
        }];
        [self.view addSubview:self.tips];
        [self.tips mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.centerY.equalTo(self.view.mas_centerY).offset(11);
        }];
    }
    return _activityIndicator;
}

#pragma mark 给当前view添加识别手势
#pragma mark -- 当前tableView中带有输入框点击背景关闭键盘
-(void)addGesture {
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture)];
    [self.tableView addGestureRecognizer:tapGesture];
    tapGesture.cancelsTouchesInView = NO;
}

-(void)tapGesture {
    [self.chatKeyBoard keyboardDown];
}

- (UILabel *)tips{
    if (!_tips) {
        _tips = [UILabel lz_labelWithTitle:@"加载中..." color:kTextColor102 font:kFontSizeMedium14];
    }
    return _tips;
}

- (NSMutableArray *)listArray{
    if (!_listArray) {
        _listArray = [[NSMutableArray alloc] init];
    }
    return _listArray;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
