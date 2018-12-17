//
//  SCShareTools.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/25.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SCShareModel.h"

typedef void(^ShareResultStrBlock)(NSString *shareResultStr);

@interface SCShareTools : NSObject


/**
 第三方分享
 
 @param platform 分享平台
 @param shareModel 分享model
 @param resultBlock 分享结果，只有一个作为提示信息的字符串
 */
+ (void)shareWithPlatformType:(SSDKPlatformType)platform PVDemandVideoDetailModel:(SCShareModel *)shareModel shareresult:(ShareResultStrBlock)resultBlock;


@end
