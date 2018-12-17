//
//  IMessagesFaceModel.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/9/11.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FaceThemeModel.h"
@interface IMessagesFaceModel : NSObject
/// 加载表情数据
+ (NSArray *)loadFaceArray;
@end
