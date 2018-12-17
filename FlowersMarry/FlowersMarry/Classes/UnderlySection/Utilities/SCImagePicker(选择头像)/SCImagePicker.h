//
//  SCImagePicker.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/8/1.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SCImagePicker : NSObject

/// 是否允许编辑
@property (nonatomic, assign) BOOL isEditor;
- (void)sc_pickWithTarget:(UIViewController*)controller completionHandler:(void(^)(UIImage *image,NSString *url))completion;
@end
