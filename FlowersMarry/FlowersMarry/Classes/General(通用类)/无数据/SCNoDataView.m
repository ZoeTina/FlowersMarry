//
//  SCNoDataView.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/8/4.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "SCNoDataView.h"

@interface SCNoDataView ()
@property (nonatomic, strong) UIImageView *imagesView;
@property (nonatomic, strong) UILabel *tipsLabel;
@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) NSString *tips;
@end

@implementation SCNoDataView

- (instancetype)initWithFrame:(CGRect)frame imageName:(NSString *)imageName tipsLabelText:(NSString *)tips{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = frame;
        [self setupUI];
        self.imagesView.image = [UIImage imageNamed:imageName];
        self.tipsLabel.text = tips;
    }
    return self;
}

- (void) setupUI{
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.imagesView];
    [self addSubview:self.tipsLabel];
    [self.imagesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.top.equalTo(self);
    }];
    [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.imagesView.mas_bottom).offset(15);
    }];
}

- (UIImageView *)imagesView{
    if (!_imagesView) {
        _imagesView = [[UIImageView alloc] init];
        _imagesView.image = kGetImage(@"");
    }
    return _imagesView;
}

- (UILabel *)tipsLabel{
    if (!_tipsLabel) {
        _tipsLabel = [UILabel lz_labelWithTitle:@"" color:kTextColor170 font:kFontSizeMedium14];
    }
    return _tipsLabel;
}

@end
