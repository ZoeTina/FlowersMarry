//
//  LZBasePickerView.h
//  PandaVideo
//
//  Created by 寜小陌 on 2017/8/29.
//  Copyright © 2017年 寜小陌. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kDatePicHeight 200
#define kTopViewHeight 44


@interface LZBasePickerView : UIView
/** 背景视图 */
@property (nonatomic, strong) UIView *backgroundView;
/** 弹出视图 */
@property (nonatomic, strong) UIView *alertView;
/** 顶部视图 */
@property (nonatomic, strong) UIView *topView;
/** 左边取消按钮 */
@property (nonatomic, strong) UIButton *leftBtn;
/** 右边确定按钮 */
@property (nonatomic, strong) UIButton *rightBtn;
/** 中间标题 */
@property (nonatomic, strong) UILabel *titleLabel;
/** 分割线视图 */ 
@property (nonatomic, strong) UIView *lineView;

/** 初始化子视图 */
- (void)initUI;

/** 点击背景遮罩图层事件 */
- (void)didTapBackgroundView:(UITapGestureRecognizer *)sender;

/** 取消按钮的点击事件 */
- (void)clickLeftBtn;

/** 确定按钮的点击事件 */
- (void)clickRightBtn;

@end
