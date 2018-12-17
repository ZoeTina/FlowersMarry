//
//  FMPictureWithTextCellHeader.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/6/29.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMPictureWithTextCellHeader.h"

@implementation FMPictureWithTextCellHeader

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initView];
    }
    return self;
}

- (void)setDynamicModel:(DynamicModel *)dynamicModel{
    _dynamicModel = dynamicModel;
    [self.imagesView sd_setImageWithURL:kGetImageURL(self.dynamicModel.cp_logo) placeholderImage:kGetImage(mineAvatar)];
    self.titleLabel.text = self.dynamicModel.title;
    self.nicknameLabel.text = self.dynamicModel.cp_fullname;
    
    self.guanzhuButton.selected = self.dynamicModel.is_follow == 0?YES:NO;
}

- (void) initView{
    [self addSubview:self.titleLabel];
    [self addSubview:self.imagesView];
    [self addSubview:self.guanzhuButton];
    [self addSubview:self.nicknameLabel];
    [self.imagesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.width.height.equalTo(@34);
        make.bottom.equalTo(self.mas_bottom).offset(-10);
    }];
    [self.guanzhuButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-15);
        make.centerY.equalTo(self.imagesView);
        make.width.equalTo(@55);
        make.height.equalTo(@26);
    }];
    [self.nicknameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imagesView.mas_right).offset(10);
        make.centerY.equalTo(self.imagesView);
        make.right.equalTo(self.guanzhuButton.mas_left).offset(-10);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@15);
        make.top.equalTo(@10);
        make.right.equalTo(self.mas_right).offset(-15);
        make.bottom.equalTo(self.imagesView.mas_top).offset(-10);
    }];
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel lz_labelWithTitle:@"" color:kTextColor51 font:kFontSizeScBold17];
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

- (UIImageView *)imagesView{
    if (!_imagesView) {
        _imagesView = [[UIImageView alloc] init];
        [_imagesView lz_setCornerRadius:17.0];
    }
    return _imagesView;
}

- (UILabel *)nicknameLabel{
    if (!_nicknameLabel) {
        _nicknameLabel = [UILabel lz_labelWithTitle:@"" color:kTextColor51 font:kFontSizeMedium14];
    }
    return _nicknameLabel;
}

- (UIButton *)guanzhuButton{
    if (!_guanzhuButton) {
        _guanzhuButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_guanzhuButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [_guanzhuButton setTitleColor:kTextColor153 forState:UIControlStateSelected];
        _guanzhuButton.titleLabel.font = kFontSizeMedium12;
        [_guanzhuButton setTitle:@"关注" forState:UIControlStateNormal];
        [_guanzhuButton setTitle:@"已关注" forState:UIControlStateSelected];
        [_guanzhuButton lz_setCornerRadius:4];
        [_guanzhuButton setBackgroundImage:[UIImage lz_imageWithColor:[UIColor lz_colorWithHexString:@"#F85A59"]] forState:UIControlStateNormal];
        [_guanzhuButton setBackgroundImage:[UIImage lz_imageWithColor:[UIColor lz_colorWithHexString:@"#EEEEEE"]] forState:UIControlStateSelected];
    }
    return _guanzhuButton;
}

@end
