//
//  FMVideoTableViewCell.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/4.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMVideoTableViewCell.h"

@implementation FMVideoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor clearColor];
        [self initView];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setDynamicModel:(DynamicModel *)dynamicModel{
    _dynamicModel = dynamicModel;
    self.titleLabel.text = self.dynamicModel.title;
    self.nicknameLabel.text = self.dynamicModel.cp_fullname;
    self.datetimeLabel.text = self.dynamicModel.create_time;
    self.likeCountLabel.text = self.dynamicModel.collect_num;
    NSString *URLString = [SCSmallTools imageTailoring:self.dynamicModel.thumb1 width:IPHONE6_W(345) height:IPHONE6_W(194)];
    
    TTLog(@" --- %@",URLString);
    [self.imagesView sd_setImageWithURL:kGetImageURL(URLString) placeholderImage:kGetImage(imagePlaceholder)];
    [self.avatarImageView sd_setImageWithURL:kGetImageURL(self.dynamicModel.cp_logo) placeholderImage:kGetImage(mineAvatar)];
}

- (void) initView{
    
    self.likeImageView.image = kGetImage(@"base_aixin");

    [self addSubview:self.titleLabel];
    [self addSubview:self.imagesView];
    [self addSubview:self.playButton];

    [self addSubview:self.avatarImageView];
    [self addSubview:self.nicknameLabel];
    [self addSubview:self.datetimeLabel];
    [self addSubview:self.likeImageView];
    [self addSubview:self.likeCountLabel];
    
    
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(15);
        make.right.mas_equalTo(self.mas_right).mas_offset(-15);
        make.bottom.mas_equalTo(self.imagesView.mas_top).mas_offset(-10);
    }];
    
    [self.imagesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.avatarImageView.mas_top).mas_offset(-6);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(self.mas_right).mas_offset(-15);
        make.height.mas_equalTo(IPHONE6_W(194));
    }];
    
    [self.playButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.centerX.mas_equalTo(self.imagesView);
    }];
    
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-10);
        make.left.mas_equalTo(15);
        make.width.height.mas_equalTo(20);
    }];
    [self.nicknameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.avatarImageView);
        make.left.mas_equalTo(self.avatarImageView.mas_right).mas_offset(9);
    }];
    [self.likeCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.avatarImageView);
        make.right.mas_equalTo(self.mas_right).mas_offset(-15);
    }];
    [self.likeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.likeCountLabel);
        make.right.mas_equalTo(self.likeCountLabel.mas_left).mas_offset(-3);
    }];
    [self.datetimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.likeCountLabel);
        make.right.mas_equalTo(self.likeImageView.mas_left).mas_offset(-13);
    }];
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel lz_labelWithTitle:@"" color:kTextColor51 font:kFontSizeMedium15];
    }
    return _titleLabel;
}
- (UILabel *)nicknameLabel{
    if (!_nicknameLabel) {
        _nicknameLabel = [UILabel lz_labelWithTitle:@"" color:kTextColor136 font:kFontSizeMedium12];
    }
    return _nicknameLabel;
}
- (UILabel *)datetimeLabel{
    if (!_datetimeLabel) {
        _datetimeLabel = [UILabel lz_labelWithTitle:@"" color:kTextColor136 font:kFontSizeMedium12];
    }
    return _datetimeLabel;
}
- (UILabel *)likeCountLabel{
    if (!_likeCountLabel) {
        _likeCountLabel = [UILabel lz_labelWithTitle:@"" color:kTextColor136 font:kFontSizeMedium12];
    }
    return _likeCountLabel;
}

- (UIImageView *)imagesView{
    if (!_imagesView) {
        _imagesView = [[UIImageView alloc] init];
        [_imagesView lz_setCornerRadius:3.0];
    }
    return _imagesView;
}

- (UIImageView *)avatarImageView{
    if (!_avatarImageView) {
        _avatarImageView = [[UIImageView alloc] init];
        [_avatarImageView setCornerRadius:10.0];
    }
    return _avatarImageView;
}

- (UIImageView *)likeImageView{
    if (!_likeImageView) {
        _likeImageView = [[UIImageView alloc] init];
        _likeImageView.image = kGetImage(@"base_aixin");
    }
    return _likeImageView;
}

- (UIButton *)playButton{
    if (!_playButton) {
        _playButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_playButton setImage:kGetImage(@"live_btn_play") forState:UIControlStateNormal];
    }
    return _playButton;
}
@end
