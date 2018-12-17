//
//  SCTableViewSectionFooterView.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/21.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "SCTableViewSectionFooterView.h"

@implementation SCTableViewSectionFooterView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = kTableViewInSectionColor; 
    }
    return self;
}

@end
