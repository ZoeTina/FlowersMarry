//
//  TTImageLabel.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/10/17.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TTImageLabel : UIView

@property (strong, nonatomic, readonly) UILabel *textLabel;
@property (strong, nonatomic, readonly) UIImageView *imageView;
@property (assign, nonatomic) CGFloat space;

@end

NS_ASSUME_NONNULL_END
