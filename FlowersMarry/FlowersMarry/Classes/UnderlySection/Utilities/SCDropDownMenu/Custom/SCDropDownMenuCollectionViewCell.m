//
//  SCDropDownMenuCollectionViewCell.m
//  SCDropDownMenu
//
//  Created by 宁小陌 on 2018/5/16.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "SCDropDownMenuCollectionViewCell.h"
#import "Masonry.h"

@implementation SCDropDownMenuCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel = [[UILabel alloc] initWithFrame:self.contentView.bounds];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
    return self;
}
@end
