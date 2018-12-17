//
//  SCProgressView.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/10/12.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "SCProgressView.h"

@interface SCProgressView(){
    UIView *viewTop;
    UIView *viewBottom;
}

@end
@implementation SCProgressView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self buildUI];
    }
    return self;
}

- (void)buildUI {
    
    viewBottom = [[UIView alloc]initWithFrame:self.bounds];
    viewBottom.backgroundColor = [HexString(@"#FFECEF") colorWithAlphaComponent:0.25];
    viewBottom.layer.cornerRadius = 3;
    viewBottom.layer.masksToBounds = YES;
    [self addSubview:viewBottom];
    
    viewTop = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, viewBottom.frame.size.height)];
    viewTop.backgroundColor = kWhiteColor;
    viewTop.layer.cornerRadius = 3;
    viewTop.layer.masksToBounds = YES;
    [viewBottom addSubview:viewTop];
}


- (void)setTime:(float)time {
    _time = time;
}

-(void)setProgressValue:(CGFloat)progressValue {
    if (!_time) {
        _time = 1.0f;
    }
    _progressValue = progressValue;
    [UIView animateWithDuration:_time animations:^{
        self->viewTop.frame = CGRectMake(self->viewTop.x, self->viewTop.y, self->viewBottom.width*progressValue, self->viewTop.height);
    }];
}


-(void)setBottomColor:(UIColor *)bottomColor {
    _bottomColor = bottomColor;
    viewBottom.backgroundColor = bottomColor;
}

-(void)setProgressColor:(UIColor *)progressColor {
    _progressColor = progressColor;
    viewTop.backgroundColor = progressColor;
}

@end
