//
//  FMModifyUserInfoViewController.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/9.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "MVBaseViewController.h"


// 这里要定义一个block的别名(申明) 类型 ----> void (^) (NSString *text)
typedef void(^ChangeInfoBlock) (NSString *text);

@interface FMModifyUserInfoViewController : MVBaseViewController

@property (nonatomic, copy) NSString *tabBarTitle;
@property (nonatomic, copy) NSString *nickname;
//定义一个block
@property (nonatomic, copy) ChangeInfoBlock block;

@end
