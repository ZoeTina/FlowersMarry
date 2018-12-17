//
//  FMTaskSectionHeaderView.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/10/15.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMTaskSectionHeaderView.h"

@implementation FMTaskSectionHeaderView

- (void)setFrame:(CGRect)frame{
    self.backgroundColor = kTextColor244;
    CGRect sectionRect = [self.tableView rectForSection:self.section];
    CGRect newFrame = CGRectMake(CGRectGetMinX(frame), CGRectGetMinY(sectionRect), CGRectGetWidth(frame), CGRectGetHeight(frame));
    [super setFrame:newFrame];
}


@end
