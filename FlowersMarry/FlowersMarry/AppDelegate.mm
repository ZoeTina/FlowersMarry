//
//  AppDelegate.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/6/21.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "AppDelegate.h"
#import "LZRootViewController.h"
#import "AppDelegate+FMShare.h"
#import "AppDelegate+Tencent.h"
//#import "SCMainViewController.h"
#import "JPFPSStatus.h"
#import "FMLocation.h"
#import "AppDelegate+FMAddressBook.h"
#import "AppDelegate+CityData.h"
#import "FMLoginViewController.h"
#import "FMTelPhoneBindViewController.h"
#import "IQKeyboardManager.h"

#import <BMKLocationkit/BMKLocationComponent.h>
#import <CoreLocation/CoreLocation.h>
@interface AppDelegate ()<BMKGeneralDelegate,BMKLocationAuthDelegate,CLLocationManagerDelegate,WXApiDelegate>
@property (nonatomic, strong) FMLocation* location;
@property (nonatomic, assign) NSInteger loginCount;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    if (@available(iOS 11.0, *)) {
        [[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }
    // 实现App跳转小程序
    [WXApi registerApp:kWechatInvitationId];

    //    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
//    [dictionary setObject:@"123" forKey:@"cp_id"];
//    [dictionary setObject:@"wdeeskfh2376428" forKey:@"mobile"];
//    [dictionary setObject:@"1" forKey:@"type"];
//    [dictionary setObject:@"1237549754676" forKey:@"timestap"];
//    NSString *sign = [Utils sortedDictionarybyCaseConversion:dictionary];
//    TTLog(@"签名数据 sign -- %@",sign);
    ///初始化登陆信息
    [[PVUserModel shared] load];
    
    TTLog(@"kUserInfo.site_id --- %@",kUserInfo.site_id);
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    TTLog(@"kUserInfo.site_id --- %@",[user objectForKey:@"site_id"]);
    kUserInfo.site_id = [user objectForKey:@"site_id"];
    kUserInfo.city_id = [user objectForKey:@"city_id"];
    kUserInfo.province_id = [user objectForKey:@"province_id"];
    //配置键盘
    [IQKeyboardManager sharedManager];
    [self registerMobLoginAndShare];
    [self setBaiduOrTencentMap:NO];
    //开启定位
//    [self.location startLocation];
    /// 开启腾讯地图单次定位
    [self openTencentLocation];
    // 获取城市数据
    [self requestAuthorization];
    /// 创建主控制器
    [self showMainViewController];
#if defined(DEBUG)||defined(_DEBUG)
    [[JPFPSStatus sharedInstance] open];
#endif
    
    // 注册通知
    [kNotificationCenter addObserver:self selector:@selector(requestAuthorization) name:@"obtainCityData" object:nil];
    ///开启监听网络
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        [kNotificationCenter postNotificationName:NetworkReachabilityStatus object:nil userInfo:@{@"status":@(status)}];
    }];
    return YES;
}

- (void)showMainViewController {
    // 1. 创建窗口
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    //设置窗口颜色
    self.window.backgroundColor = [UIColor whiteColor];
    //设置窗口为主窗口并且显示
    [self.window makeKeyAndVisible];
    if (kUserInfo.isLogin) {
        // 设置窗口的根控制器
//        if (!kUserInfo.isBindTel) {
            // 设置窗口的根控制器
            [self jumpMainVC];
        
        self.loginCount = 0;
        [self automaticLogin];
//        }else{
//            FMTelPhoneBindViewController *bindVC   = [[FMTelPhoneBindViewController alloc] init];
//            LZNavigationController *bindNav = [[LZNavigationController alloc]initWithRootViewController:bindVC];
//            bindVC.type = 1;
//            self.window.rootViewController = bindNav;
//            [self jumpLoginVC];
//        }
    }else{
        [self jumpLoginVC];
    }
}

//// 在登录的情况下默认自动再登录一次
- (void) automaticLogin{
    if (self.loginCount<3) {
        [SCHttpTools getWithURLString:@"index/loginbyentoken" parameter:@{@"token":kUserInfo.logintoken} success:^(id responseObject) {
            if (responseObject){
                id result = responseObject;
                if (result) {
                    FMGeneralModel *generalModel = [FMGeneralModel mj_objectWithKeyValues:result];
                    if (generalModel.errcode == 0) {
                        PVUserModel *userModel = [PVUserModel shared];
                        [userModel yy_modelSetWithDictionary:[result lz_objectForKey:@"data"]];
                        [userModel dump];
                    }else{
                        if (self.loginCount<3) {
                            self.loginCount += 1;
                            [self automaticLogin];
                        }else{
                            [self jumpLoginVC];
                            NSString *message = [NSString stringWithFormat:@"自动登录:%@",[result lz_objectForKey:@"message"]];
                            Toast(message);
                        }
                    }
                }
            }
        } failure:^(NSError *error) {
            self.loginCount += 1;
            [self automaticLogin];
        }];
    }
}

/// 设置百度地图
- (void) setBaiduOrTencentMap:(BOOL) isBaidu{
    if (isBaidu) {
        //百度地图
        _mapManager = [[BMKMapManager alloc] init];
        BOOL ret = [_mapManager start:kBaiDuAppKey generalDelegate:nil];
        if (!ret) {
            TTLog(@"百度地图启动失败");
        } else {
            TTLog(@"百度地图启动成功");
        }
    }else{
        [[QMapServices sharedServices] setApiKey:kTencentAppKey];
        [[QMSSearchServices sharedServices] setApiKey:kTencentAppKey];
    }
}

- (void)onGetNetworkState:(int)iError {
    if (0 == iError) {
        TTLog(@"联网成功");
    } else{
        TTLog(@"联网失败 : %d",iError);
    }
}

- (void)onGetPermissionState:(int)iError {
    if (0 == iError) {
        TTLog(@"授权成功");
    } else {
        TTLog(@"授权失败 : %d",iError);
    }
}

- (void) jumpLoginVC{
    // 设置窗口的根控制器
    FMLoginViewController *loginVC   = [[FMLoginViewController alloc] init];
    LZNavigationController *loginNav = [[LZNavigationController alloc]initWithRootViewController:loginVC];
    self.window.rootViewController = loginNav;
}

/// 开启腾讯定位
- (void) openTencentLocation{
    [self initTencentMapLocation];
}

- (void) jumpMainVC{
    LZRootViewController *mainVC   = [[LZRootViewController alloc] init];
    self.window.rootViewController = mainVC;
}

/** 通讯录授权及其获取联系人数据*/
- (void) requestAuthorization{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // 处理耗时操作的代码块...
        // 获取通讯录数据
//        [self requestAuthorizationForAddressBook];
        /// 获取城市数据
        [self requestCityData];
        //通知主线程刷新
        dispatch_async(dispatch_get_main_queue(), ^{
            //回调或者说是通知主线程刷新，
        });
        
    });
}

-(FMLocation *)location{
    if (!_location) {
        _location = [[FMLocation alloc]  init];
    }
    return _location;
}

#pragma mark -------------- 微信 -------------
//handleOpenURL
- (BOOL) application:(UIApplication *)application handleOpenURL:(NSURL *)url{
    return [WXApi handleOpenURL:url delegate:self];
}

//- (BOOL) application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options{
//    return [WXApi handleOpenURL:url delegate:self];
//}

- (BOOL) application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    return [WXApi handleOpenURL:url delegate:self];
}

/// 跳转微信后的回调
-(void) onResp:(BaseResp*)resp {
    if([resp isKindOfClass:[SendMessageToWXResp class]]) {
        NSString *strTitle = [NSString stringWithFormat:@"发送媒体消息结果"];
        NSString *strMsg = [NSString stringWithFormat:@"%@\nerrcode:%d", strTitle,resp.errCode];
        TTLog(@"onResp -- %@",strTitle);
        Toast(strMsg);
    }
}

-(void) onReq:(BaseReq*)req{
    if([req isKindOfClass:[GetMessageFromWXReq class]]) {
        // 微信请求App提供内容， 需要app提供内容后使用sendRsp返回
        NSString *strTitle = [NSString stringWithFormat:@"微信请求App提供内容"];
        NSString *strMsg = @"微信请求App提供内容，App要调用sendResp:GetMessageFromWXResp返回给微信";
        TTLog(@"onReq - 1 -- %@",strTitle);
        Toast(strMsg);
    } else if([req isKindOfClass:[ShowMessageFromWXReq class]]) {
        ShowMessageFromWXReq* temp = (ShowMessageFromWXReq*)req;
        WXMediaMessage *msg = temp.message;
        
        //显示微信传过来的内容
        WXAppExtendObject *obj = msg.mediaObject;
        
        NSString *strTitle = [NSString stringWithFormat:@"微信请求App显示内容"];
        NSString *strMsg = [NSString stringWithFormat:@"标题：%@ \n内容：%@ \n附带信息：%@ \n缩略图:%lu bytes\n\n", msg.title, msg.description, obj.extInfo, (unsigned long)msg.thumbData.length];
        Toast(strMsg);
        TTLog(@"onReq - 2 -- %@",strTitle);
    } else if([req isKindOfClass:[LaunchFromWXReq class]]) {
        //从微信启动App
        NSString *strTitle = [NSString stringWithFormat:@"从微信启动"];
        NSString *strMsg = @"这是从微信启动的消息";
        Toast(strMsg);
        TTLog(@"onResp - 3 -- %@",strTitle);
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
//
