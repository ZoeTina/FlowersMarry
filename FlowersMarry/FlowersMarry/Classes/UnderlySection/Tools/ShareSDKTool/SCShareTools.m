//
//  SCShareTools.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/25.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "SCShareTools.h"

@implementation SCShareTools

+ (void)shareWithPlatformType:(SSDKPlatformType)platform PVDemandVideoDetailModel:(SCShareModel *)shareModel shareresult:(ShareResultStrBlock)resultBlock {
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    
    if (platform == SSDKPlatformTypeSinaWeibo) {
        [shareParams SSDKSetupShareParamsByText:[NSString stringWithFormat:@"%@ %@",shareModel.sharetitle,shareModel.h5Url]
                                         images:[UIImage imageNamed:@"AppIcon"]
                                            url:[NSURL URLWithString:shareModel.h5Url]
                                          title:shareModel.sharetitle
                                           type:SSDKContentTypeAuto];
        [self shareWithPlatformType:SSDKPlatformTypeSinaWeibo parameter:shareParams shareresult:resultBlock];
    }else {
        if ([ShareSDK isClientInstalled:platform]) {
            [shareParams SSDKSetupShareParamsByText:shareModel.sharetitle
                                             images:[UIImage imageNamed:@"AppIcon"]
                                                url:[NSURL URLWithString:shareModel.h5Url]
                                              title:shareModel.sharetitle
                                               type:SSDKContentTypeAuto];
            [self shareWithPlatformType:platform parameter:shareParams shareresult:resultBlock];
        }else {
            NSString *str = [self getTipsWithPlatformType:platform];
            resultBlock(str);
        }
    }
}

+ (void)shareWithPlatformType:(SSDKPlatformType)platform parameter:(NSMutableDictionary *)shareParameter shareresult:(ShareResultStrBlock)resultBlock {
    [ShareSDK share:platform parameters:shareParameter onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
        switch (state) {
            case SSDKResponseStateSuccess:
                resultBlock(@"分享成功");
                break;
            case SSDKResponseStateFail:
                resultBlock(@"分享失败");
                break;
            case SSDKResponseStateCancel:
                resultBlock(@"分享已取消");
                break;
            default:
                break;
        }
    }];
}

+ (NSString *)getTipsWithPlatformType:(SSDKPlatformType)platform {
    
    NSString *str;
    
    switch (platform) {
        case SSDKPlatformSubTypeQQFriend:{
            str = @"请下载QQ应用程序进行分享";
            break;
        }
            
        case SSDKPlatformSubTypeQZone:{
            str = @"请下载QQ应用程序进行分享";
            break;
        }
            
        case SSDKPlatformSubTypeWechatSession:{
            str = @"请下载微信应用程序进行分享";
            break;
        }
            
        case SSDKPlatformSubTypeWechatTimeline:{
            str = @"请下载微信应用程序进行分享";
            break;
        }
            
        default:
            break;
    }
    return str;
}

@end
