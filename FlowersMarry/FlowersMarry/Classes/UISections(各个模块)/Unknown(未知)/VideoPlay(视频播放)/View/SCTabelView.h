//
//  SCTabelView.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/8/31.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CustomTableViewDelegete<NSObject>
-(void)getDataWithPage;
@end

@interface SCTabelView : UITableView
/// 自带数据源
@property(nonatomic, strong)NSMutableArray *items;
@property(nonatomic, weak)id<CustomTableViewDelegete> refreshDelegete;
/// 加载到第几页
@property(nonatomic)int pageIndex;
/// 是否正在加载
@property(nonatomic)BOOL isUpdating;
-(void)addMJ;
@end
