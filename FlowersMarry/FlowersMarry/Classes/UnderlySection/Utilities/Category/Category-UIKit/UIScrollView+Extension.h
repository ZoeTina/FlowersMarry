//
//  UIScrollView+Extension.h
//  LZExtension
//
//  Created by 寕小陌 on 2016/12/12.
//  Copyright © 2016年 寕小陌. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  此分类增加了一些关于UIScrollView的有用方法
 */
@interface UIScrollView (Extension)

/**
 *  快速创建一个UIScrollView并且设置一些属性
 *
 *  @param frame                ScrollView的frame
 *  @param contentSize          ScrollView的content size
 *  @param clipsToBounds        设置ScrollView是否需要剪切边界
 *  @param pagingEnabled        设置ScrollView是否开启分页效果
 *  @param showScrollIndicators 设置是否展示水平和垂直指示条
 *  @param delegate             ScrollView的代理
 *
 *  @return 返回创建的UIScrollView实例
 */
+ (instancetype _Nonnull)lz_initWithFrame:(CGRect)frame
                              contentSize:(CGSize)contentSize
                            clipsToBounds:(BOOL)clipsToBounds
                            pagingEnabled:(BOOL)pagingEnabled
                     showScrollIndicators:(BOOL)showScrollIndicators
                                 delegate:(id<UIScrollViewDelegate> _Nullable)delegate;


@end
