//
//  TTMessageViewController.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/9/21.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "TTMessageViewController.h"
#import "IMessagesTableViewCell.h"

#import "TTMessageTextCell.h"
#import "TTMessageVoiceCell.h"
@interface TTMessageViewController ()
@property (assign, nonatomic) BOOL isLoading;
@end

@implementation TTMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [Utils lz_setExtraCellLineHidden:self.messageTableView];
    [self.view addSubview:self.messageTableView];
    [self.view addSubview:self.chatKeyBoard];
    self.navigationController.interactivePopGestureRecognizer.delaysTouchesBegan = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    self.title = @"消息列表";
    
    [self.messageTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(-(kTabBarHeight));
    }];
    
    self.messageArray = [[IMessagesModel loadMessageArray] mutableCopy];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.messageArray.count > 0) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.messageArray.count-1 inSection:0];
            [self.messageTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
            self.messageTableView.hidden = NO;
        }
    });
    //下拉刷新控件
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self updateHistoryDataInTableview];
    }];
    header.lastUpdatedTimeLabel.hidden = true;
    header.stateLabel.hidden = true;
    self.messageTableView.mj_header = header;
}

#pragma mark - Table view data source
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    [UIView setAnimationsEnabled:NO];
//    IMessagesTableViewCell *cell=[IMessagesTableViewCell cellWithTableView:self.messageTableView messageModel:self.messageArray[indexPath.row]];
//    cell.backgroundColor = kClearColor;
//    [cell setDoubleClickBlock:^(IMessagesModel *model) {
//        TTLog(@"%@-----",model.messageText);
//    }];
//
//    [cell setSingleblock:^(IMessagesModel *model) {
//        TTLog(@"%@-----",model.imageURL);
//        if (model.messageType==iMessageTypeVoice) {
//
//        }else if (model.messageType==iMessageTypeImage){
//
//        }
//    }];
    IMessagesModel  *messageModel = self.messageArray[indexPath.row];
    /**
     *  id类型的cell 通过取出来Model的类型，判断要显示哪一种类型的cell
     */
    id tools = [tableView dequeueReusableCellWithIdentifier:messageModel.cellIndentify forIndexPath:indexPath];
    // 给cell赋值
    [tools setMessageModel:messageModel];
    [UIView setAnimationsEnabled:YES];
    return tools;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    IMessagesModel *message = [self.messageArray objectAtIndex:indexPath.row];
    return message.cellHeight;
}

// 多少个分组 section
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

/// 返回多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.messageArray.count;
}

#pragma mark -- 发送文本
- (void)chatKeyBoardSendText:(NSString *)text{
    if (text.length>0) {
        IMessagesModel *model=[[IMessagesModel alloc] init];
        model.showMessageTime=YES;
        model.avatarURL = @"https://aos-cdn-image.amap.com/pp/avatar/e84/a0/24/24930357.jpg?ver=1529746883&imgoss=1";
        model.messageTime=[Utils lz_getCurrentTime];
        model.messageText=text;
        model.messageSenderType=iMessageOwnerTypeSelf;
        model.messageType=iMessageTypeText;
        [self.messageArray insertObject:model atIndex:self.messageArray.count];
        [self.messageTableView reloadData];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.messageArray.count - 1 inSection:0];
        [self.messageTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.chatKeyBoard keyboardDown];
}

#pragma mark 给当前view添加识别手势
#pragma mark -- 当前tableView中带有输入框点击背景关闭键盘
-(void)addGesture {
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture)];
    [self.messageTableView addGestureRecognizer:tapGesture];
    tapGesture.cancelsTouchesInView = NO;
}

-(void)tapGesture {
    [self.chatKeyBoard keyboardDown];
}

- (NSMutableArray *)messageArray{
    if (!_messageArray) {
        _messageArray = [[NSMutableArray alloc] init];
    }
    return _messageArray;
}

#pragma mark --- setter/getter
-(UITableView *)messageTableView{
    if (!_messageTableView) {
        _messageTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _messageTableView.showsVerticalScrollIndicator = false;
        [_messageTableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
        //1 禁用系统自带的分割线
//        _messageTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _messageTableView.separatorColor = kColorWithRGB(104, 201, 102);
        _messageTableView.contentInset = UIEdgeInsetsZero;
        _messageTableView.scrollIndicatorInsets = _messageTableView.contentInset;
        _messageTableView.hidden = YES;
        _messageTableView.delegate = self;
        _messageTableView.dataSource = self;
        _messageTableView.backgroundColor = kColorWithRGB(244, 244, 244);
        _messageTableView.sectionFooterHeight = 0.1f;
        // 拖动tableView时收起键盘
        _messageTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        _messageTableView.estimatedRowHeight = 120;
        _messageTableView.rowHeight = UITableViewAutomaticDimension;
        
        [_messageTableView registerClass:[TTMessageTextCell class] forCellReuseIdentifier:@"TTMessageTextCell"];
        [_messageTableView registerClass:[TTMessageVoiceCell class] forCellReuseIdentifier:@"TTMessageVoiceCell"];
    }
    return _messageTableView;
}

- (ChatKeyBoard *)chatKeyBoard{
    if (!_chatKeyBoard) {
        _chatKeyBoard = [ChatKeyBoard keyBoardWithNavgationBarTranslucent:NO];
        _chatKeyBoard.chatToolBarBgColor = kColorWithRGB(244, 244, 244);
        _chatKeyBoard.delegate = self;
        _chatKeyBoard.dataSource = self;
        _chatKeyBoard.allowSwitchBar = NO;
        _chatKeyBoard.allowVoice = NO;
        _chatKeyBoard.allowFace = YES;
        _chatKeyBoard.allowMore = YES;
        _chatKeyBoard.placeHolder = @"请输入消息";
        _chatKeyBoard.textViewBorderColor = kWhiteColor;
        _chatKeyBoard.associateTableView = self.messageTableView;
    }
    return _chatKeyBoard;
}


#pragma mark -- ChatKeyBoardDataSource
- (NSArray<MoreItem *> *)chatKeyBoardMorePanelItems {
    return [IMessagesMorePanelModel loadMoreArray];
}

- (NSArray<ChatToolBarItem *> *)chatKeyBoardToolbarItems {
    return [IMessagesToolsBarModel loadToolsArray];
}

- (NSArray<FaceThemeModel *> *)chatKeyBoardFacePanelSubjectItems {
    return [IMessagesFaceModel loadFaceArray];
}


- (void)chatKeyBoard:(ChatKeyBoard *)chatKeyBoard didSelectMorePanelItemIndex:(NSInteger)index{
    switch (index) {
        case 0:
        {
            IMessagesModel *model=[[IMessagesModel alloc] init];
            model.avatarURL = @"https://aos-cdn-image.amap.com/pp/avatar/e84/a0/24/24930357.jpg?ver=1529746883&imgoss=1";
            model.showMessageTime=YES;
            model.messageTime=@"11:35";
            model.messageSenderType = iMessageOwnerTypeSelf;
            model.messageType = iMessageTypeImage;
            model.messageSentStatus = iMessageSentStatusSending;
            model.messageReadStatus = iMessageReadStatusUnRead;
            model.imageSmall = kGetImage(@"WechatIMG3_hd");
            [self.messageArray insertObject:model atIndex:self.messageArray.count];
            [self.messageTableView reloadData];
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.messageArray.count - 1 inSection:0];
            [self.messageTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        }
            break;
        case 1:
            
            break;
        default:
            
            break;
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
    TTLog(@"%@--dealloc",[self class]);
}

- (void)keyboardWillChangeFrame:(NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    // 1,取出键盘动画的时间
    CGFloat duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    // 2,取得键盘将要移动到的位置的frame
    CGRect keyboardFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    // 3,计算kInputView需要平移的距离
    CGFloat moveY = self.view.frame.size.height + kNavBarHeight - keyboardFrame.origin.y;
    
    // 4,执行动画
    //xib中的动画必须要这样写，否则无效
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
    
    if (self.messageArray.count > 0) {
        if (moveY == 0) {
            [self.messageTableView reloadData];
        } else {
            NSIndexPath *path = [NSIndexPath indexPathForRow:self.messageArray.count - 1 inSection:0];
            [self.messageTableView scrollToRowAtIndexPath:path atScrollPosition:UITableViewScrollPositionBottom animated:YES];
            
        }
    }
}

/// 加载历史数据
- (void)updateHistoryDataInTableview {
    if (self.isLoading)
        return;
    
    self.isLoading = true;
    __weak typeof(self) weakSelf = self;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)),
                   dispatch_get_main_queue(), ^{
                       NSInteger oldCount = self.messageArray.count;
                       
                       NSArray* datas = [NSArray new];//[[WeChat sharedManager] messagesBeforeTimeInterval:self.messageArray.firstObject.sendTime
                       //                                         fetchLimit:kFetchLimit];
                       [self.messageArray insertObjects:datas atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, datas.count)]];
                       
                       [self.messageTableView reloadData];
                       
                       NSInteger newCount = weakSelf.messageArray.count;
                       NSIndexPath* indexPath =
                       [NSIndexPath indexPathForRow:newCount - oldCount inSection:0];
                       [weakSelf.messageTableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
                       
                       //刷新结束后通知菊花停止转动
                       [self.messageTableView.mj_header endRefreshing];
                       self.isLoading = false;
                   });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
