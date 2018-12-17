//
//  FMBasicInformationViewController.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/11/6.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "TTBaseToolsViewController.h"
#import "FMBasicInformationModel.h"
#import "FMElectronicInvitationModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface FMBasicInformationViewController : TTBaseToolsViewController<TencentLBSLocationManagerDelegate>
@property (nonatomic, strong) BasicInformationModel *informationModel;
@property (nonatomic, strong) TencentMapModel *mapModel;
@property (nonatomic, strong) UITableView *tableView;
- (id)initInvitationModel:(InvitationModel *) invitationModel;
 
@property (readwrite, nonatomic, strong) TencentLBSLocationManager *locationManager;

/// 地图
@property (nonatomic, strong) QMapView *mapView;
@property (nonatomic, strong) UIImageView *redPinImageView;
/// 记录第一次进入地图界面的坐标
@property (nonatomic, assign) CLLocationCoordinate2D userCoordinate2D;
/// 设置地图的中心位置
- (void) setMapCoordinate2D:(CLLocationCoordinate2D)currentCoordinate2D;
@end

NS_ASSUME_NONNULL_END
