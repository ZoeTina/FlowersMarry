//
//  FMTaskSectionHeaderView.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/10/15.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FMTaskSectionHeaderView : UIView
@property NSUInteger section;
@property (nonatomic, weak) UITableView *tableView;
@end

NS_ASSUME_NONNULL_END
