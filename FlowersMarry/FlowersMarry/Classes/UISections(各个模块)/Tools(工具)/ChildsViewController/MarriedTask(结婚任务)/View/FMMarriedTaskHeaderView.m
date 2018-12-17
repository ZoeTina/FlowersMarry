//
//  FMMarriedTaskHeaderView.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/10/12.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMMarriedTaskHeaderView.h"

@interface FMMarriedTaskHeaderView()
@property (nonatomic, copy) FMMarriedTaskHeaderViewBlock headViewBlock;
@end

@implementation FMMarriedTaskHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = kWhiteColor;
        [self initView];
    }
    return self;
}

- (void)setToolsTaskTableHeadViewBlock:(FMMarriedTaskHeaderViewBlock)block{
    self.headViewBlock = block;
}

- (void) initView{
    [self addSubview:self.titleLabel];
    [self addSubview:self.totalCountLabel];
    [self addSubview:self.tipsLabel];
    [self addSubview:self.progressView];
    [self addSubview:self.bottomView];
    [self.bottomView addSubview:self.invitationButton];
    [self.bottomView addSubview:self.invitationLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.height.equalTo(@(16));
    }];
    
    [self.totalCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(8);
        make.height.equalTo(@(10));
    }];
    
    [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.progressView.mas_bottom).offset(9);
    }];
    
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.equalTo(@(40));
    }];
    [self.invitationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bottomView);
        make.left.equalTo(@(20));
    }];
    [self.invitationButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bottomView.mas_right).offset(-20);
        make.centerY.equalTo(self.bottomView);
        make.width.equalTo(@(55));
        make.height.equalTo(@(22));
    }];
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel lz_labelWithTitle:@"已经完成" color:kWhiteColor font:kFontSizeMedium17];
    }
    return _titleLabel;
}

- (UILabel *)totalCountLabel{
    if (!_totalCountLabel) {
        _totalCountLabel = [UILabel lz_labelWithTitle:@"" color:kWhiteColor font:kFontSizeMedium11];
        _totalCountLabel.alpha = 0.6;
    }
    return _totalCountLabel;
}

- (UILabel *)tipsLabel{
    if (!_tipsLabel) {
        _tipsLabel = [UILabel lz_labelWithTitle:@"" color:kWhiteColor font:kFontSizeMedium10];
        _tipsLabel.text= @"为我们人生中最神圣的时刻加油吧！";
        _tipsLabel.alpha = 0.6;
    }
    return _tipsLabel;
}

- (SCProgressView *)progressView{
    if (!_progressView) {
        _progressView = [[SCProgressView alloc] initWithFrame:CGRectMake(48, 61, kScreenWidth-96, 4)];
    }
    return _progressView;
}

- (UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [UIView lz_viewWithColor:HexString(@"#FEF3E1")];
    }
    return _bottomView;
}

- (UIButton *)invitationButton{
    if (!_invitationButton) {
        _invitationButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _invitationButton.titleLabel.font = kFontSizeMedium12;
        [_invitationButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [_invitationButton setTitle:@"去邀请" forState:UIControlStateNormal];
        [_invitationButton lz_setCornerRadius:11.0];
        [_invitationButton setBackgroundImage:[UIImage lz_imageWithColor:HexString(@"#F9A16E")] forState:UIControlStateNormal];
    }
    return _invitationButton;
}

- (UILabel *)invitationLabel{
    if (!_invitationLabel) {
        _invitationLabel = [UILabel lz_labelWithTitle:@"邀请另一半，使用同一份结婚任务~"
                                                color:HexString(@"#DA8A5B")
                                                 font:kFontSizeMedium13];
    }
    return _invitationLabel;
}
@end
