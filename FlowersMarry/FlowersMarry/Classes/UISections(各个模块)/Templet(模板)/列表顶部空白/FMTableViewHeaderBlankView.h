//
//  FMTableViewHeaderBlankView.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/16.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FMTableViewHeaderBlankView : UIView

/// 需要显示的图片
@property (nonatomic, strong) UIImageView *imagesView;
/// 文字提示
@property (nonatomic, strong) UILabel *titleLabel;
/// 猜一猜
@property (nonatomic, strong) UILabel *guessLabel;
/// 横线
@property (nonatomic, strong) UIView *lineLabel;
@end
