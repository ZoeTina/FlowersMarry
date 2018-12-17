//
//  FMChooseMusicViewController.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/11/7.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "TTBaseToolsViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef void(^SelectedMusicBlock) (NSString *chooseContent,NSString *muiscID);
@interface FMChooseMusicViewController : TTBaseToolsViewController
@property(nonatomic, copy) SelectedMusicBlock block;
/// 已选中的音乐
@property(nonatomic, copy) NSString *selectMusicStr;

@end

NS_ASSUME_NONNULL_END
