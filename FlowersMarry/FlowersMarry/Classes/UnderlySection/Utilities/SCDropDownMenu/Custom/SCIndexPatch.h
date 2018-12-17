//
//  SCIndexPatch.h
//  SCDropDownMenu
//
//  Created by 宁小陌 on 2018/5/16.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SCIndexPatch : NSObject
/// 菜单index
@property (assign, nonatomic)NSInteger column;
/// 一级菜单index
@property (assign, nonatomic)NSInteger section;
/// 二级菜单index，默认-1
@property (assign, nonatomic)NSInteger row;

@property (assign, nonatomic)BOOL hasRow;
//row不存在传nil
- (instancetype)initWithColumn:(NSInteger)column section:(NSInteger)section row:(NSInteger)row;

@end
