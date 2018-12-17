//
//  SCSwipeUpInteractiveTransition.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/18.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface SCSwipeUpInteractiveTransition : UIPercentDrivenInteractiveTransition

@property (nonatomic, strong) UIViewController *vc;
@property (nonatomic, assign) BOOL isInteracting;
@property (nonatomic, assign) BOOL shouldComplete;

- (instancetype)initVC:(UIViewController *)vc;

@end
