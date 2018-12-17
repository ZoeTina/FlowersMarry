//
//  SCSegmentTitleView.h
//  MerchantVersion
//
//  Created by 寜小陌 on 2018/1/17.
//  Copyright © 2018年 寜小陌. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SCSegmentTitleView;

typedef enum : NSUInteger {
    SCIndicatorTypeDefault,//默认与按钮长度相同
    SCIndicatorTypeEqualTitle,//与文字长度相同
    SCIndicatorTypeCustom,//自定义文字边缘延伸宽度
    SCIndicatorTypeNone,
} SCIndicatorType;//指示器类型枚举

@protocol SCSegmentTitleViewDelegate <NSObject>

@optional

/**
 切换标题

 @param titleView SCSegmentTitleView
 @param startIndex 切换前标题索引
 @param endIndex 切换后标题索引
 */
- (void)SCSegmentTitleView:(SCSegmentTitleView *)titleView startIndex:(NSInteger)startIndex endIndex:(NSInteger)endIndex;

/**
 将要开始滑动
 
 @param titleView SCSegmentTitleView
 */
- (void)SCSegmentTitleViewWillBeginDragging:(SCSegmentTitleView *)titleView;

/**
 将要停止滑动
 
 @param titleView SCSegmentTitleView
 */
- (void)SCSegmentTitleViewWillEndDragging:(SCSegmentTitleView *)titleView;

@end

@interface SCSegmentTitleView : UIView

@property (nonatomic, weak) id<SCSegmentTitleViewDelegate>delegate;

/**
 标题文字间距，默认20
 */
@property (nonatomic, assign) CGFloat itemMargin;

/**
 当前选中标题索引，默认0
 */
@property (nonatomic, assign) NSInteger selectIndex;

/**
 标题字体大小，默认15
 */
@property (nonatomic, strong) UIFont *titleFont;

/**
 标题选中字体大小，默认15
 */
@property (nonatomic, strong) UIFont *titleSelectFont;

/**
 标题正常颜色，默认black
 */
@property (nonatomic, strong) UIColor *titleNormalColor;

/**
 标题选中颜色，默认red
 */
@property (nonatomic, strong) UIColor *titleSelectColor;

/**
 指示器颜色，默认与titleSelectColor一样,在SCIndicatorTypeNone下无效
 */
@property (nonatomic, strong) UIColor *indicatorColor;

/**
 在SCIndicatorTypeCustom时可自定义此属性，为指示器一端延伸长度，默认5
 */
@property (nonatomic, assign) CGFloat indicatorExtension;

/**
 对象方法创建SCSegmentTitleView

 @param frame frame
 @param titlesArr 标题数组
 @param delegate delegate
 @param incatorType 指示器类型
 @return SCSegmentTitleView
 */
- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titlesArr delegate:(id<SCSegmentTitleViewDelegate>)delegate indicatorType:(SCIndicatorType)incatorType;

@end
