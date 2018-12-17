//
//  FMPictureCollectionCommentsTableViewCell.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/18.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMPictureCollectionCommentsTableViewCell.h"

@implementation FMPictureCollectionCommentsTableViewCell

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
        self.contentView.backgroundColor = kWhiteColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self initView];
        [self initConstraint];
        [self setData];
    }
    return self;
}

- (void) setData{
    self.imagesView.image = kGetImage(@"base_user");
    self.nicknameLabel.text = @"网友2659996";
    self.datetimeLabel.text = @"5分钟前";
    self.titleLabel.text = @"因为是网上订的 所以一直都有所担心。没想到对方很大 环境也很好 服务也特别好。特别感谢化妆师英子老师 由于自己怀孕了才拍照。在选服装的时候特别累就没认真选。";
    
}

- (void) initView{
    
    [self addSubview:self.imagesView];
    [self addSubview:self.nicknameLabel];
    [self addSubview:self.datetimeLabel];
    [self addSubview:self.titleLabel];

}

- (void) initConstraint{
    [self.imagesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(IPHONE6_W(33));
        make.left.top.mas_equalTo(15);
    }];
    [self.nicknameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.imagesView.mas_top).mas_offset(IPHONE6_W(3));
        make.left.mas_equalTo(self.imagesView.mas_right).mas_offset(IPHONE6_W(10));
        make.height.mas_equalTo(IPHONE6_W(12));
    }];
    [self.datetimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.imagesView.mas_bottom).mas_offset(IPHONE6_W(-1));
        make.left.mas_equalTo(self.nicknameLabel);
        make.height.mas_equalTo(IPHONE6_W(12));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.nicknameLabel);
        make.top.mas_equalTo(self.imagesView.mas_bottom).mas_offset(IPHONE6_W(10));
        make.bottom.mas_equalTo(self.mas_bottom).mas_offset(IPHONE6_W(-10));
        make.right.mas_equalTo(self.mas_right).mas_offset(-15);
    }];
}


#pragma mark ---- setter/getter
- (UIImageView *)imagesView{
    if (!_imagesView) {
        _imagesView = [[UIImageView alloc] init];
        [_imagesView lz_setCornerRadius:IPHONE6_W(33.0)/2];
    }
    return _imagesView;
}

- (UILabel *)nicknameLabel{
    if (!_nicknameLabel) {
        _nicknameLabel = [UILabel lz_labelWithTitle:@"" color:kTextColor102 font:kFontSizeMedium12];
    }
    return _nicknameLabel;
}

- (UILabel *)datetimeLabel{
    if (!_datetimeLabel) {
        _datetimeLabel = [UILabel lz_labelWithTitle:@"" color:kTextColor153 font:kFontSizeMedium12];
    }
    return _datetimeLabel;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel lz_labelWithTitle:@"" color:kTextColor34 font:kFontSizeMedium13];
    }
    return _titleLabel;
}
@end
