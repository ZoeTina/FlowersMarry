//
//  FMMerchantsHomeHeaderView.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/11.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <UIKit/UIKit.h>

//typedef void(^FMImageTemmpletCellCallBlock)(PVVideoListModel* videoListModel);
typedef void(^FMImageTemmpletCellCallBlock)(NSInteger idx);

@interface FMMerchantsHomeHeaderView : UITableViewCell
-(void)setImagesTemmpletCellCallBlock:(FMImageTemmpletCellCallBlock)block;
/// 活动列表
@property (nonatomic, strong) NSMutableArray<BusinessHuodongModel *> *listModel;

@end
