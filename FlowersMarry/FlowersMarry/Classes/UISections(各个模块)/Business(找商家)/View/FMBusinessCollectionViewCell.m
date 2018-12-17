//
//  FMBusinessCollectionViewCell.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/24.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMBusinessCollectionViewCell.h"

@implementation FMBusinessCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        self.contentView.backgroundColor = [UIColor clearColor];
        [self setupUI];
    }
    return self;
}

- (void)setModel:(BusinessCasesModel *)model{
    _model = model;
    [self setupUI];
}

- (void)setupUI {

    NSString *urlStr = [SCSmallTools imageTailoring:self.model.case_thumb width:self.width height:self.height];
    [self.imagesView sd_setImageWithURL:kGetImageURL(urlStr) placeholderImage:kGetImage(imagePlaceholder)];
    
    self.titleLabel.text = [NSString stringWithFormat:@"￥%ld",(long)self.model.tx_price];

    [self addSubview:self.imagesView];
    [self addSubview:self.titleLabel];
    [self.imagesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.bottom.mas_equalTo(self.mas_bottom);
    }];
}
#pragma mark -- setter getter

- (SCCustomMarginLabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[SCCustomMarginLabel alloc] init];
        _titleLabel.textColor = kWhiteColor;;
        _titleLabel.font = kFontSizeMedium12;
        _titleLabel.edgeInsets = UIEdgeInsetsMake(3, 4, 3, 4);
        _titleLabel.backgroundColor = [kBlackColor colorWithAlphaComponent:0.4];
    }
    return _titleLabel;
}

- (UIImageView *)imagesView{
    if (!_imagesView) {
        _imagesView = [[UIImageView alloc] init];
    }
    return _imagesView;
}
@end
