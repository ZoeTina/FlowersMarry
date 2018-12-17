//
//  FMShowPhotoCollectionFooterView.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/18.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <UIKit/UIKit.h>

//这里要定义一个block的别名(申明) 类型 ----> void (^) (NSString *text)
typedef void(^ShowPhotoCollectionFooterBlock) (NSInteger idx);

@interface FMShowPhotoCollectionFooterView : UIView
//定义一个block
@property (nonatomic, copy) ShowPhotoCollectionFooterBlock footerBlock;


/// 顶部分割线
@property (nonatomic, strong) UIView *linerView;
/// 显示当前页
@property (nonatomic, strong) UILabel *currentIndexLabel;
/// 副标题(内容标签)
@property (nonatomic, strong) UILabel *subtitleLabel;
/// 评论按钮
@property (nonatomic, strong) UIButton *commentsButton;
/// 点赞按钮
@property (nonatomic, strong) UIButton *likeButton;
/// 客服按钮
@property (nonatomic, strong) UIButton *kefuButton;
/// 预约按钮
@property (nonatomic, strong) UIButton *subscribeButton;
@end
