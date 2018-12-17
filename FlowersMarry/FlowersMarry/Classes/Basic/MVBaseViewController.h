//
//  MVBaseViewController.h
//  MerchantVersion
//
//  Created by 寜小陌 on 2018/1/17.
//  Copyright © 2018年 寜小陌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MVBaseViewController : UIViewController

@property(nonatomic, strong)UIButton* reminderBtn;
/** 自定义导航条 统一使用scNavigationItem */
@property (nonatomic, strong) UINavigationItem *scNavigationItem;

/**
 用字符串设置用左边导航栏
 
 @param title 标题
 */
- (void)setLeftNavBarItemWithString:(NSString *)title;

/**
 用图片名字设置用左边导航栏
 
 @param imageName 图片名字
 */
- (void)setLeftNavBarItemWithImage:(NSString *)imageName;

/**
用字符串设置用右边导航栏

@param title 标题
*/
- (void)setRightNavBarItemWithString:(NSString *)title;

/**
 用图片名字设置用右边导航栏
 
 @param imageName 图片名字
 */
- (void)setRightNavBarItemWithImage:(NSString *)imageName;


/**
 左侧item点击事件
 
 @param sender UIButton
 */
- (void)leftItemClick:(UIButton *)sender;

/**
 右侧item点击事件
 
 @param sender UIButton
 */
- (void)rightItemClick:(UIButton *)sender;

///重新加载数据
-(void)reLoadVCData;

///调整按钮位置
-(void)adjustmentReminderBtnFrame:(CGRect)frame;

-(void)tapGesture;
/// 网络发生变化
- (void) netWordSatus:(NSNotification*)notification;
@end
