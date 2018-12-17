//
//  FMTongxunluModel.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/10.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FMTongxunluModel : NSObject

@property (strong, nonatomic) NSString     *name;
@property (strong, nonatomic) NSString     *phone;
@property (nonatomic, assign) NSInteger     state;
@property (assign, nonatomic) NSInteger     index;

+ (NSMutableArray *)getModelData;

@end
