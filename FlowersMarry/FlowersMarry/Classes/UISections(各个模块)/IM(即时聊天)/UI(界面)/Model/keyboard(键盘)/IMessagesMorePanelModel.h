//
//  IMessagesMorePanelModel.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/9/11.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MoreItem.h"

@interface IMessagesMorePanelModel : NSObject
/// 加载更多数据
+ (NSArray *)loadMoreArray;
@end
