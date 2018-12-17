//
//  FMMineDynamicTableViewCell.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/16.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMMineDynamicTableViewCell.h"

@implementation FMMineDynamicTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = kClearColor;
        [self initView];
        [self initConstraint];
    }
    return self;
}

- (void)setCommentsModel:(MineCommentsListModel *)commentsModel{
    _commentsModel = commentsModel;
    /// 动态信息(商家信息)
    MineCommentsFeedModel *feedModel = commentsModel.feed;
    self.titleLabel.text = feedModel.title;
    self.nicknameLabel.text = commentsModel.cp_fullname;

    [self.imagesView sd_setImageWithURL:kGetImageURL(feedModel.thumb1) placeholderImage:kGetImage(imagePlaceholder)];
    [self.imagesAvatar sd_setImageWithURL:kGetImageURL(commentsModel.cp_logo) placeholderImage:kGetImage(mineAvatar)];
    if (feedModel.shape==3) {   /// 视频
        self.imagesPlay.hidden = NO;
    }else{/// 图片
        if (feedModel.gallery_num>1) {
            [self.imagesCountButton setTitle:[NSString stringWithFormat:@"6图"] forState:UIControlStateNormal];
            self.imagesCountButton.hidden = NO;
        }
    }
}

- (void) initView{
    [self addSubview:self.imagesView];
    [self addSubview:self.imagesAvatar];
    [self addSubview:self.imagesPlay];
    [self addSubview:self.titleLabel];
    [self addSubview:self.nicknameLabel];
    [self addSubview:self.imagesCountButton];
}

- (void) initConstraint{
    [self.imagesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(IPHONE6_W(10));
        make.centerY.mas_equalTo(self);
        make.height.mas_equalTo(IPHONE6_W(62));
        make.width.mas_equalTo(IPHONE6_W(110));
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.imagesView.mas_right).mas_offset(IPHONE6_W(10));
        make.right.mas_equalTo(self.mas_right).mas_offset(IPHONE6_W(-10));
        make.top.mas_equalTo(IPHONE6_W(10));
    }];
    [self.imagesPlay mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.centerX.mas_equalTo(self.imagesView);
    }];
    
    [self.imagesCountButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.imagesView.mas_right).mas_offset(IPHONE6_W(-8));
        make.bottom.mas_equalTo(self.imagesView.mas_bottom).mas_offset(IPHONE6_W(-8));
        make.width.mas_equalTo(IPHONE6_W(46));
        make.height.mas_equalTo(IPHONE6_W(19));
    }];
    
    [self.imagesAvatar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.imagesView.mas_bottom).mas_offset(IPHONE6_W(-3));
        make.left.mas_equalTo(self.titleLabel);
        make.width.height.mas_equalTo(IPHONE6_W(17));
    }];
    
    [self.nicknameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.imagesAvatar.mas_right).mas_offset(IPHONE6_W(6));
        make.centerY.mas_equalTo(self.imagesAvatar);
    }];
}


#pragma mark ---- setter/getter
- (UIImageView *)imagesView{
    if (!_imagesView) {
        _imagesView = [[UIImageView alloc] init];
        [_imagesView lz_setCornerRadius:IPHONE6_W(3)];
    }
    return _imagesView;
}

- (UIImageView *)imagesPlay{
    if (!_imagesPlay) {
        _imagesPlay = [[UIImageView alloc] init];
        _imagesPlay.image = kGetImage(@"live_btn_play");
        _imagesPlay.hidden = YES;
    }
    return _imagesPlay;
}

- (UIButton *)imagesCountButton{
    if (!_imagesCountButton) {
        _imagesCountButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_imagesCountButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
        _imagesCountButton.titleLabel.font = kFontSizeMedium12;
        [_imagesCountButton setImage:kGetImage(@"base_tujitubiao") forState:UIControlStateNormal];
        _imagesCountButton.hidden = YES;
        CGFloat spacing = 5;
        //image在左，文字在右，default
        [Utils lz_setButtonTitleWithImageEdgeInsets:_imagesCountButton postition:kMVImagePositionLeft spacing:spacing];
        [_imagesCountButton setBackgroundColor:kColorWithRGBA(0, 0, 0, 0.6)];
        [_imagesCountButton lz_setCornerRadius:IPHONE6_W(19/2)];
    }
    return _imagesCountButton;
}

- (UIImageView *)imagesAvatar{
    if (!_imagesAvatar) {
        _imagesAvatar = [[UIImageView alloc] init];
        [_imagesView lz_setCornerRadius:IPHONE6_W(17/2)];
    }
    return _imagesAvatar;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel lz_labelWithTitle:@"" color:kTextColor51 font:kFontSizeMedium14];
        _titleLabel.numberOfLines = 2;
    }
    return _titleLabel;
}

- (UILabel *)nicknameLabel{
    if (!_nicknameLabel) {
        _nicknameLabel = [UILabel lz_labelWithTitle:@"" color:kTextColor136 font:kFontSizeMedium12];
    }
    return _nicknameLabel;
}
@end
