//
//  UIViewController+LZNavigationController.h
//  MerchantVersion
//
//  Created by 寜小陌 on 2018/1/18.
//  Copyright © 2018年 寜小陌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (LZNavigationController)

@property (nonatomic, assign) BOOL lz_fullScreenPopGestureEnabled;
@property (nonatomic, weak) LZNavigationController *lz_navigationController;


@end
