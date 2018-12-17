//
//  FMPointAnnotation.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/11/9.
//  Copyright © 2018 宁小陌. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class FMPoi;
@interface FMPointAnnotation : BMKPointAnnotation

/** poi*/
@property (nonatomic, strong) FMPoi *poi;
/** 标注点的protocol，提供了标注类的基本信息函数*/
@property (nonatomic, weak) id<BMKAnnotation> delegate;

@end

NS_ASSUME_NONNULL_END
