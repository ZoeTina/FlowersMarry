//
//  FMElectronicInvitationCollectionViewCell.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/11/2.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMElectronicInvitationCollectionViewCell.h"


@interface FMElectronicInvitationCollectionViewCell ()

@end

@implementation FMElectronicInvitationCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        self.contentView.backgroundColor = kClearColor;
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    [self addSubview:self.imagesView];
    [self.imagesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(self);
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
