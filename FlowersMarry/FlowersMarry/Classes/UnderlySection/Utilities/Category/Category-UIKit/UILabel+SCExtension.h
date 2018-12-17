//
//  UILabel+SCExtension.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/9.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (SCExtension)
/**
 修改label内容距 `top` `left` `bottom` `right` 边距
 */
@property (nonatomic, assign) UIEdgeInsets sc_contentInsets;
@end
