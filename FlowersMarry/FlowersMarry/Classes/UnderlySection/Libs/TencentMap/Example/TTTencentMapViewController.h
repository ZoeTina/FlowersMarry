//
//  TTTencentMapViewController.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/11/15.
//  Copyright © 2018 宁小陌. All rights reserved.
//

#import "TTBaseToolsViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^SelectedAddressBlock) (NSString *address,CGFloat longitude,CGFloat latitude);
@interface TTTencentMapViewController : TTBaseToolsViewController
@property(nonatomic, copy) SelectedAddressBlock addressBlock;

/// 记录第一次进入地图界面的坐标
@property (nonatomic, assign) CLLocationCoordinate2D userCoordinate2D;
/// 记录坐标变化前的最后一次的坐标
@property (nonatomic, assign) CLLocationCoordinate2D lastCoordinate2D;

@end

NS_ASSUME_NONNULL_END
