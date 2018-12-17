//
//  AppDelegate+FMAddressBook.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/10.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "AppDelegate+FMAddressBook.h"
#import <AddressBook/AddressBook.h>
#import <Contacts/Contacts.h>

@interface AppDelegate ()

@end
@implementation AppDelegate (FMAddressBook)

- (void)requestAuthorizationForAddressBook {
    CNAuthorizationStatus authorizationStatus = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
    if (authorizationStatus == CNAuthorizationStatusNotDetermined) {
        CNContactStore *contactStore = [[CNContactStore alloc] init];
        [contactStore requestAccessForEntityType:CNEntityTypeContacts completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (granted) {
                TTLog(@"获取通讯录授权成功");
                [self readContacts];
            } else {
                TTLog(@"获取通讯录授权失败, error=%@", error);
            }
        }];
    }else{
        CNAuthorizationStatus authorizationStatus = [CNContactStore authorizationStatusForEntityType:CNEntityTypeContacts];
        if (authorizationStatus == CNAuthorizationStatusAuthorized) {
            [self readContacts];
        }else{
            TTLog(@"获取通讯录没有授权...");
        }
    }
    
}

/** 读取 通讯录*/
- (void)readContacts {
    
    AppDelegate* delegate = (AppDelegate*)kAppDelegate;
    delegate.dataArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    // 2. 获取联系人仓库
    CNContactStore * contactStore = [[CNContactStore alloc] init];
    // 3. 创建联系人信息的请求对象
    // 获取指定的字段,并不是要获取所有字段，需要指定具体的字段
    NSArray *keysToFetch = @[CNContactGivenNameKey, CNContactFamilyNameKey, CNContactPhoneNumbersKey];
    // 4. 根据请求Key, 创建请求对象
    CNContactFetchRequest *fetchRequest = [[CNContactFetchRequest alloc] initWithKeysToFetch:keysToFetch];
    // 5. 发送请求
    [contactStore enumerateContactsWithFetchRequest:fetchRequest error:nil usingBlock:^(CNContact * _Nonnull contact, BOOL * _Nonnull stop) {
        
        // 6.1 获取姓名
        NSString *givenName = contact.givenName;
        NSString *familyName = contact.familyName;
        //        TTLog(@"givenName=%@, familyName=%@", givenName, familyName);
        
        
        NSString *nameStr = @"";
        if (givenName && familyName) {
            nameStr = [NSString stringWithFormat:@"%@%@",familyName,givenName];
        } else if(familyName && !givenName){
            nameStr = (NSString *)(familyName);
        } else if(!familyName && givenName){
            nameStr = (NSString *)(givenName);
        } else {
            nameStr = @"(空)";
        }
        
        // 6.2 获取电话
        NSArray * phoneArray = contact.phoneNumbers;
        for (CNLabeledValue *labelValue in phoneArray) {
            
            FMTongxunluModel *model = [[FMTongxunluModel alloc] init];
            CNPhoneNumber *phoneNumber = labelValue.value;
//            TTLog(@"姓名 - %@ \n 姓名 - %@ \n 姓名 - %@ \n 电话 - %@",nameStr,givenName,familyName,phoneNumber.stringValue);
            //设置电话号码
            model.phone = [phoneNumber.stringValue stringByReplacingOccurrencesOfString:@"-" withString:@""];
            model.name = nameStr;
            [delegate.dataArray addObject:model];
        }
//        TTLog(@"delegate.dataArray -- %@",delegate.dataArray);
    }];
}

@end
