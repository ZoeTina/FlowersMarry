//
//  SCActivityIndicatorView.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/8/6.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "SCActivityIndicatorView.h"

static SCActivityIndicatorView *_activityView = nil;
@implementation SCActivityIndicatorView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+ (SCActivityIndicatorView *)shareActivityView{
    if (!_activityView) {
        _activityView = [[SCActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    }
    return _activityView;
}

@end
