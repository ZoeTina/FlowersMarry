//
//  TTBusinessTableViewCell.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/12/12.
//  Copyright © 2018 宁小陌. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TTBusinessTableViewCell : UITableViewCell
/// 图片
@property (nonatomic, strong) UIImageView *imagesView;
/// 标题
@property (nonatomic, strong) UILabel *titleLabel;
/// 评论条数
@property (nonatomic, strong) UILabel *commentCountLabel;
/// 人气
@property (nonatomic, strong) UILabel *renqiLabel;
/// 地区
@property (nonatomic, strong) UILabel *regionLabel;
/// 工作室
@property (nonatomic, strong) UILabel *studioLabel;
/// 图片(推荐)
@property (nonatomic, strong) UIImageView *imagesViewRecommend;

/// 礼物区域
@property (nonatomic, strong) UIView *giftView;
/// 图片(礼物)
@property (nonatomic, strong) UIImageView *imagesViewGifts;
/// 送礼类容
@property (nonatomic, strong) UILabel *giftContentLabel;

/// 礼物区域
@property (nonatomic, strong) UIView *activityView;
/// 活动分割线
@property (nonatomic, strong) UIView *linerView;
/// 活动标签
@property (nonatomic, strong) UIImageView *imagesViewActivity;
/// 活动内容
@property (nonatomic, strong) UILabel *activityContentLabel;

/// 保
@property (nonatomic, strong) UIImageView *imagesViewBao;
/// 个人或者企业
@property (nonatomic, strong) UIImageView *imagesViewGe;
/// 个人或者企业
@property (nonatomic, strong) UIImageView *imagesViewGes;



@property (nonatomic, strong) BusinessModel *businessModel;

@end

NS_ASSUME_NONNULL_END
