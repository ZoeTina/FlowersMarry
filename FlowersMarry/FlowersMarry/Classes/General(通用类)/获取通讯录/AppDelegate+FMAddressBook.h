//
//  AppDelegate+FMAddressBook.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/10.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "AppDelegate.h"
#import "FMTongxunluModel.h"

@interface AppDelegate (FMAddressBook)
/** 获取手机通讯录 */
- (void)requestAuthorizationForAddressBook;
@end
