//
//  TTTemplateChildCollectionViewCell.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/12/12.
//  Copyright © 2018 宁小陌. All rights reserved.
//

#import "TTTemplateChildCollectionViewCell.h"

@implementation TTTemplateChildCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        self.contentView.backgroundColor = [UIColor clearColor];
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    [self.contentView addSubview:self.imagesView];
    [self.imagesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}

#pragma mark -- setter getter
- (UIImageView *)imagesView{
    if (!_imagesView) {
        _imagesView = [[UIImageView alloc] init];
    }
    return _imagesView;
}
@end
