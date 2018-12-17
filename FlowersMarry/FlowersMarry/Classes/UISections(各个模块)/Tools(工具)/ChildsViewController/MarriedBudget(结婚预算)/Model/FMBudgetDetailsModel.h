//
//  FMBudgetDetailsModel.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/10/11.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FMBudgetDetailsModel : NSObject
@property(nonatomic, copy)NSString* title;
@property(nonatomic, copy)NSString* imageText;
@property(nonatomic, assign) BOOL     isSelected;

@end

NS_ASSUME_NONNULL_END
