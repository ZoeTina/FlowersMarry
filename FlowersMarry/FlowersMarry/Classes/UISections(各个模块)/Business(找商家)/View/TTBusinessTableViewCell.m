//
//  TTBusinessTableViewCell.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/12/12.
//  Copyright © 2018 宁小陌. All rights reserved.
//

#import "TTBusinessTableViewCell.h"

@implementation TTBusinessTableViewCell

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
        [self addLayoutSubViews];
    }
    return self;
}

- (void)setBusinessModel:(BusinessModel *)businessModel{
    _businessModel = businessModel;
    NSString *imagesURLString = @"";
    CGFloat imagesWidht = IPHONE6_W(67);
    if (!kObjectIsEmpty(businessModel.huodong)){
        imagesURLString = [SCSmallTools imageTailoring:self.businessModel.huodong.hd_thumb width:imagesWidht height:imagesWidht];
    }else{
        imagesURLString = [SCSmallTools imageTailoring:self.businessModel.cp_logo width:imagesWidht height:imagesWidht];
    }
    
    [self.imagesView sd_setImageWithURL:kGetImageURL(imagesURLString) placeholderImage:kGetImage(imagePlaceholder)];
    
    self.titleLabel.text = self.businessModel.cp_fullname;
    self.commentCountLabel.text = [NSString stringWithFormat:@"%@条",self.businessModel.cp_comment_count];
    self.renqiLabel.text = [NSString stringWithFormat:@"人气%@",self.businessModel.cp_hits];;
    self.regionLabel.text = self.businessModel.qu_name;
    self.studioLabel.text = self.businessModel.class_name;
    self.activityContentLabel.text = self.businessModel.huodong.hd_title;
    if (!kObjectIsEmpty(self.businessModel.youhui.coupon)) {
        self.giftContentLabel.text = self.businessModel.youhui.coupon.title;
    }else{
        self.giftContentLabel.text = self.businessModel.youhui.gift.title;
    }
    if (self.businessModel.youhui_num==0&&kObjectIsEmpty(self.businessModel.huodong)) {
        self.giftView.hidden=YES;
        self.activityView.hidden = YES;
        self.imagesViewGes.hidden = YES;
        self.imagesViewGe.hidden = NO;
        self.imagesViewBao.hidden = NO;
    }else if (kObjectIsEmpty(self.businessModel.huodong)){
        self.giftView.hidden=NO;
        self.activityView.hidden = YES;
        self.imagesViewGes.hidden = NO;
        self.imagesViewGe.hidden = YES;
        self.imagesViewBao.hidden = YES;
    }else if(self.businessModel.youhui_num==0){
        self.giftView.hidden=YES;
        self.activityView.hidden = NO;
        self.imagesViewGes.hidden = YES;
        self.imagesViewGe.hidden = YES;
        self.imagesViewBao.hidden = NO;
    }else{
        self.giftView.hidden=NO;
        self.activityView.hidden = NO;
        self.imagesViewGes.hidden = YES;
        self.imagesViewGe.hidden = YES;
        self.imagesViewBao.hidden = NO;
    }
}

- (void) addLayoutSubViews{
    [self.contentView addSubview:self.imagesView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.imagesViewBao];
    [self.contentView addSubview:self.imagesViewGe];
    [self.contentView addSubview:self.imagesViewGes];
    
    [self.contentView addSubview:self.commentCountLabel];
    [self.contentView addSubview:self.renqiLabel];
    [self.contentView addSubview:self.regionLabel];
    [self.contentView addSubview:self.studioLabel];
    [self.contentView addSubview:self.imagesViewRecommend];
    
    [self.contentView addSubview:self.giftView];
    [self.giftView addSubview:self.imagesViewGifts];
    [self.giftView addSubview:self.giftContentLabel];
    
    [self.contentView addSubview:self.activityView];
    [self.activityView addSubview:self.linerView];
    [self.activityView addSubview:self.imagesViewActivity];
    [self.activityView addSubview:self.activityContentLabel];
    
    
    [self.imagesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@(IPHONE6_W(15)));
        make.height.width.equalTo(@(IPHONE6_W(67)));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imagesView.mas_right).offset(15);
        make.top.equalTo(self.imagesView.mas_top).offset(IPHONE6_W(2));
    }];
    
    [self.imagesViewBao mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_right).offset(10);
        make.centerY.equalTo(self.titleLabel);
    }];
    
    [self.imagesViewGes mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.centerY.equalTo(self.imagesViewBao);
    }];
    
    [self.imagesViewGe mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imagesViewBao.mas_right).offset(3);
        make.centerY.equalTo(self.imagesViewBao);
    }];
    
    [self.commentCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(IPHONE6_W(5));
    }];
    
    [self.renqiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.commentCountLabel.mas_right).offset(10);
        make.centerY.equalTo(self.commentCountLabel);
    }];
    
    [self.regionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.bottom.equalTo(self.imagesView.mas_bottom).offset(IPHONE6_W(-3));
    }];
    
    [self.studioLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.regionLabel.mas_right).offset(10);
        make.centerY.equalTo(self.regionLabel);
    }];
    
    [self.imagesViewRecommend mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.studioLabel.mas_right).offset(5);
        make.centerY.equalTo(self.regionLabel);
    }];
    
    [self.giftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.right.equalTo(self.contentView);
        make.height.equalTo(@(IPHONE6_W(30)));
        make.top.equalTo(self.imagesView.mas_bottom);
    }];
    
    [self.imagesViewGifts mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.centerY.equalTo(self.giftView);
    }];
    [self.giftContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.giftView);
        make.left.equalTo(@(20));
        make.right.equalTo(self.giftView.mas_right).offset(-15);
    }];
    
    [self.activityView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.right.equalTo(self.contentView);
        make.height.equalTo(@(IPHONE6_W(39)));
        make.bottom.equalTo(self.mas_bottom);
    }];
    
    [self.linerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.activityView);
        make.height.equalTo(@(0.7));
    }];
    
    [self.imagesViewActivity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.activityView);
        make.top.equalTo(@(IPHONE6_W(12)));
    }];
    
    [self.activityContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.imagesViewActivity);
        make.right.equalTo(self.activityView.mas_right).offset(-15);
        make.left.equalTo(@(30));
    }];
}


- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel lz_labelWithTitle:@"" color:kTextColor18 font:kFontSizeScBold15];
    }
    return _titleLabel;
}

- (UIImageView *)imagesView{
    if (!_imagesView) {
        _imagesView = [[UIImageView alloc] init];
        [_imagesView lz_setCornerRadius:3.0];
    }
    return _imagesView;
}

- (UILabel *)commentCountLabel{
    if (!_commentCountLabel) {
        _commentCountLabel = [UILabel lz_labelWithTitle:@"" color:kTextColor112 font:kFontSizeMedium12];
    }
    return _commentCountLabel;
}

- (UILabel *)renqiLabel{
    if (!_renqiLabel) {
        _renqiLabel = [UILabel lz_labelWithTitle:@"" color:kTextColor112 font:kFontSizeMedium12];
    }
    return _renqiLabel;
}

- (UILabel *)regionLabel{
    if (!_regionLabel) {
        _regionLabel = [UILabel lz_labelWithTitle:@"" color:kTextColor112 font:kFontSizeMedium12];
    }
    return _regionLabel;
}

- (UILabel *)studioLabel{
    if (!_studioLabel) {
        _studioLabel = [UILabel lz_labelWithTitle:@"" color:kTextColor112 font:kFontSizeMedium12];
    }
    return _studioLabel;
}

- (UIImageView *)imagesViewRecommend{
    if (!_imagesViewRecommend) {
        _imagesViewRecommend = [[UIImageView alloc] init];
        _imagesViewRecommend.image = kGetImage(@"business_tuijian");
    }
    return _imagesViewRecommend;
}

- (UIView *)giftView{
    if (!_giftView) {
        _giftView = [UIView lz_viewWithColor:kClearColor];
    }
    return _giftView;
}

- (UIImageView *)imagesViewGifts{
    if (!_imagesViewGifts) {
        _imagesViewGifts = [[UIImageView alloc] init];
        _imagesViewGifts.image = kGetImage(@"base_merchant_gift");
    }
    return _imagesViewGifts;
}

- (UILabel *)giftContentLabel{
    if (!_giftContentLabel) {
        _giftContentLabel = [UILabel lz_labelWithTitle:@"" color:kTextColor112 font:kFontSizeMedium12];
        _giftContentLabel.numberOfLines = 1;
    }
    return _giftContentLabel;
}

- (UIView *)activityView{
    if (!_activityView) {
        _activityView = [UIView lz_viewWithColor:kClearColor];
    }
    return _activityView;
}

- (UIView *)linerView{
    if (!_linerView) {
        _linerView = [UIView lz_viewWithColor:kTextColor238];
    }
    return _linerView;
}

- (UIImageView *)imagesViewActivity{
    if (!_imagesViewActivity) {
        _imagesViewActivity = [[UIImageView alloc] init];
        _imagesViewActivity.image = kGetImage(@"business_huodong");
    }
    return _imagesViewActivity;
}

- (UILabel *)activityContentLabel{
    if (!_activityContentLabel) {
        _activityContentLabel = [UILabel lz_labelWithTitle:@"" color:kTextColor112 font:kFontSizeMedium12];
        _activityContentLabel.numberOfLines = 1;
    }
    return _activityContentLabel;
}

- (UIImageView *)imagesViewBao{
    if (!_imagesViewBao) {
        _imagesViewBao = [[UIImageView alloc] init];
        _imagesViewBao.image = kGetImage(@"business_bao");
    }
    return _imagesViewBao;
}

- (UIImageView *)imagesViewGe{
    if (!_imagesViewGe) {
        _imagesViewGe = [[UIImageView alloc] init];
        _imagesViewGe.image = kGetImage(@"business_ge");
    }
    return _imagesViewGe;
}

- (UIImageView *)imagesViewGes{
    if (!_imagesViewGes) {
        _imagesViewGes = [[UIImageView alloc] init];
        _imagesViewGes.image = kGetImage(@"business_ge");
    }
    return _imagesViewGes;
}
@end
