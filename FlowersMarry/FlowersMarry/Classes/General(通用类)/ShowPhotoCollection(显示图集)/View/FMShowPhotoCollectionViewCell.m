//
//  FMShowPhotoCollectionViewCell.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/6/28.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMShowPhotoCollectionViewCell.h"

@interface FMShowPhotoCollectionViewCell ()
@property (nonatomic, weak) UILabel *label;
@end

@implementation FMShowPhotoCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self addLabel];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.backgroundColor = [UIColor clearColor];
        [self addLabel];
    }
    return self;
}

- (UIImageView *)imagesView{
    if (!_imagesView) {
        _imagesView = [[UIImageView alloc] init];
        _imagesView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imagesView;
}

- (void)addLabel {
    UILabel *label = [[UILabel alloc]init];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:18];
    [self.contentView addSubview:label];
    _label = label;
    [self.contentView addSubview:self.imagesView];
    [self.imagesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self);
    }];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _label.frame = self.bounds;
}


@end
