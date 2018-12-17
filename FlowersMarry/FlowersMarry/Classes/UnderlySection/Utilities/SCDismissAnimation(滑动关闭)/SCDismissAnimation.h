//
//  SCDismissAnimation.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/18.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SCDismissAnimation : NSObject<UIViewControllerAnimatedTransitioning>

@end




/**

使用方式
 FMPictureCollectionCommentsViewController *vc = [[FMPictureCollectionCommentsViewController alloc] init];
 vc.view.backgroundColor = kColorWithRGB(211, 0, 0);
 _interactiveTransition = [[SCSwipeUpInteractiveTransition alloc]initVC:vc];
 //            _interactiveTransition.vc.view.backgroundColor = kColorWithRGB(112, 112, 112);
 //            vc.view.height = 200;
 //            vc.view.top = 100;
 vc.transitioningDelegate = self;
 [self.navigationController presentViewController:vc animated:YES completion:nil];

**/
