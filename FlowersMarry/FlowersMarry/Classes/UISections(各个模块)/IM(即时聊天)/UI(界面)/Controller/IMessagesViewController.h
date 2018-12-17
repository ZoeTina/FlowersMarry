//
//  IMessagesViewController.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/9/11.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "MVBaseViewController.h"
#import "ChatKeyBoard.h"
#import "IMessagesMorePanelModel.h"
#import "IMessagesToolsBarModel.h"
#import "IMessagesFaceModel.h"
@interface IMessagesViewController : MVBaseViewController<ChatKeyBoardDelegate,ChatKeyBoardDataSource,UITableViewDelegate,UITableViewDataSource>
/** 聊天键盘 */
@property (nonatomic, strong) ChatKeyBoard *chatKeyBoard;
@property (nonatomic, strong) UITableView *messageTableView;
@property (nonatomic, strong) NSMutableArray *messageArray;

@end
