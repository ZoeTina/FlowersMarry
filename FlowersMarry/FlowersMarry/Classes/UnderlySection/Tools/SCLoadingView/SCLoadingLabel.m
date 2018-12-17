//
//  SCLoadingLabel.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/8/6.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "SCLoadingLabel.h"


static SCLoadingLabel *_loadingLabel = nil;
@implementation SCLoadingLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

+(SCLoadingLabel *)shareLoadingLabel{
    if (!_loadingLabel) {
        _loadingLabel = [[SCLoadingLabel alloc] init];
        _loadingLabel.font = kFontSizeMedium14;
        _loadingLabel.textColor = kTextColor102;
        _loadingLabel.backgroundColor = [UIColor clearColor];
    }
    return _loadingLabel;
}

@end
