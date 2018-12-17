//
//  TTSeacherResultTableViewController.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/11/15.
//  Copyright © 2018 宁小陌. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// 自定义的查询结果界面的协议，用于传递查询结果界面的相关操作
@protocol TTSeacherResultTableViewControllerDelegete <NSObject>

@optional

/*!
 *@brief 用于获取搜索界面的择值
 *
 *@param Poi 位置的具体信息，包含名字、经纬度等
 */
- (void)SeacherResultBlockData:(QMSSuggestionPoiData *)Poi;

@end

@interface TTSeacherResultTableViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray<QMSSuggestionPoiData *> *resultArr;
@property (nonatomic, weak) id<TTSeacherResultTableViewControllerDelegete> SeacherResultDelegate;
@property (nonatomic, weak) UISearchBar *searchBar;
@property (nonatomic, weak) UISearchController *searchController;

@end

NS_ASSUME_NONNULL_END
