//
//  MineTableHeaderView.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/4.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^FMMineTableHeaderViewBlock) (void);

@interface FMMineTableHeaderView : UIView
-(void)setMineTableHeadViewBlock:(FMMineTableHeaderViewBlock)block;
@property (strong, nonatomic) UIImageView   *imagesViewBg;
@property (strong, nonatomic) FLAnimatedImageView   *imagesView;
@property (strong, nonatomic) UILabel       *nickNameLabel;
@property (strong, nonatomic) UIButton      *personDataBtn;
@property (strong, nonatomic) UIImageView   *iconImageView;
@property (strong, nonatomic) UIButton   *avatarButton;

@end
