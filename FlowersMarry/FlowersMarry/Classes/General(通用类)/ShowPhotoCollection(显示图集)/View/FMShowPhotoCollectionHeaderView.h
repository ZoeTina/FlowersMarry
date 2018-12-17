//
//  FMShowPhotoCollectionHeaderView.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/18.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <UIKit/UIKit.h>

//这里要定义一个block的别名(申明) 类型 ----> void (^) (NSString *text)
typedef void(^ShowPhotoCollectionHeaderBlock) (NSInteger idx);

@interface FMShowPhotoCollectionHeaderView : UIView
//定义一个block
@property (nonatomic, copy) ShowPhotoCollectionHeaderBlock headerBlock;


@property (nonatomic, strong) UIImageView *avatarImage;
@property (nonatomic, strong) UIButton *avatarButton;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *focusButton;
@property (nonatomic, strong) UIButton *leftButton;
@end
