//
//  FMComboListDetailsViewController.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/10/30.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "WMPageController.h"

NS_ASSUME_NONNULL_BEGIN

@interface FMComboListDetailsViewController : WMPageController
/// 商家首页套餐列表数据的套餐信息
@property (strong, nonatomic) BusinessTaoxiModel *taoxiDataModel;
@end

NS_ASSUME_NONNULL_END
