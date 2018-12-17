//
//  FMConventionViewController.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/8/28.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "MVBaseViewController.h"
#import "FMBusinessModel.h"

@protocol FMPopupViewDelegate;
@interface FMConventionViewController : UIViewController

@property (assign, nonatomic) id <FMPopupViewDelegate>delegate;
- (id)initYouHuiModelData:(BusinessYouHuiModel *)youhuiModel;

@end


@protocol FMPopupViewDelegate<NSObject>
@optional
//- (void)cancelButtonClicked:(FMConventionViewController *)secondViewController;
- (void)dismissedButtonClicked:(FMConventionViewController *)secondViewController;
@end
