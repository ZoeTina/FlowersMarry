//
//  LZRootViewController.h
//  LZKit
//
//  Created by 寕小陌 on 2017/10/12.
//  Copyright © 2017年 寕小陌. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 导航控制器基类 */
@interface LZRootViewController : UITabBarController

/** 是否为Json文件数据 */
@property (nonatomic, assign)BOOL lz_isJson;


/**
 设置小红点
 
 @param index tabbar下标
 @param isShow 是显示还是隐藏
 */
-(void)setRedDotWithIndex:(NSInteger)index isShow:(BOOL)isShow;
@end
