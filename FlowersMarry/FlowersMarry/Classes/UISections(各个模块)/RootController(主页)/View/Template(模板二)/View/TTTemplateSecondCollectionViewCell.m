//
//  TTTemplateSecondCollectionViewCell.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/12/7.
//  Copyright © 2018 宁小陌. All rights reserved.
//

#import "TTTemplateSecondCollectionViewCell.h"

@implementation TTTemplateSecondCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        self.contentView.backgroundColor = [UIColor clearColor];
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    [self lz_setCornerRadius:3.0];
    [self.contentView addSubview:self.imagesView];
    [self.imagesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.contentView);
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
