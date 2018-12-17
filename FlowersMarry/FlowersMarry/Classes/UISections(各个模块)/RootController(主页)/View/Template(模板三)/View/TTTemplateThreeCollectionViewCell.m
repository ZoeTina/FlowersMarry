//
//  TTTemplateThreeCollectionViewCell.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/12/10.
//  Copyright © 2018 宁小陌. All rights reserved.
//

#import "TTTemplateThreeCollectionViewCell.h"

@implementation TTTemplateThreeCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        self.contentView.backgroundColor = [UIColor clearColor];
        [self setupUI];
    }
    return self;
}

- (void) setDynamicModel:(DynamicModel *)dynamicModel{
    _dynamicModel = dynamicModel;
    NSString *URLString = [SCSmallTools imageTailoring:self.dynamicModel.thumb1 width:306 height:171];
    [self.imagesView sd_setImageWithURL:kGetImageURL(URLString) placeholderImage:kGetImage(imagePlaceholder)];
    self.titleLabel.text = self.dynamicModel.title;
}

- (void)setupUI {
    [self.imagesView lz_setCornerRadius:5.0];
    [self.contentView addSubview:self.imagesView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.imagesPlay];
    [self.imagesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self.contentView);
        make.height.equalTo(@(171));
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(-13);
        make.centerX.equalTo(self.imagesView);
    }];
    [self.imagesPlay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self.imagesView);
    }];
}

#pragma mark -- setter getter
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel lz_labelWithTitle:@"" color:kTextColor102 font:kFontSizeMedium14];
    }
    return _titleLabel;
}

- (UIImageView *)imagesView{
    if (!_imagesView) {
        _imagesView = [[UIImageView alloc] init];
    }
    return _imagesView;
}

- (UIImageView *)imagesPlay{
    if (!_imagesPlay) {
        _imagesPlay = [[UIImageView alloc] init];
        _imagesPlay.image = kGetImage(@"live_btn_play");
    }
    return _imagesPlay;
}
@end
