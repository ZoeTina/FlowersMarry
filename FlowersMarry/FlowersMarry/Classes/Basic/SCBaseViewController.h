//
//  SCBaseViewController.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/6/27.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SCNavigationBar.h"

@interface SCBaseViewController : UIViewController

/** 自定义导航栏 */
@property (nonatomic, strong) SCNavigationBar *scNavigationBar;

/** 自定义导航条 统一使用scNavigationItem */
@property (nonatomic, strong) UINavigationItem *scNavigationItem;

/** 可选择表格tableView */
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *reminderBtn;
@property (nonatomic, strong) UIView *baseTopView;


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

/** 如果不使用BaseViewController中的setupNavigationBar，只需重写次方法不调用super即可 */
- (void)setupNavigationBar;

///重新加载数据
-(void)reLoadVCData;

///调整按钮位置
-(void)adjustmentReminderBtnFrame:(CGRect)frame;
@end
