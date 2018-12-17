//
//  FMHomePageHeaderView.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/21.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FMHomePageHeaderView : UIView
/// 搜索View
@property (nonatomic, strong) UIView *searchView;
/// 搜索小图标
@property (nonatomic, strong) UIImageView *searchImages;
/// 搜索文字提示
@property (nonatomic, strong) UILabel *searchLabel;
/// 城市名称
@property (nonatomic, strong) UILabel *cityLabel;
/// 小三角
@property (nonatomic, strong) UIImageView *imagesCity;


/// 外层View
@property (nonatomic, strong) UIView *containerView;
@end
