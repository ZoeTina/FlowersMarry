//
//  UIView+SCLoadingView.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/8/6.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "UIView+SCLoadingView.h"
#import "SCActivityIndicatorView.h"
#import "SCLoadingLabel.h"

@implementation UIView (SCLoadingView)

-(void)initActivitytitle:(NSString *)title{
    
    SCActivityIndicatorView *activityView = [SCActivityIndicatorView shareActivityView];
    [activityView startAnimating];
    [self addSubview:activityView];
    [activityView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self.mas_centerY).offset(-11);
    }];
    
    SCLoadingLabel *loadingLabel = [SCLoadingLabel shareLoadingLabel];
    loadingLabel.text = title;
    loadingLabel.hidden = NO;
    [self addSubview:loadingLabel];
    [loadingLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self.mas_centerY).offset(11);
    }];
}


-(void)showLoadingViewWithText:(NSString *)text{
    self.backgroundColor = [UIColor clearColor];
    [self initActivitytitle:text];
}
-(void)dismissLoadingView{
    [self stopAnimating];
}

-(void)stopAnimating{
    [SCLoadingLabel shareLoadingLabel].hidden = YES;
    [[SCActivityIndicatorView shareActivityView] stopAnimating];
    [SCLoadingLabel shareLoadingLabel].text = nil;
}

@end
