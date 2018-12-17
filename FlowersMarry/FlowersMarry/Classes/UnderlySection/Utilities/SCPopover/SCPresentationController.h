//
//  SCPresentationController.h
//  SCPopover
//
//  Created by 宁小陌 on 2018/7/3.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCPopoverMacro.h"

@interface SCPresentationController : UIPresentationController

@property(nonatomic,assign)CGSize           presentedSize;
@property(nonatomic,assign)CGFloat          presentedHeight;

/// 蒙版
@property(nonatomic,strong)UIView           *coverView;
@property(nonatomic,assign)SCPopoverType    popoverType;

@end
