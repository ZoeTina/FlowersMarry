//
//  FMImagesTransverseThreeTableViewCell.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/5.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMImagesTransverseThreeTableViewCell.h"

@implementation FMImagesTransverseThreeTableViewCell

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
    NSString *URLString1 = [SCSmallTools imageTailoring:self.dynamicModel.thumb1 width:IPHONE6_W(113) height:IPHONE6_W(64)];
    NSString *URLString2 = [SCSmallTools imageTailoring:self.dynamicModel.thumb2 width:IPHONE6_W(113) height:IPHONE6_W(64)];
    NSString *URLString3 = [SCSmallTools imageTailoring:self.dynamicModel.thumb3 width:IPHONE6_W(113) height:IPHONE6_W(64)];
    
    [self.imagesViewLeft sd_setImageWithURL:kGetImageURL(URLString1) placeholderImage:kGetImage(imagePlaceholder)];
    [self.imagesViewCenter sd_setImageWithURL:kGetImageURL(URLString2) placeholderImage:kGetImage(imagePlaceholder)];
    [self.imagesViewRight sd_setImageWithURL:kGetImageURL(URLString3) placeholderImage:kGetImage(imagePlaceholder)];
    
    [self.avatarImageView sd_setImageWithURL:kGetImageURL(self.dynamicModel.cp_logo) placeholderImage:kGetImage(mineAvatar)];
}

- (void) initView{
    
    [self addSubview:self.titleLabel];
    [self addSubview:self.nicknameLabel];
    [self addSubview:self.datetimeLabel];
    [self addSubview:self.likeCountLabel];
    
    [self addSubview:self.imagesViewLeft];
    [self addSubview:self.imagesViewCenter];
    [self addSubview:self.imagesViewRight];
    
    [self addSubview:self.avatarImageView];
    [self addSubview:self.likeImageView];
    CGFloat marginLeft = IPHONE6_W(15);
    CGFloat imageSpace = IPHONE6_W(3);
    CGFloat imageHeight = IPHONE6_W(64);
    CGFloat imageWidth = IPHONE6_W(113);
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(marginLeft);
        make.right.mas_equalTo(self.mas_right).mas_offset(-(marginLeft));
        make.bottom.mas_equalTo(self.imagesViewLeft.mas_top).mas_offset(-(IPHONE6_W(10)));
    }];
    
    [self.imagesViewLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(marginLeft);
        make.height.mas_equalTo(imageHeight);
        make.width.mas_equalTo(imageWidth);
    }];
    
    [self.imagesViewCenter mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.imagesViewLeft.mas_right).mas_offset(imageSpace);
        make.height.width.centerY.mas_equalTo(self.imagesViewLeft);
    }];
    
    [self.imagesViewRight mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.imagesViewCenter.mas_right).mas_offset(imageSpace);
        make.height.width.centerY.mas_equalTo(self.imagesViewLeft);
    }];
    
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imagesViewLeft.mas_bottom).mas_offset(IPHONE6_W(6));
        make.bottom.mas_equalTo(self.mas_bottom).mas_offset(-(IPHONE6_W(10)));
        make.left.mas_equalTo(IPHONE6_W(15));
        make.width.height.mas_equalTo(IPHONE6_W(20));
    }];
    
    [self.nicknameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.avatarImageView);
        make.left.mas_equalTo(self.avatarImageView.mas_right).mas_offset(IPHONE6_W(9));
    }];
    [self.likeCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.avatarImageView);
        make.right.mas_equalTo(self.mas_right).mas_offset(-(marginLeft));
    }];
    [self.likeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.likeCountLabel);
        make.right.mas_equalTo(self.likeCountLabel.mas_left).mas_offset(-IPHONE6_W(3));
    }];
    [self.datetimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.likeCountLabel);
        make.right.mas_equalTo(self.likeImageView.mas_left).mas_offset(-IPHONE6_W(13));
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

- (UIImageView *)imagesViewLeft{
    if (!_imagesViewLeft) {
        _imagesViewLeft = [[UIImageView alloc] init];
        [_imagesViewLeft lz_setCornerRadius:3.0];
    }
    return _imagesViewLeft;
}

- (UIImageView *)imagesViewCenter{
    if (!_imagesViewCenter) {
        _imagesViewCenter = [[UIImageView alloc] init];
        [_imagesViewCenter lz_setCornerRadius:3.0];
    }
    return _imagesViewCenter;
}

- (UIImageView *)imagesViewRight{
    if (!_imagesViewRight) {
        _imagesViewRight = [[UIImageView alloc] init];
        [_imagesViewRight lz_setCornerRadius:3.0];
    }
    return _imagesViewRight;
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
