//
//  FMImagesRightTableViewCell.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/5.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMImagesRightTableViewCell.h"

@implementation FMImagesRightTableViewCell

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
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initView];
    }
    return self;
}

- (void)setDynamicModel:(DynamicModel *)dynamicModel{
    _dynamicModel = dynamicModel;
    self.titleLabel.text = self.dynamicModel.title;
    self.nicknameLabel.text = self.dynamicModel.cp_fullname;
    self.datetimeLabel.text = self.dynamicModel.create_time;
    self.likeCountLabel.text = self.dynamicModel.collect_num;
    
    NSString *URLString = [SCSmallTools imageTailoring:self.dynamicModel.thumb1 width:IPHONE6_W(150) height:IPHONE6_W(84)];
    [self.imagesView sd_setImageWithURL:kGetImageURL(URLString) placeholderImage:kGetImage(imagePlaceholder)];
    [self.avatarImageView sd_setImageWithURL:kGetImageURL(self.dynamicModel.cp_logo) placeholderImage:kGetImage(mineAvatar)];
}

- (void) initView{
    
    [self addSubview:self.titleLabel];
    [self addSubview:self.imagesView];
    
    [self addSubview:self.avatarImageView];
    [self addSubview:self.nicknameLabel];
    [self addSubview:self.datetimeLabel];
    [self addSubview:self.likeImageView];
    [self addSubview:self.likeCountLabel];
    
    
    [self.imagesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(IPHONE6_W(84));
        make.width.mas_equalTo(IPHONE6_W(150));
        make.right.mas_equalTo(self.mas_right).mas_offset(IPHONE6_W(-15));
        make.centerY.mas_equalTo(self);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(IPHONE6_W(15));
        make.right.mas_equalTo(self.imagesView.mas_left).mas_offset(IPHONE6_W(-15));
    }];

    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom).mas_offset(IPHONE6_W(15));
        make.left.mas_equalTo(self.titleLabel);
        make.width.height.mas_equalTo(20);
    }];
    [self.nicknameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.avatarImageView);
        make.left.mas_equalTo(self.avatarImageView.mas_right).mas_offset(9);
    }];

    [self.datetimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_bottom).mas_offset(IPHONE6_W(-15));
        make.left.mas_equalTo(self.titleLabel);
        make.top.mas_equalTo(self.avatarImageView.mas_bottom).mas_offset(IPHONE6_W(4));

    }];
    [self.likeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.datetimeLabel);
        make.left.mas_equalTo(self.datetimeLabel.mas_right).mas_offset(IPHONE6_W(13));
    }];
    [self.likeCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.likeImageView);
        make.left.mas_equalTo(self.likeImageView.mas_right).mas_offset(IPHONE6_W(3));
    }];
}

- (SCVerticallyAlignedLabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[SCVerticallyAlignedLabel alloc] init];
        _titleLabel.textColor = kTextColor51;
        _titleLabel.font = kFontSizeMedium15;
        _titleLabel.verticalAlignment = SCVerticalAlignmentTop;
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

@end
