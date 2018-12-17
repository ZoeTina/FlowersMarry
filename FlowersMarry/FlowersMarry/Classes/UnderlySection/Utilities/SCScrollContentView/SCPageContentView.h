//
//  SCPageContentView.h
//  MerchantVersion
//
//  Created by 寜小陌 on 2018/1/17.
//  Copyright © 2018年 寜小陌. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SCPageContentView;

@protocol SCPageContentViewDelegate <NSObject>

@optional

/**
 SCPageContentView开始滑动

 @param contentView SCPageContentView
 */
- (void)SCContentViewWillBeginDragging:(SCPageContentView *)contentView;

/**
 SCPageContentView滑动调用

 @param contentView SCPageContentView
 @param startIndex 开始滑动页面索引
 @param endIndex 结束滑动页面索引
 @param progress 滑动进度
 */
- (void)SCContentViewDidScroll:(SCPageContentView *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex progress:(CGFloat)progress;

/**
 SCPageContentView结束滑动

 @param contentView SCPageContentView
 @param startIndex 开始滑动索引
 @param endIndex 结束滑动索引
 */
- (void)SCContenViewDidEndDecelerating:(SCPageContentView *)contentView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex;

/**
 scrollViewDidEndDragging

 @param contentView SCPageContentView
 */
- (void)FSContenViewDidEndDragging:(SCPageContentView *)contentView;

@end

@interface SCPageContentView : UIView

/**
 对象方法创建SCPageContentView

 @param frame frame
 @param childVCs 子VC数组
 @param parentVC 父视图VC
 @param delegate delegate
 @return SCPageContentView
 */
- (instancetype)initWithFrame:(CGRect)frame childVCs:(NSArray *)childVCs parentVC:(UIViewController *)parentVC delegate:(id<SCPageContentViewDelegate>)delegate;

@property (nonatomic, weak) id<SCPageContentViewDelegate>delegate;

/**
 设置contentView当前展示的页面索引，默认为0
 */
@property (nonatomic, assign) NSInteger contentViewCurrentIndex;

/**
 设置contentView能否左右滑动，默认YES
 */
@property (nonatomic, assign) BOOL contentViewCanScroll;

@end
