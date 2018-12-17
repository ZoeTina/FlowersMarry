//
//  TTTemplateModel.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/12/11.
//  Copyright © 2018 宁小陌. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TTTemplateModel : NSObject
@property(nonatomic, copy)NSString* title;
@property(nonatomic, copy)NSString* subtitle;
@property(nonatomic, copy)NSString* content;
@property(nonatomic, copy)NSString* imageText;
@property(nonatomic, copy)NSString* showClass;
@property(nonatomic, assign)NSInteger index;
@end

NS_ASSUME_NONNULL_END
