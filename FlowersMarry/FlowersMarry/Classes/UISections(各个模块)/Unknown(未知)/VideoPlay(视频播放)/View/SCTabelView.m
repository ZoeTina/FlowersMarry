//
//  SCTabelView.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/8/31.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "SCTabelView.h"

@implementation SCTabelView

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.items = [[NSMutableArray alloc] init];
        self.pageIndex = 1;//根据自己需求设置-看你们的分页是从0还是1开始
        self.isUpdating = NO;
        
        self.estimatedRowHeight = 0;
        self.estimatedSectionHeaderHeight = 0;
        self.estimatedSectionFooterHeight = 0;
        //适配ios11自适应上导航 安全区域
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        SEL selector = NSSelectorFromString(@"setContentInsetAdjustmentBehavior:");
        if ([self respondsToSelector:selector]) {
            IMP imp = [self methodForSelector:selector];
            void (*func)(id, SEL, NSInteger) = (void *)imp;
            func(self, selector, 2);
            
        }
        self.showsVerticalScrollIndicator = NO;
    }
    return self;
}

-(void)addMJ{
    MV(weakSelf)
    self.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        //
        weakSelf.pageIndex++;
        [weakSelf getData];
    }];
}

-(void)getData{
    self.isUpdating = YES;
    [self.refreshDelegete getDataWithPage];
}
@end
