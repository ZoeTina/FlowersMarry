//
//  TTMoreKeyboardDelegate.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/9/18.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TTMoreKeyboardItem.h"

@protocol TTMoreKeyboardDelegate <NSObject>
@optional
- (void)moreKeyboard:(id)keyboard didSelectedFunctionItem:(TLMoreKeyboardItem *)funcItem;

@end

