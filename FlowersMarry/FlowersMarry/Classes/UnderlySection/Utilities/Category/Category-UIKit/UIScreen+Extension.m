//
//  UIScreen+Extension.m
//  LZExtension
//
//  Created by 寕小陌 on 2016/12/12.
//  Copyright © 2016年 寕小陌. All rights reserved.
//

#import "UIScreen+Extension.h"

@implementation UIScreen (Extension)

+ (CGSize)lz_screenSize {
    return [UIScreen mainScreen].bounds.size;
}

+ (BOOL)lz_isRetina {
    return [UIScreen lz_scale] >= 2;
}

+ (CGFloat)lz_scale {
    return [UIScreen mainScreen].scale;
}

+ (BOOL)lzs_isRetina {
    if ([[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)] && (self.lz_scale == 2.0 || self.lz_scale == 3.0)) {
        return YES;
    } else {
        return NO;
    }
}

+ (BOOL)lz_isRetinaHD {
    if ([[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)] && (self.lz_scale == 3.0)) {
        return YES;
    } else {
        return NO;
    }
}

+ (CGFloat)lz_brightness {
    return [UIScreen mainScreen].brightness;
}

+ (void)lz_setBrightness:(CGFloat)brightness {
    [[UIScreen mainScreen] setBrightness:brightness];
}
@end
