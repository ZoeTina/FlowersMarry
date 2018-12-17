//
//  FMMarriedBooksHeaderView.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/9/28.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void (^FMToolsMarriedBooksHeaderViewBlock) (void);

@interface FMMarriedBooksHeaderView : UIView
-(void)setToolsBooksTableHeadViewBlock:(FMToolsMarriedBooksHeaderViewBlock)block;
@property (strong, nonatomic) UILabel       *titleLabel;
@property (strong, nonatomic) UILabel       *tipsLabel;
@property (strong, nonatomic) UILabel       *priceLabel;
@property (strong, nonatomic) UIButton      *rememberButton;

@end

NS_ASSUME_NONNULL_END
