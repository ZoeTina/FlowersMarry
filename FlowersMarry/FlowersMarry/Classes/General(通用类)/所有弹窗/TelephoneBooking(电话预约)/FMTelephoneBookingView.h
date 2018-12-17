//
//  FMTelephoneBookingView.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/8/20.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FMTelephoneBookingView;

@protocol FMTelephoneBookingViewDelegate <NSObject>

- (void) didTelephoneBookingButtonClick:(FMTelephoneBookingView *) view;

@end
@interface FMTelephoneBookingView : UIView

//展示从底部向上弹出的UIView（包含遮罩）
- (void)showInView:(UIView *)view;
@property (nonatomic, weak) id<FMTelephoneBookingViewDelegate> delegate;  //实现代理

/// 标题
@property (nonatomic, strong) UILabel *titleLabel;
/// 劵图标
@property (nonatomic, strong) UIImageView *imagesCoupons;
/// 劵文字
@property (nonatomic, strong) UILabel *labelCoupons;
/// 礼物图标
@property (nonatomic, strong) UIImageView *imagesGift;
/// 礼物文字
@property (nonatomic, strong) UILabel *labelGift;
/// 电话号码输入框
@property (nonatomic, strong) UITextField *telTextField;
/// 立即预约按钮
@property (nonatomic, strong) UIButton *immediatelyButton;
@property (nonatomic, strong) UIView *telContainerView;

- (id)initDataString:(NSString *)cp_id ap_type:(NSString *)ap_type isPreferential:(BOOL)isPreferential;

@end
