//
//  FMMessageViewController.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/9/11.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMMessageViewController.h"
#import "IMessagesViewController.h"
#import "TTMessageViewController.h"
#import "FMComboListDetailsViewController.h"
#import "FMChooseMusicViewController.h"
#import "TTTencentMapViewController.h"

@interface FMMessageViewController ()

@end

@implementation FMMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *reminderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [reminderBtn setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    [reminderBtn addTarget:self action:@selector(reminderBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [reminderBtn setTitle:@"点击这里重新加载" forState:UIControlStateNormal];
    [self.view addSubview:reminderBtn];
    [reminderBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@100);
        make.centerX.equalTo(self.view);
    }];
    UIButton *messageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [messageBtn setTitleColor:[UIColor darkTextColor] forState:UIControlStateNormal];
    messageBtn.backgroundColor = [UIColor clearColor];
    [messageBtn addTarget:self action:@selector(messageBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [messageBtn setTitle:@"点击这里重新加载" forState:UIControlStateNormal];
    [self.view addSubview:messageBtn];
    [messageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(reminderBtn.mas_bottom).offset(40);
        make.centerX.equalTo(self.view);
    }];
}

- (void) reminderBtnClicked{
//    IMessagesViewController *vc = [[IMessagesViewController alloc] init];
//    FMComboListDetailsViewController *vc = [[FMComboListDetailsViewController alloc] init];
//    FMChooseMusicViewController *vc = [[FMChooseMusicViewController alloc] init];
//    //        vc.selectMusicStr = self.musicLabel.text;
//    vc.block = ^(NSString * _Nonnull chooseContent, NSString * _Nonnull muiscID) {
//        TTLog(@"选中后的数据：%@ ；第%@行",chooseContent,muiscID);
//    };
//    TTPushVC(vc);
    
    
    
    WXLaunchMiniProgramReq *launchMiniProgramReq = [WXLaunchMiniProgramReq object];
    // 拉起的小程序的username
    launchMiniProgramReq.userName = @"gh_81eadf2dcedd";//userName;
    // 拉起小程序页面的可带参路径，不填默认拉起小程序首页
    launchMiniProgramReq.path = @"/pages/login/index?source=iosApp";//path;
    // 拉起小程序的类型
    launchMiniProgramReq.miniProgramType = WXMiniProgramTypeTest;// miniProgramType;
    [WXApi sendReq:launchMiniProgramReq];
}

- (void) messageBtnClicked{
//    TTMessageViewController *vc = [[TTMessageViewController alloc] init];
    TTTencentMapViewController *vc = [[TTTencentMapViewController alloc] init];
    TTPushVC(vc);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
