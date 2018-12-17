//
//  FMMineConventionTableViewCell.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/13.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMMineConventionTableViewCell.h"

@implementation FMMineConventionTableViewCell

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
        self.contentView.backgroundColor = kTextColor244;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setListData:(ConventionListData *)listData{
    _listData = listData;
    [self initView];
    
    self.titleLabel.text = listData.cp_fullname ;
    [self.imagesView sd_setImageWithURL:kGetImageURL(listData.cp_logo) placeholderImage:kGetImage(imagePlaceholder)];
    self.dateLabel.text = listData.add_time ;
    /// 预约状态 0:待确认 1:已确认 2:无效关闭
    if (listData.ap_status == 0) {
        self.determinedLabel.text = @"待确认";
        self.determinedLabel.textColor = kColorWithRGB(254, 180, 0);
    } else if(listData.ap_status == 1){
        self.determinedLabel.text = @"已确认";
        self.determinedLabel.textColor = kTextColor153;
    } else if(listData.ap_status == 2){
        self.determinedLabel.text = @"关闭";
        self.determinedLabel.textColor = kTextColor51;
    }else{
        self.determinedLabel.text = @"未知";
        self.determinedLabel.textColor = kColorWithRGB(211, 0, 0);
    }
    self.telLabel.text = [NSString stringWithFormat:@"预约电话:%@",listData.ap_phone] ;
}

- (void) initView{
    [self addSubview:self.containerView];
    [self.containerView addSubview:self.imagesView];
    [self.containerView addSubview:self.titleLabel];
    [self.containerView addSubview:self.dateLabel];
    [self.containerView addSubview:self.telLabel];
    [self.containerView addSubview:self.determinedLabel];
    
    [self.containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(IPHONE6_W(15)));
        make.top.equalTo(@(IPHONE6_W(7)));
        make.right.equalTo(self.mas_right).offset(IPHONE6_W(-15));
        make.bottom.equalTo(self);
    }];
    
    [self.imagesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(IPHONE6_W(10)));
        make.centerY.equalTo(self.containerView);
        make.width.height.equalTo(@(IPHONE6_W(35)));
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imagesView.mas_right).offset(13);
        make.top.equalTo(@(IPHONE6_W(23)));
        make.height.equalTo(@15);
    }];
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.centerY.equalTo(self.containerView);
    }];
    [self.telLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.bottom.equalTo(self.containerView.mas_bottom).offset(IPHONE6_W(-23));
    }];
    [self.determinedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.containerView);
        make.right.equalTo(self.containerView.mas_right).offset(IPHONE6_W(-14));
    }];
}

- (UIImageView *)imagesView{
    if (!_imagesView) {
        _imagesView = [[UIImageView alloc] init];
        [_imagesView lz_setCornerRadius:IPHONE6_W(35.0)/2];
    }
    return _imagesView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel lz_labelWithTitle:@"" color:kTextColor34 font:kFontSizeMedium14];
    }
    return _titleLabel;
}

- (UILabel *)dateLabel{
    if (!_dateLabel) {
        _dateLabel = [UILabel lz_labelWithTitle:@"" color:kTextColor153 font:kFontSizeMedium12];
    }
    return _dateLabel;
}

- (UILabel *)telLabel{
    if (!_telLabel) {
        _telLabel = [UILabel lz_labelWithTitle:@"" color:kTextColor153 font:kFontSizeMedium12];
    }
    return _telLabel;
}
- (UILabel *)determinedLabel{
    if (!_determinedLabel) {
        _determinedLabel = [UILabel lz_labelWithTitle:@"" color:kTextColor153 font:kFontSizeMedium12];
    }
    return _determinedLabel;
}

- (UIView *)containerView{
    if (!_containerView) {
        _containerView = [UIView lz_viewWithColor:kWhiteColor];
        [_containerView lz_setCornerRadius:3.0];
    }
    return _containerView;
}

@end
