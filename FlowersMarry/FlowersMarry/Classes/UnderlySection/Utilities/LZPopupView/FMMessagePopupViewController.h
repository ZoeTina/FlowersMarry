//
//  FMMessagePopupViewController.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/6/25.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "MVBaseViewController.h"

@protocol LZPopupViewDelegate;

@interface FMMessagePopupViewController : MVBaseViewController

@property (assign, nonatomic) id <LZPopupViewDelegate>delegate;
@property (copy, nonatomic) NSString *messageStr;   // 消息内容
@property (copy, nonatomic) NSString *btnTxtStr;    // 按钮文字
@property (copy, nonatomic) NSString *iconImage;    // 显示的图标

@end

@protocol LZPopupViewDelegate<NSObject>
@optional
- (void)dismissedButtonClicked:(FMMessagePopupViewController *)secondDetailViewController;
@end
