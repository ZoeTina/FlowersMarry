//
//  UIView+Extension.h
//  LZExtension
//
//  Created by 寕小陌 on 2016/12/9.
//  Copyright © 2016年 寕小陌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)



/*----------------------
 * Absolute coordinate *
 ----------------------*/
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGFloat originX;
@property (nonatomic, assign) CGFloat originY;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;

@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat left;
@property (nonatomic) CGFloat right;

@property (nonatomic) CGPoint viewOrigin;
@property (nonatomic) CGSize  viewSize;

/*----------------------
 * Relative coordinate *
 ----------------------*/
@property (nonatomic, readonly) CGFloat middleX;
@property (nonatomic, readonly) CGFloat middleY;
@property (nonatomic, readonly) CGPoint middlePoint;

- (void)lz_addTarget:(nonnull id)target action:(nonnull SEL)action;

#pragma mark - /***** wowtv's resentment  截屏 *****/
/** 当前视图内容生成的图像 */ 
@property (nonatomic, readonly, nullable) UIImage *lz_capturedImage;

/** 生成一个UIView */
+ (nullable instancetype)lz_viewWithColor:(nonnull UIColor *)color;

/**
 * 判断一个控件是否真正显示在主窗口
 */
- (BOOL)lz_isShowingOnKeyWindow;
@end

/**
 *  此分类增加了一些关于UIView的有用方法
 */
@interface UIView (Extensions)

/**
 *  创建一个指定frame和背景色的UIView
 *
 *  @param frame           UIView的frame
 *  @param backgroundColor UIView的背景色
 */
+ (instancetype _Nonnull)lz_initWithFrame:(CGRect)frame
                          backgroundColor:(UIColor * _Nonnull)backgroundColor;

/**
 *  设置当前view的边界周边
 *
 *  @param color  边界的颜色
 *  @param radius 边界的拐角半径
 *  @param width  边界的宽
 */
- (void)lz_createBordersWithColor:(UIColor * _Nonnull)color
                 withCornerRadius:(CGFloat)radius
                         andWidth:(CGFloat)width;

/**
 *  移除当前view的边界周边
 */
- (void)lz_removeBorders;

/**
 *  设置当前view的阴影
 *
 *  @param offset  阴影的偏移量
 *  @param opacity 阴影的不透明度
 *  @param radius  阴影的半径
 */
- (void)lz_createRectShadowWithOffset:(CGSize)offset
                              opacity:(CGFloat)opacity
                               radius:(CGFloat)radius;

/**
 *  设置当前view的拐角阴影
 *
 *  @param cornerRadius 拐角半径值
 *  @param offset       阴影的偏移量
 *  @param opacity      阴影的不透明度
 *  @param radius       阴影的半径
 */
- (void)lz_createCornerRadiusShadowWithCornerRadius:(CGFloat)cornerRadius
                                             offset:(CGSize)offset
                                            opacity:(CGFloat)opacity
                                             radius:(CGFloat)radius;

/**
 *  移除当前view的阴影
 */
- (void)lz_removeShadow;


/**
 *  设置当前view的拐角半径
 *
 *  @param radius 半径值
 */
- (void)lz_setCornerRadius:(CGFloat)radius;

/**
 *  为当前view创建震动动画效果
 */
- (void)lz_shakeView;

/**
 *  为当前view创建脉冲动画效果
 *
 *  @param duration 动画时间
 */
- (void)lz_pulseViewWithDuration:(CGFloat)duration;

/**
 *  为当前view创建心跳动画效果
 *
 *  @param duration 动画时间
 */
- (void)lz_heartbeatViewWithDuration:(CGFloat)duration;

/**
 *  为当前view增加运行效果
 */
- (void)lz_applyMotionEffects;


/**
 *  获取当前view的屏幕截图
 *
 *  @return 返回UIimage格式的屏幕截图
 */
- (UIImage * _Nonnull)lz_screenshot;

/**
 *  获取当前view的屏幕截图并保存到照片专辑中
 *
 *  @return 返回UIimage格式的屏幕截图
 */
- (UIImage * _Nonnull)lz_saveScreenshot;

/**
 *  从当前view移除所有的子视图
 */
- (void)lz_removeAllSubviews;

/**
 获取指定视图在window根控制器中的位置
 
 @param view 指定View
 @return 返回在window根控制器中的位置
 */
+ (CGRect)lz_getFrameInWindow:(UIView * _Nonnull)view;

@end
