//
//  SCPublishCommentsViewController.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/8/9.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "MVBaseViewController.h"
#import "FMBusinessModel.h"

@interface SCPublishCommentsViewController : MVBaseViewController

- (id)initBusinessModel:(BusinessModel *)businessModel;
@property (nonatomic, strong) UICollectionView *collectionView;

@end

