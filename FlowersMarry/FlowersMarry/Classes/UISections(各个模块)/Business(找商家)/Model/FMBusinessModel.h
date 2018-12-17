//
//  FMBusinessModel.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/6/27.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BusinessDataModel,BusinessModel,BusinessAuthModel,BusinessYouHuiModel,BusinessCasesModel,BusinessCasesPhotoModel,
BusinessYouHuiGiftModel,BusinessYouHuiCouponModel,BusinessComment,BusinessHuodongModel,BusinessTaoxiModel,BusinessCasesStyleModel,
BusinessStaffInfoModel,BusinessTaoxiMetaModel,BusinessTaoxiMetaChildrenModel,BusinessMetaNavModel;
@interface FMBusinessModel : NSObject

/// 状态 success/failed
@property (nonatomic, copy) NSString *status;
/// 错误码
@property (nonatomic, assign) NSInteger errcode;
///     "sid": "got8at6g7t6v2o0mlbsq1lvp71"
@property (nonatomic, copy) NSString *sid;
/// 文字提示
@property (nonatomic, copy) NSString *message;

@property (nonatomic, strong) BusinessDataModel *data;

@end

@interface BusinessDataModel : NSObject
/// 数据总量
@property (nonatomic, assign) NSInteger count;
/// 数据列表
@property (nonatomic, strong) NSMutableArray<BusinessModel *> *list;
@property (nonatomic, strong) NSMutableArray<BusinessModel *> *recommend;

@end

@interface BusinessModel : NSObject

/// 商家编号
@property (nonatomic, copy) NSString *cp_id;
/// 商家全称
@property (nonatomic, copy) NSString *cp_fullname;
/// 商家简称
@property (nonatomic, copy) NSString *cp_shortname;
/// 大分类ID(1:婚纱 2:婚庆 3:婚宴)
@property (nonatomic, copy) NSString *channel_id;
/// 小分类ID
@property (nonatomic, copy) NSString *class_id;
/// 所在的区编号
@property (nonatomic, copy) NSString *qu_id;
/// 站点ID
@property (nonatomic, copy) NSString *site_id;
/// 详细地址
@property (nonatomic, copy) NSString *cp_address;
/// 电话号码
@property (nonatomic, copy) NSString *cp_telephone;
/// 商家域名
@property (nonatomic, copy) NSString *cp_domain;
/// 商铺logo
@property (nonatomic, copy) NSString *cp_logo;
/// 商家是否为vip
@property (nonatomic, copy) NSString *cp_isavip;
/// 商家是否为vip
@property (nonatomic, copy) NSString *cp_isfvip;
/// 商铺分数
@property (nonatomic, assign) CGFloat cp_rank;
///
@property (nonatomic, copy) NSString *cp_interal;
/// 商铺点击量
@property (nonatomic, copy) NSString *cp_hits;
/// 商铺热度
@property (nonatomic, copy) NSString *cp_hot;
/// 活动总量
@property (nonatomic, copy) NSString *cp_huodong_count;
/// 作品总量
@property (nonatomic, copy) NSString *cp_case_count;
/// 点评总量
@property (nonatomic, copy) NSString *cp_comment_count;
/// 套餐总量
@property (nonatomic, copy) NSString *cp_taoxi_count;
/// 地区名称
@property (nonatomic, copy) NSString *qu_name;
/// 标签名称
@property (nonatomic, copy) NSString *class_name;
/// PC站地址
@property (nonatomic, copy) NSString *link;
/// 3G站地址
@property (nonatomic, copy) NSString *mlink;
/// 是否婚纱商家
@property (nonatomic, assign) NSInteger ishs;
/// 是否婚庆商家
@property (nonatomic, assign) NSInteger ishq;
/// 是否婚宴商家
@property (nonatomic, assign) NSInteger ishy;
/// 站点名称
@property (nonatomic, copy) NSString *site_name;
/// 优惠项目数量
@property (nonatomic, assign) NSInteger youhui_num;
/// 活动(列表)
@property (nonatomic, strong) BusinessHuodongModel *huodong;

/// 认证(1=是 0=否)
@property (nonatomic, strong) BusinessAuthModel *auth;
/// 优惠信息
@property (nonatomic, strong) BusinessYouHuiModel *youhui;
/// 作品 婚纱和婚庆有
@property (nonatomic, strong) NSMutableArray<BusinessCasesModel *> *cases;


/////////// -------- end 以上是列表需要使用的 end -------- ///////////
/// 渠道名称（我关注的商家）
@property (nonatomic, copy) NSString *channel_name;
/////////// -------- end 以上是列表需要使用的 end -------- ///////////


/// 商家营业时间
@property (nonatomic, copy) NSString *cp_worktime;
/// 商家QQ
@property (nonatomic, copy) NSString *cp_qq;
/// 商家网站
@property (nonatomic, copy) NSString *cp_site;
/// 商铺百度地图坐标
@property (nonatomic, copy) NSString *cp_baidumap;
///
@property (nonatomic, copy) NSString *cp_jiaotong;
/// 关注数量
@property (nonatomic, copy) NSString *fllow_num;
/// 商家信息内容
@property (nonatomic, copy) NSString *cp_content;
/// 商铺400电话
@property (nonatomic, copy) NSString *tel400;
/// 消保标签
@property (nonatomic, strong) NSMutableArray *xblist;
/// 是否关注
@property (nonatomic, copy) NSString *is_follow;
/// 评论
@property (nonatomic, strong) NSMutableArray<BusinessComment *> *comments;
/// 活动(商家首页)
@property (nonatomic, strong) NSMutableArray<BusinessHuodongModel *> *huodongs;
/// 套餐 仅婚庆有
@property (nonatomic, strong) NSMutableArray<BusinessTaoxiModel *> *taoxis;
/// 实景 仅婚宴有
@property (nonatomic, strong) NSMutableArray<BusinessCasesPhotoModel *> *shijing;

@end

@interface BusinessAuthModel : NSObject

/// 企业认证(1:是, 0:否)
@property (nonatomic, assign) NSInteger qy;
/// 个体认证(1:是, 0:否)
@property (nonatomic, assign) NSInteger gt;
/// 消保认证(1:是, 0:否)
@property (nonatomic, assign) NSInteger xb;
/// 广告商家(1:是, 0:否) 会员
@property (nonatomic, assign) NSInteger isavip;

@end

/// 作品 婚纱和婚庆有
@interface BusinessCasesModel : NSObject
/// 作品编号
@property (nonatomic, copy) NSString *case_id;
/// 作品标题
@property (nonatomic, copy) NSString *case_title;
/// 封面图
@property (nonatomic, copy) NSString *case_thumb;
/// 图片数量
@property (nonatomic, copy) NSString *case_filenum;
/// 作品点击量
@property (nonatomic, copy) NSString *case_hits;
/// 作品点赞量
@property (nonatomic, copy) NSString *case_like;
/// 作品发布时间
@property (nonatomic, copy) NSString *case_create_time;
/// 作品地点
@property (nonatomic, copy) NSString *case_location;
/// 作品分类
@property (nonatomic, copy) NSString *kind_name;
/// 作品地点
@property (nonatomic, copy) NSString *place_name;
/// 套餐发布时间(处理后的)
@property (nonatomic, copy) NSString *create_at;
/// 作品PC站链接
@property (nonatomic, copy) NSString *link;
/// 作品手机站链接
@property (nonatomic, copy) NSString *mlink;
/// 相关套餐编号
@property (nonatomic, assign) NSInteger tx_id;
/// 相关套餐价格
@property (nonatomic, assign) NSInteger tx_price;
/// 相关套餐市场价
@property (nonatomic, assign) NSInteger tx_first_price;
/// 作品图片集
@property (nonatomic, strong) NSMutableArray<BusinessCasesPhotoModel *> *photo;
/// 风格
@property (nonatomic, strong) NSMutableArray<BusinessCasesStyleModel *> *case_fg;

/// -----  作品详情需要的属性 ----- ///
/// 商家ID
@property (nonatomic, copy) NSString *cp_id;
/// 作品类型ID
@property (nonatomic, copy) NSString *case_type_id;
/// 套餐ID
@property (nonatomic, copy) NSString *case_tx_id;
@property (nonatomic, copy) NSString *place_id;
@property (nonatomic, copy) NSString *case_fg_ids;
@property (nonatomic, copy) NSString *case_kind;
@property (nonatomic, copy) NSString *case_content;
@property (nonatomic, copy) NSString *type_name;
@property (nonatomic, copy) NSString *cp_logo;
@property (nonatomic, copy) NSString *cp_fullname;
@property (nonatomic, copy) NSString *cp_shortname;
@property (nonatomic, copy) NSString *qu_name;
@property (nonatomic, copy) NSString *is_follow;
@property (nonatomic, copy) NSString *channel_id;
@property (nonatomic, copy) NSString *channel_name;
/// 认证(1=是 0=否)
@property (nonatomic, strong) BusinessAuthModel *auth;
/// 套餐 仅婚庆有
@property (nonatomic, strong) BusinessTaoxiModel *taoxi;
@property (nonatomic, strong) NSMutableArray<BusinessCasesModel *> *caselist;
/// 优惠信息
@property (nonatomic, strong) BusinessYouHuiModel *youhui;
@property (nonatomic, strong) NSMutableArray<BusinessStaffInfoModel *> *case_sys;
@property (nonatomic, strong) NSMutableArray<BusinessStaffInfoModel *> *case_zxs;
@property (nonatomic, strong) NSMutableArray<BusinessStaffInfoModel *> *case_hq;

@end

@interface BusinessYouHuiModel : NSObject
/// 预约有礼
@property (nonatomic, strong) BusinessYouHuiGiftModel *gift;
/// 优惠券
@property (nonatomic, strong) BusinessYouHuiCouponModel *coupon;
@end

@interface BusinessYouHuiGiftModel : NSObject
@property (nonatomic, assign) NSInteger kid;
@property (nonatomic, strong) NSString *title;
@end

@interface BusinessYouHuiCouponModel : NSObject
/// 优惠券编号
@property (nonatomic, assign) NSInteger kid;
/// 优惠券标题
@property (nonatomic, strong) NSString *title;
/// 优惠券图片
@property (nonatomic, strong) NSString *thumb;
/// 优惠券开始日期
@property (nonatomic, strong) NSString *start_date;
/// 优惠券结束日期
@property (nonatomic, strong) NSString *end_date;
/// 优惠券总数量
@property (nonatomic, assign) NSInteger num;
/// 优惠券已经发送数量
@property (nonatomic, assign) NSInteger send_num;

@end

@interface BusinessCasesPhotoModel : NSObject
/// 图片编号
@property (nonatomic, copy) NSString *kid;
/// 图片标题
@property (nonatomic, copy) NSString *p_filetitle;
/// 图片路径
@property (nonatomic, copy) NSString *p_filename;

@end

@interface BusinessComment : NSObject
/// 评论ID
@property (nonatomic, copy) NSString *ct_id;
/// 评论等级
@property (nonatomic, copy) NSString *ct_level;
/// 评论人昵称
@property (nonatomic, copy) NSString *user_name;
/// 评论回复时间
@property (nonatomic, copy) NSString *ct_re_time;
/// 是否有回复
@property (nonatomic, copy) NSString *ct_isreply;
/// 评论时间
@property (nonatomic, copy) NSString *ct_add_time;
/// 评论图片的数量
@property (nonatomic, copy) NSString *ct_photonum;
/// 评论回复时间处理后的
@property (nonatomic, copy) NSString *reply_at;
/// 评论时间处理后的
@property (nonatomic, copy) NSString *create_at;
/// 评论内容
@property (nonatomic, copy) NSString *ct_content;
/// 评论回复的内容
@property (nonatomic, copy) NSString *ct_re_content;
/// 评论人的头像
@property (nonatomic, copy) NSString *avatar;
/// 评论图片集
@property (nonatomic, strong) NSMutableArray<BusinessCasesPhotoModel *> *photo;

@end

@interface BusinessHuodongModel : NSObject
/// 活动编号
@property (nonatomic, copy) NSString *hd_id;
/// 活动标题
@property (nonatomic, copy) NSString *hd_title;
/// 活动开始时间
@property (nonatomic, copy) NSString *hd_start_time;
/// 活动结束时间
@property (nonatomic, copy) NSString *hd_end_time;
/// 活动点击量
@property (nonatomic, copy) NSString *hd_hits;
/// 是否最新活动
@property (nonatomic, copy) NSString *islast;
/// 是否推荐活动
@property (nonatomic, copy) NSString *is_recommand;
/// 拍摄地编号
@property (nonatomic, copy) NSString *place_id;
/// 创建时间
@property (nonatomic, copy) NSString *hd_create_time;
/// 活动类型
@property (nonatomic, copy) NSString *hd_type;
/// 活动缩略图
@property (nonatomic, copy) NSString *hd_thumb;
/// 活动描述
@property (nonatomic, copy) NSString *hd_description;
/// 活动内容
@property (nonatomic, copy) NSString *hd_content;
/// 类型文本
@property (nonatomic, copy) NSString *type_text;
/// 拍摄地名称
@property (nonatomic, copy) NSString *place_name;
/// 创建时间
@property (nonatomic, copy) NSString *create_at;


/// 创建时间
@property (nonatomic, copy) NSString *cp_id;
@property (nonatomic, copy) NSString *cp_logo;
@property (nonatomic, copy) NSString *cp_fullname;
@property (nonatomic, copy) NSString *cp_shortname;
@property (nonatomic, copy) NSString *qu_name;
/// 是否关注了当前商家(0:未关注 1:已关注)
@property (nonatomic, assign) NSInteger is_follow;
@property (nonatomic, copy) NSString *channel_id;
@property (nonatomic, copy) NSString *channel_name;

/// 认证(1=是 0=否)
@property (nonatomic, strong) BusinessAuthModel *auth;
@end


@interface BusinessTaoxiModel : NSObject
/// 套餐编号
@property (nonatomic, copy) NSString *tx_id;
/// 套餐标题
@property (nonatomic, copy) NSString *tx_title;
/// 套餐副标题
@property (nonatomic, copy) NSString *tx_subtitle;
/// 套餐点击量
@property (nonatomic, copy) NSString *tx_hits;
/// 套餐缩略图
@property (nonatomic, copy) NSString *tx_thumb;
/// 套餐价格
@property (nonatomic, copy) NSString *tx_price;
/// 套餐市场价
@property (nonatomic, copy) NSString *tx_first_price;
/// 套餐下组图数量
@property (nonatomic, copy) NSString *tx_filenum;
/// 套餐发布时间
@property (nonatomic, copy) NSString *tx_add_time;
/// 套餐发布时间(处理后的)
@property (nonatomic, copy) NSString *create_at;
/// 区域名字
@property (nonatomic, copy) NSString *place_name;
/// 套餐PC站链接
@property (nonatomic, copy) NSString *link;
/// 套餐手机站链接
@property (nonatomic, copy) NSString *mlink;

///-------  套餐列表使用需要 -------///
/// 评论图片集
@property (nonatomic, strong) NSMutableArray<BusinessCasesPhotoModel *> *photo;
/// 套餐手机站链接
@property (nonatomic, copy) NSString *cp_id;
/// 套餐手机站链接
@property (nonatomic, copy) NSString *place_id;
/// 属性   婚纱影楼 摄影工作室 儿童摄影 婚礼策划 婚纱礼服 有属性
@property (nonatomic, strong) NSMutableArray<BusinessTaoxiMetaModel *> *meta;/// 套餐手机站链接
/// 商铺logo
@property (nonatomic, copy) NSString *cp_logo;
/// 商家全称
@property (nonatomic, copy) NSString *cp_fullname;
/// 商家简称
@property (nonatomic, copy) NSString *cp_shortname;
/// 地区名称
@property (nonatomic, copy) NSString *qu_name;
/// 是否关注
@property (nonatomic, copy) NSString *is_follow;
/// 大分类ID(1:婚纱 2:婚庆 3:婚宴)
@property (nonatomic, copy) NSString *channel_id;
/// 大分类ID(1:婚纱 2:婚庆 3:婚宴)
@property (nonatomic, copy) NSString *class_id;
/// 渠道名称（我关注的商家）
@property (nonatomic, copy) NSString *channel_name;
/// 认证(1=是 0=否)
@property (nonatomic, strong) BusinessAuthModel *auth;
/// 推荐套餐数据
@property (nonatomic, strong) NSMutableArray<BusinessTaoxiModel *> *txlist;/// 套餐手机站链接
/// 优惠信息
@property (nonatomic, strong) BusinessYouHuiModel *youhui;
@property (nonatomic, strong) BusinessMetaNavModel *meta_nav;

@end


@interface BusinessCasesStyleModel : NSObject

/// 风格ID
@property (nonatomic, copy) NSString *fg_id;
/// 风格名称
@property (nonatomic, copy) NSString *fg_name;

@end


@interface BusinessStaffInfoModel : NSObject
/// 工作人员ID
@property (nonatomic, copy) NSString *kid;
/// 工作人员名称
@property (nonatomic, copy) NSString *name;
@end

/// (仅仅套餐列表使用)
@interface BusinessTaoxiDataModel : NSObject
/// 套餐 仅婚庆有
/// 数据总量
@property (nonatomic, assign) NSInteger count;
/// 数据列表
@property (nonatomic, strong) NSMutableArray<BusinessTaoxiModel *> *list;
@end

/// (仅仅作品列表使用)
@interface BusinessCaseDataModel : NSObject
/// 数据总量
@property (nonatomic, assign) NSInteger count;
/// 数据列表
@property (nonatomic, strong) NSMutableArray<BusinessCasesModel *> *list;
@end


@interface BusinessTaoxiMetaModel : NSObject
/// 标题
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSMutableArray<BusinessTaoxiMetaChildrenModel *> *child;

@end

@interface BusinessTaoxiMetaChildrenModel : NSObject
/// 标题
@property (nonatomic, copy) NSString *title;
/// 副标题
@property (nonatomic, copy) NSString *value;
/// 单位
@property (nonatomic, copy) NSString *unit;
@end


@interface BusinessCasesListDataModel : NSObject
/// 数据总量
@property (nonatomic, assign) NSInteger count;
/// 数据列表
@property (nonatomic, strong) NSMutableArray<BusinessCasesModel *> *list;
@end


@interface BusinessMetaNavModel : NSObject
/// 造型数量
@property (nonatomic, copy) NSString *zx_num;
/// 拍摄张数
@property (nonatomic, copy) NSString *ps_rupan;
/// 精修张数
@property (nonatomic, copy) NSString *ps_jxzs;
/// 相册数量
@property (nonatomic, copy) NSString *cp_xcnum;

@end
