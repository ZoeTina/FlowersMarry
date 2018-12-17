//
//  SCVerticallyAlignedLabel.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/5.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, SCVerticalAlignment)
{
    SCVerticalAlignmentTop = 0, // 上对齐
    SCVerticalAlignmentMiddle,//居中
    SCVerticalAlignmentBottom,//底部对齐
};

IB_DESIGNABLE
@interface SCVerticallyAlignedLabel : UILabel

#if TARGET_INTERFACE_BUILDER
@property (nonatomic, assign) IBInspectable NSUInteger verticalAlignment;
#else
//// 居中方式
@property (nonatomic,assign) SCVerticalAlignment verticalAlignment;
#endif
@end
