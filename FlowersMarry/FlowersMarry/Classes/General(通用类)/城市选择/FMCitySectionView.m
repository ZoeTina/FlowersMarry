//
//  FMCitySectionView.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/8/3.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMCitySectionView.h"

@implementation FMCitySectionView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = kColorWithRGB(252, 252, 252);
        self.labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, kScreenWidth-24, 27)];
        self.labelTitle.font = kFontSizeMedium13;
        self.labelTitle.textColor = kTextColor153;
        self.labelTitle.textAlignment = NSTextAlignmentLeft;
        self.labelTitle.text = @"#";
        [self addSubview:self.labelTitle];
    }
    return self;
}

@end
