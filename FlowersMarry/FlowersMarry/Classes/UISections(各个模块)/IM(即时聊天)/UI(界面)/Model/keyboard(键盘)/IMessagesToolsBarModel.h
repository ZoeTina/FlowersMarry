//
//  IMessagesToolsBarModel.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/9/11.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChatToolBarItem.h"

@interface IMessagesToolsBarModel : NSObject
/// 加载工具栏上的数据
+ (NSArray *)loadToolsArray;
@end
