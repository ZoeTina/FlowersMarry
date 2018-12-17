//
//  FMMineGuestsFooterView.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/10/17.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
//这里要定义一个block的别名(申明) 类型 ----> void (^) (NSString *text)
typedef void(^GuestsButtonBlock) (NSInteger idx);

@interface FMMineGuestsFooterView : UIView

//定义一个block
@property (nonatomic, copy) GuestsButtonBlock block;

/// 搜索按钮
@property (nonatomic, strong) UIButton *searchButton;
/// 添加桌子
@property (nonatomic, strong) UIButton *addDesksButton;
/// 预览按钮
@property (nonatomic, strong) UIButton *previewButton;
/// 查座
@property (nonatomic, strong) UIButton *checkSeatButton;
/// 发送宾客
@property (nonatomic, strong) UIButton *sendGuestsButton;

@end

NS_ASSUME_NONNULL_END
