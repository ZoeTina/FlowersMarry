//
//  FMBaseSwitchPageViewController.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/6/21.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "MVPageController.h"

static CGFloat const kMVMenuViewHeight = 45.0;
static CGFloat const kMVHeaderViewHeight = 0;
static CGFloat const kNavigationBarHeight = 0;
@interface FMBaseSwitchPageViewController : MVPageController
/// 宾客回复
@property (nonatomic, strong) NSArray           *itemModelArray;
@property (nonatomic, strong) NSArray           *dataModelArray;
@property (nonatomic, strong) NSArray           *dataSourceArray;
@property (nonatomic, assign) CGFloat           viewTop;
@end
