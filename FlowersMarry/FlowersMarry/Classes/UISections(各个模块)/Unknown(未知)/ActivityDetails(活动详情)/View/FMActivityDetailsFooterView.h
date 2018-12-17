//
//  FMActivityDetailsFooterView.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/12.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <UIKit/UIKit.h>

//这里要定义一个block的别名(申明) 类型 ----> void (^) (NSString *text)
typedef void(^ChangeTextBlock) (NSInteger idx);

@interface FMActivityDetailsFooterView : UIView


//定义一个block
@property (nonatomic, copy) ChangeTextBlock block;


/// 底部工具栏
@property (nonatomic, strong) UIButton *kefuButton;
@property (nonatomic, strong) UIButton *guanzhuButton;
/// 商铺 or 评论
@property (nonatomic, strong) UIButton *shangpuButton;
@property (nonatomic, strong) UIButton *yuyueButton;

- (void) didClickGuanZhu:(NSString *)cp_id;
@end
