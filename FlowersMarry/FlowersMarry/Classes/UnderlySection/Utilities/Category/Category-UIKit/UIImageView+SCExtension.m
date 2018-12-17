//
//  UIImageView+SCExtension.m
//  LZExtension
//
//  Created by 寕小陌 on 2016/12/9.
//  Copyright © 2016年 寕小陌. All rights reserved.
//

#import "UIImageView+SCExtension.h"
#import "UIImageView+WebCache.h"

@implementation UIImageView (SCExtension)

- (void)sc_setImageWithUrlString:(NSString *)URLString placeholderImage:(UIImage *)placeholderImage isAvatar:(BOOL)isAvatar{
    
    if (isAvatar) {
        placeholderImage = [placeholderImage sc_avatarImage:self.bounds.size backColor:[UIColor whiteColor] borderColor:[UIColor whiteColor]];
    }
    // 处理Url
    if (URLString.length < 1) {
        self.image = placeholderImage;
        return;
    }else{
        URLString = [kNetworkProtocol stringByAppendingString:URLString];
    }
    __weak typeof(self) weakSelf = self;
    SDWebImageOptions imageOption = SDWebImageLowPriority;
    if (isAvatar) {
        imageOption = SDWebImageRetryFailed;
    }
    TTLog(@"kNetworkProtocol === %@",URLString);
    [self sd_setImageWithURL:[NSURL URLWithString:[URLString sc_urlString]] placeholderImage:placeholderImage options:imageOption completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (image == nil) {
            weakSelf.image = placeholderImage;
            return;
        }
        // 设置头像
        if (isAvatar) {
            if (!image) {
                weakSelf.image = placeholderImage;
            } else {
                weakSelf.image = [image sc_avatarImage:self.bounds.size backColor:[UIColor whiteColor] borderColor:[UIColor whiteColor]];
            }
        }
    }];
}

@end
