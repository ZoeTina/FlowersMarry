//
//  TencentMapViewController.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/11/22.
//  Copyright © 2018 宁小陌. All rights reserved.
//

#import "TencentMapViewController.h"

@interface TencentMapViewController ()

@property (strong, nonatomic) QMapView *mapView;

@end

@implementation TencentMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.mapView];
    [self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.equalTo(@(kScreenWidth));
    }];
}

- (QMapView *)mapView{
    if (!_mapView) {
        _mapView = [QMapView lz_viewWithColor:kRandomColor];
    }
    return _mapView;
}

@end
