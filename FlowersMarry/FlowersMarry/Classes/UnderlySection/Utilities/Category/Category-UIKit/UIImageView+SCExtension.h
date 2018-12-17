//
//  UIImageView+SCExtension.h
//  LZExtension
//
//  Created by 寕小陌 on 2016/12/9.
//  Copyright © 2016年 寕小陌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (SCExtension)
- (void)sc_setImageWithUrlString:(NSString *)URLString placeholderImage:(UIImage *)placeholderImage isAvatar:(BOOL)isAvatar;
@end
