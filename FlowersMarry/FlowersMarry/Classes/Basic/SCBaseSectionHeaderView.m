//
//  SCBaseSectionHeaderView.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/12.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "SCBaseSectionHeaderView.h"

@implementation SCBaseSectionHeaderView

- (void)setFrame:(CGRect)frame{
    self.backgroundColor = kTableViewInSectionColor;
    CGRect sectionRect = [self.tableView rectForSection:self.section];
    CGRect newFrame = CGRectMake(CGRectGetMinX(frame), CGRectGetMinY(sectionRect), CGRectGetWidth(frame), CGRectGetHeight(frame));
    [super setFrame:newFrame];
}


@end
