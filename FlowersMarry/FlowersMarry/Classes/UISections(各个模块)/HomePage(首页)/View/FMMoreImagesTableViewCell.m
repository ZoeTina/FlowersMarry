//
//  FMMoreImagesTableViewCell.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/4.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMMoreImagesTableViewCell.h"


@implementation FMMoreImagesTableViewCell

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
    
    NSString *URLString1 = [SCSmallTools imageTailoring:self.dynamicModel.thumb1 width:IPHONE6_W(230) height:IPHONE6_W(129)];
    NSString *URLString2 = [SCSmallTools imageTailoring:self.dynamicModel.thumb2 width:IPHONE6_W(112) height:IPHONE6_W(63)];
    NSString *URLString3 = [SCSmallTools imageTailoring:self.dynamicModel.thumb3 width:IPHONE6_W(112) height:IPHONE6_W(63)];
    
    [self.imagesViewLeft sd_setImageWithURL:kGetImageURL(URLString1) placeholderImage:kGetImage(imagePlaceholder)];
    [self.imagesViewTop sd_setImageWithURL:kGetImageURL(URLString2) placeholderImage:kGetImage(imagePlaceholder)];
    [self.imagesViewBottom sd_setImageWithURL:kGetImageURL(URLString3) placeholderImage:kGetImage(imagePlaceholder)];
    
    [self.avatarImageView sd_setImageWithURL:kGetImageURL(self.dynamicModel.cp_logo) placeholderImage:kGetImage(mineAvatar)];
    NSString *imagesCount = [NSString stringWithFormat:@"%ld 图",self.dynamicModel.thumb_num];
    [self.imagesCountButton setTitle:imagesCount forState:UIControlStateNormal];
}

- (void) initView{
    
    [self addSubview:self.titleLabel];
    [self addSubview:self.nicknameLabel];
    [self addSubview:self.datetimeLabel];
    [self addSubview:self.likeCountLabel];
    
    [self addSubview:self.imagesViewLeft];
    [self addSubview:self.imagesViewTop];
    [self addSubview:self.imagesViewBottom];
    [self addSubview:self.imagesCountButton];
    
    [self addSubview:self.avatarImageView];
    [self addSubview:self.likeImageView];
    
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(IPHONE6_W(15));
        make.right.mas_equalTo(self.mas_right).mas_offset(-(IPHONE6_W(15)));
        make.bottom.mas_equalTo(self.imagesViewLeft.mas_top).mas_offset(-(IPHONE6_W(10)));
    }];
    
    [self.imagesViewLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(IPHONE6_W(15));
        make.height.mas_equalTo(IPHONE6_W(129));
        make.width.mas_equalTo(IPHONE6_W(230));
    }];
    
    [self.imagesViewTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imagesViewLeft.mas_top);
        make.left.mas_equalTo(self.imagesViewLeft.mas_right).mas_offset(3);
        make.height.mas_equalTo(IPHONE6_W(63));
        make.width.mas_equalTo(IPHONE6_W(112));
    }];

    [self.imagesViewBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.imagesViewLeft.mas_bottom);
        make.left.height.width.mas_equalTo(self.imagesViewTop);
    }];

    [self.imagesCountButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.imagesViewBottom.mas_right).offset(-(IPHONE6_W(10)));
        make.bottom.mas_equalTo(self.imagesViewBottom.mas_bottom).offset(-(IPHONE6_W(10)));
        make.height.mas_equalTo(IPHONE6_W(20));
        make.width.mas_equalTo(IPHONE6_W(52));
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
        make.right.mas_equalTo(self.mas_right).mas_offset(-IPHONE6_W(15));
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

- (UIImageView *)imagesViewTop{
    if (!_imagesViewTop) {
        _imagesViewTop = [[UIImageView alloc] init];
        [_imagesViewTop lz_setCornerRadius:3.0];
    }
    return _imagesViewTop;
}

- (UIImageView *)imagesViewBottom{
    if (!_imagesViewBottom) {
        _imagesViewBottom = [[UIImageView alloc] init];
        [_imagesViewBottom lz_setCornerRadius:3.0];
    }
    return _imagesViewBottom;
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

- (UIButton *)imagesCountButton{
    if (!_imagesCountButton) {
        _imagesCountButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_imagesCountButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
        _imagesCountButton.titleLabel.font = kFontSizeMedium12;
        [_imagesCountButton setImage:kGetImage(@"base_tujitubiao") forState:UIControlStateNormal];
        CGFloat spacing = 5;
        //image在左，文字在右，default
        [Utils lz_setButtonTitleWithImageEdgeInsets:_imagesCountButton postition:kMVImagePositionLeft spacing:spacing];
        [_imagesCountButton setBackgroundColor:kColorWithRGBA(0, 0, 0, 0.6)];
        [_imagesCountButton lz_setCornerRadius:10.0];
    }
    return _imagesCountButton;
}

@end
