//
//  FMVideoPlayModel.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/8/30.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <Foundation/Foundation.h>

@class VideoPlayModel,VideoPlayDataModel;
@interface FMVideoPlayModel : NSObject
/// 状态 success/failed
@property (nonatomic, copy) NSString *status;
/// 错误码
@property (nonatomic, assign) NSInteger errcode;
///     "sid": "got8at6g7t6v2o0mlbsq1lvp71"
@property (nonatomic, copy) NSString *sid;
/// 文字提示
@property (nonatomic, copy) NSString *message;
/// 套餐列表数据
@property (nonatomic, strong) VideoPlayDataModel *data;
@end


@interface VideoPlayDataModel : NSObject

@property (nonatomic, strong) NSMutableArray<VideoPlayModel *> *video_list;

@end

@interface VideoPlayModel : NSObject
/// 当前ID
@property (nonatomic, copy) NSString *kid;
/// 标题
@property (nonatomic, copy) NSString *title;
/// 商家ID
@property (nonatomic, copy) NSString *cp_id;
/// 站点ID
@property (nonatomic, copy) NSString *site_id;
/// 信息类别
@property (nonatomic, copy) NSString *shape;
/// 图片数量
@property (nonatomic, copy) NSString *thumb_num;
/// 封面1
@property (nonatomic, copy) NSString *thumb1;
@property (nonatomic, copy) NSString *thumb2;
@property (nonatomic, copy) NSString *thumb3;
/// 图集数量
@property (nonatomic, copy) NSString *gallery_num;
/// 评论适量
@property (nonatomic, copy) NSString *comment_num;
/// 收藏数量
@property (nonatomic, copy) NSString *collect_num;
/// 视频URL
@property (nonatomic, copy) NSString *videoUrl;
/// 是否收藏了
@property (nonatomic, copy) NSString *is_collect;
/// 是否关注了
@property (nonatomic, copy) NSString *is_follow;
/// 商家logo
@property (nonatomic, copy) NSString *cp_logo;
/// 商家名称
@property (nonatomic, copy) NSString *cp_fullname;
@end
