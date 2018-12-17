//
//  TTBaseToolsViewController.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/9/26.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TTBaseToolsViewController : UIViewController
/// 给当前view添加识别手势,点击tableView中带有输入框点击背景关闭键盘
- (void) addGesture:(UITableView *) tableView;
@end

NS_ASSUME_NONNULL_END
