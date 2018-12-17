//
//  FMActivityDetailsViewController.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/11.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "MVBaseTableViewController.h"
#import "FMBusinessModel.h"

@interface FMActivityDetailsViewController : MVBaseTableViewController
- (id)initBusinessModel:(BusinessModel *)businessModel hd_id:(NSString *)hd_id;
@end
