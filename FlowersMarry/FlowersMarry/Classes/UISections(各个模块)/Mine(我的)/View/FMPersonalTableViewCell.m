//
//  FMPersonalTableViewCell.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/9.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMPersonalTableViewCell.h"

@implementation FMPersonalTableViewCell

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
    }
    return self;
}

- (void)setPersonModel:(FMPersonModel *)personModel{
    _personModel = personModel;
    self.titleLabel.text = personModel.title;
    self.contentLabel.text = personModel.content;
    self.subtitleLable.text = personModel.subtitle;
    [self initView];
}

- (void) initView{
    [self addSubview:self.contentLabel];
    [self addSubview:self.titleLabel];
    [self addSubview:self.subtitleLable];
    [self addSubview:self.arrowImageView];
    
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.left.mas_equalTo(IPHONE6_W(15));
        make.width.mas_equalTo(IPHONE6_W(27));
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.left.mas_equalTo(self.titleLabel.mas_right).mas_offset(IPHONE6_W(27));
    }];
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.right.mas_equalTo(self.mas_right).mas_offset(IPHONE6_W(-15));
    }];
    [self.subtitleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.right.mas_equalTo(self.arrowImageView.mas_left).mas_offset(IPHONE6_W(-8));
    }];
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel lz_labelWithTitle:@"" color:kTextColor153 font:kFontSizeMedium14];
        _titleLabel.numberOfLines = 2;
    }
    return _titleLabel;
}

- (UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [UILabel lz_labelWithTitle:@"" color:kTextColor34 font:kFontSizeMedium14];
    }
    return _contentLabel;
}
- (UILabel *)subtitleLable{
    if (!_subtitleLable) {
        _subtitleLable = [UILabel lz_labelWithTitle:@"" color:kTextColor153 font:kFontSizeMedium12];
    }
    return _subtitleLable;
}

- (UIImageView *)arrowImageView{
    if (!_arrowImageView) {
        _arrowImageView = [[UIImageView alloc] init];
        _arrowImageView.image = kGetImage(@"right_arrow");
    }
    return _arrowImageView;
}
@end
