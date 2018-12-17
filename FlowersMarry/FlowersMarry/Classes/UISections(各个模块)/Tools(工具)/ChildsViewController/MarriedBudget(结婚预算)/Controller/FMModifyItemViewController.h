//
//  FMModifyItemViewController.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/10/11.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "TTBaseToolsViewController.h"

NS_ASSUME_NONNULL_BEGIN

//这里要定义一个block的别名(申明) 类型 ----> void (^) (NSString *text)
typedef void(^ModifyItemViewControllerBlock) (NSMutableArray *dataArray);
@interface FMModifyItemViewController : TTBaseToolsViewController
//定义一个block
@property (nonatomic, copy) ModifyItemViewControllerBlock modifyBlock;
@end

NS_ASSUME_NONNULL_END
