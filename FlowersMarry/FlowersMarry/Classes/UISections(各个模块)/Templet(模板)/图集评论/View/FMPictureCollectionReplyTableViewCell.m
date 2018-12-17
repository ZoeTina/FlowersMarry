//
//  FMPictureCollectionReplyTableViewCell.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/19.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMPictureCollectionReplyTableViewCell.h"

@implementation FMPictureCollectionReplyTableViewCell

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
    }
    return self;
}
- (void) initView{
    
    [self addSubview:self.imagesView];
    [self addSubview:self.nicknameLabel];
    [self addSubview:self.datetimeLabel];
    [self addSubview:self.titleLabel];
    [self addSubview:self.replyView];
    [self.replyView addSubview:self.replyLabel];
    [self.replyView addSubview:self.replyImagesView];
}

- (void)setModel:(CommentsDynamicListModel *)model{
    _model = model;
    [self initView];
    [self initConstraint];
    [self.imagesView sd_setImageWithURL:kGetVideoURL(self.model.avatar) placeholderImage:kGetImage(mineAvatar)];
    self.titleLabel.text = model.ct_content;
    
    self.nicknameLabel.text = model.ct_username;
    self.datetimeLabel.text = model.ct_time;
    if (model.reply.count>0) {
        
        CommentsDynamicReplyModel *md = model.reply[0];
        NSString *str = @"回复：";
        NSString *replyStr = md.ct_re_content;
        NSString *replyTime = [NSString stringWithFormat:@" %@",md.ct_re_time];
        NSString *replyContent = [NSString stringWithFormat:@"%@%@%@",str,replyStr,replyTime];
        
        NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:replyContent];
        /// 中间文字颜色
        [attributedStr addAttribute:NSForegroundColorAttributeName
                              value:kTextColor51
                              range:NSMakeRange(str.length, replyContent.length - replyTime.length - str.length)];
        
        self.replyLabel.attributedText = attributedStr;
    }
}

- (void) initConstraint{
    
    CGFloat titleMargin = 0.0;
    CGFloat replyMargin = 0.0;
    if (self.model.reply.count==0) {
        self.replyView.hidden = YES;
        titleMargin = 10;
        replyMargin = 0.0;
    }else{
        titleMargin = 10.0;
        replyMargin = 10.0;
    }
    
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
        make.right.mas_equalTo(self.mas_right).mas_offset(-15);
        make.bottom.mas_equalTo(self.replyView.mas_top).mas_offset(IPHONE6_W(-titleMargin));
    }];
    
    
    [self.replyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.replyImagesView.mas_right).mas_offset(4);
        make.top.mas_equalTo(replyMargin);
        make.right.mas_equalTo(self.replyView.mas_right).mas_offset(-9);
        make.bottom.mas_equalTo(self.replyView.mas_bottom).mas_offset(-replyMargin);
    }];
    
    [self.replyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.titleLabel);
        make.bottom.mas_equalTo(self.mas_bottom).mas_offset(IPHONE6_W(-replyMargin));
    }];
    [self.replyImagesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(9);
        make.height.width.mas_equalTo(IPHONE6_W(11));
        make.top.mas_equalTo(self.replyLabel.mas_top).mas_offset(4);
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

- (UIImageView *)replyImagesView{
    if (!_replyImagesView) {
        _replyImagesView = [[UIImageView alloc] init];
        _replyImagesView.image = kGetImage(@"mine_btn_reply");
    }
    return _replyImagesView;
}

- (UIView *)replyView{
    if (!_replyView) {
        _replyView = [UIView lz_viewWithColor:kColorWithRGB(244, 248, 251)];
        [_replyView lz_setCornerRadius:4.0];
    }
    return _replyView;
}

- (UILabel *)replyLabel{
    if (!_replyLabel) {
        _replyLabel = [UILabel lz_labelWithTitle:@"" color:kTextColor153 font:kFontSizeMedium13];
    }
    return _replyLabel;
}

@end
