//
//  FMToolsModel.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/6/27.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FMToolsModel : NSObject
/// 标题
@property(nonatomic, copy)NSString* title;
/// 内容
@property(nonatomic, copy)NSString* subtitle;
/// 图片
@property(nonatomic, copy)NSString* imageText;
/// 是否为开启按钮
@property(nonatomic, copy)NSString* showClass;

+ (NSMutableArray *)loadToolsDataArray;
@end
