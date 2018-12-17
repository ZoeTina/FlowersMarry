//
//  FMComboListDetailHeaderView.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/10/30.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^FMComboListDetailHeaderViewBlock) (void);
@interface FMComboListDetailHeaderView : UIView
//- (void) setToolsTaskTableHeadViewBlock:(FMComboListDetailHeaderViewBlock)block;

@property (nonatomic, strong) BusinessTaoxiModel *taoxiModel;
@end

NS_ASSUME_NONNULL_END
