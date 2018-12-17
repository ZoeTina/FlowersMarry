//
//  FMHeaderNavigationTranspView.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/20.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <UIKit/UIKit.h>


//这里要定义一个block的别名(申明) 类型 ----> void (^) (NSString *text)
typedef void(^onClickButtonBlock) (NSInteger idx);

@interface FMHeaderNavigationTranspView : UIView

//定义一个block
@property (nonatomic, copy) onClickButtonBlock block;

@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UIButton *shareButton;
@property (nonatomic, strong) UILabel *titleLabel;
@end
