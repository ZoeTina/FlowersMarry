//
//  MineTableHeaderView.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/4.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMMineTableHeaderView.h"

@interface FMMineTableHeaderView()
@property (nonatomic, copy) FMMineTableHeaderViewBlock headViewBlock;

@end

@implementation FMMineTableHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.backgroundColor = kColorWithRGB(211, 0, 0);
        [self.imagesView lz_setCornerRadius:26];
        [self.avatarButton lz_setCornerRadius:26];
        
        
        [self initView];
        self.width = kScreenWidth;
        self.height = IPHONE6_W(80);

    }
    return self;
}

- (void)setMineTableHeadViewBlock:(FMMineTableHeaderViewBlock)block{
    self.headViewBlock = block;
}

- (IBAction)headImageBtnClicked:(id)sender {
    if (self.headViewBlock) {
        self.headViewBlock();
    }
}


- (void) initView{
    
    //    [[PVUserModel shared] load];
    //
    //    if ([PVUserModel shared].userId.length == 0) {
    //        self.nickNameLabel.text = @"点击登陆";
    //        [self.headImageBtn setImage:[UIImage imageNamed:@"mine_icon_avatar"] forState:UIControlStateNormal];
    //    }else {
    //        if ([PVUserModel shared].baseInfo.avatar.length > 0) {
    //            [self.headImageBtn yy_setImageWithURL:[NSURL URLWithString:[PVUserModel shared].baseInfo.avatar] forState:UIControlStateNormal options:YYWebImageOptionIgnoreDiskCache];
    //        }else {
    //            [self.headImageBtn setImage:[UIImage imageNamed:@"mine_icon_avatar"] forState:UIControlStateNormal];
    //        }
    //
    //        self.nickNameLabel.text = [PVUserModel shared].baseInfo.nickName;
    //    }
    
    [self addSubview:self.imagesViewBg];
    [self addSubview:self.imagesView];
    [self addSubview:self.nickNameLabel];
    [self addSubview:self.personDataBtn];
    [self addSubview:self.iconImageView];
    [self addSubview:self.avatarButton];
    [self.imagesViewBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(self);
    }];
    [self.imagesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(IPHONE6_W(52));
        make.left.mas_equalTo(IPHONE6_W(15));
        make.centerY.mas_equalTo(self);
    }];
    [self.avatarButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.imagesView);
    }];
    [self.nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.imagesView.mas_right).mas_offset(IPHONE6_W(15));
        make.top.mas_equalTo(self.imagesView.mas_top).mas_equalTo(6);
    }];
    [self.personDataBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.imagesView.mas_right).mas_offset(IPHONE6_W(13));
        make.width.mas_equalTo(IPHONE6_W(62));
        make.height.mas_equalTo(IPHONE6_W(18));
        make.bottom.mas_equalTo(self.imagesView.mas_bottom).mas_equalTo(-6);
    }];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_right).mas_offset(IPHONE6_W(-26));
        make.centerY.mas_equalTo(self);
    }];
}


- (UIImageView *)imagesViewBg{
    if (!_imagesViewBg) {
        _imagesViewBg = [[UIImageView alloc] init];
        _imagesViewBg.image = kGetImage(@"mine_bg_header");
    }
    return _imagesViewBg;
}

- (UIImageView *)imagesView{
    if (!_imagesView) {
        _imagesView = [[FLAnimatedImageView alloc] init];
    }
    return _imagesView;
}

- (UIImageView *)iconImageView{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.image = kGetImage(@"mine_btn_news");
    }
    return _iconImageView;
}

- (UIButton *)avatarButton{
    if (!_avatarButton) {
        _avatarButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_avatarButton setBackgroundColor:kClearColor];
    }
    return _avatarButton;
}

- (UILabel *)nickNameLabel{
    if (!_nickNameLabel) {
        _nickNameLabel = [UILabel lz_labelWithTitle:@"" color:kWhiteColor font:kFontSizeMedium15];
    }
    return _nickNameLabel;
}

- (UIButton *)personDataBtn{
    if (!_personDataBtn) {
        _personDataBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_personDataBtn setTitleColor:kWhiteColor forState:UIControlStateNormal];
        _personDataBtn.titleLabel.font = kFontSizeMedium10;
        [_personDataBtn setTitle:@"个人资料" forState:UIControlStateNormal];
        [_personDataBtn setImage:kGetImage(@"mine_btn_pen") forState:UIControlStateNormal];
        CGFloat spacing = 5;
        //image在左，文字在右，default
        [Utils lz_setButtonTitleWithImageEdgeInsets:_personDataBtn postition:kMVImagePositionRight spacing:spacing];
        [_personDataBtn setBackgroundColor:kColorWithRGBA(0, 0, 0, 0.6)];
        [_personDataBtn lz_setCornerRadius:10.0];
        [_personDataBtn lz_handleControlEvent:UIControlEventTouchUpInside withBlock:^{
            [self headImageBtnClicked:self.personDataBtn];
        }];
    }
    return _personDataBtn;
}
@end
