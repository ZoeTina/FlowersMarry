//
//  AppDelegate.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/6/21.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMTongxunluModel.h"
#import "FMSelectedCityModel.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,TencentLBSLocationManagerDelegate>
{
    LZNavigationController *navigationController;
    BMKMapManager* _mapManager;
}
@property (strong, nonatomic) UIWindow *window;


@property (readwrite, nonatomic, strong) TencentLBSLocationManager *locationManager;
/** 通讯录Models数据 */
@property (strong, nonatomic) NSMutableArray<FMTongxunluModel *> *dataArray;
/** 城市数据Models数据 */
@property (strong, nonatomic) FMSelectedCityModel *cityDataModel;

- (void) jumpMainVC;
- (void) openTencentLocation;
@end

