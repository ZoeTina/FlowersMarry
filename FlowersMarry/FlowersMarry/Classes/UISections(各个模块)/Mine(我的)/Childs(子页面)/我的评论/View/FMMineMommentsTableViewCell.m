//
//  FMMineMommentsTableViewCell.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/16.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMMineMommentsTableViewCell.h"
#import "FMMineDynamicTableViewCell.h"

static NSString * const reuseIdentifier = @"FMMineDynamicTableViewCell";

@interface FMMineMommentsTableViewCell()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *itemModelArray;
@end

@implementation FMMineMommentsTableViewCell

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

- (void)setCommentsModel:(MineCommentsListModel *)commentsModel{
    _commentsModel = commentsModel;
    [self initView];
    [self initConstraint];
    
    [self.imagesView sd_setImageWithURL:kGetVideoURL(commentsModel.avatar) placeholderImage:kGetImage(mineAvatar)];
    self.nicknameLabel.text = commentsModel.ct_username;
    self.datetimeLabel.text = commentsModel.ct_time;
    self.titleLabel.text = commentsModel.content;
    /// 状态 0:待审核 1:已通过 2:拒绝 3:管理员关闭 4:已过期 5:待上线 9:回收站 10:草稿 11:修改后提交 12:结束 13:商家关闭 21:商家的商铺关闭
    self.isThroughLabel.text = [Utils lz_conversionState:commentsModel.status];

    if (commentsModel.status == 0) {
        self.isThroughLabel.textColor = kColorWithRGB(41, 198, 107);
    }else if (commentsModel.status == 2){
        self.isThroughLabel.textColor = kColorWithRGB(255, 65, 99);
    }
    
    /// 有回复的情况
    if (commentsModel.cp_isreply==1) {
        NSString *replyTips = @"回复：";
        NSString *replyStr = commentsModel.content;
        NSString *replyTime = commentsModel.create_time;
        
        NSString *replyContent = [NSString stringWithFormat:@"%@%@ %@",replyTips,replyStr,replyTime];
        
        NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:replyContent];
        /// 中间面文字颜色
        [attributedStr addAttribute:NSForegroundColorAttributeName
                              value:kTextColor51
                              range:NSMakeRange(replyTips.length, replyContent.length-replyTime.length-replyTips.length)];
        
        self.replyContentLabel.attributedText = attributedStr;
        self.replyImagesView.image = kGetImage(@"mine_btn_reply");
    }
    
    self.replyDatetimeLabel.text = @"";
    /// 状态 0：待审 1：已审
    if (commentsModel.status == 0) {
        self.isThroughLabel.textColor = kColorWithRGB(255, 65, 99);
    }
}

- (void) initView{
    
    [self.contentView addSubview:self.imagesView];
    [self.contentView addSubview:self.nicknameLabel];
    [self.contentView addSubview:self.datetimeLabel];
    [self.contentView addSubview:self.titleLabel];
    
    [self.contentView addSubview:self.isThroughLabel];
    [self.contentView addSubview:self.delButton];
    
    [self.contentView addSubview:self.dynamicContainerView];
    [self.contentView addSubview:self.replyLineView];
    [self.contentView addSubview:self.replyImagesView];
    [self.contentView addSubview:self.replyLabel];
    [self.contentView addSubview:self.replyContentLabel];
    [self.contentView addSubview:self.replyDatetimeLabel];
    
    [Utils lz_setExtraCellLineHidden:self.tableView];
    [self.dynamicContainerView addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.dynamicContainerView);
    }];
}

#pragma mark - Table view data source
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FMMineDynamicTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.commentsModel = self.commentsModel;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return IPHONE6_W(82);
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.showsVerticalScrollIndicator = false;
        [_tableView registerClass:[FMMineDynamicTableViewCell class] forCellReuseIdentifier:reuseIdentifier];
        [_tableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = kTextColor244;
    }
    return _tableView;
}

- (NSMutableArray *)itemModelArray{
    if (!_itemModelArray) {
        _itemModelArray = [[NSMutableArray alloc] init];
    }
    return _itemModelArray;
}

- (void) initConstraint{
    [self.imagesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.equalTo(@(IPHONE6_W(33)));
        make.left.top.equalTo(@(IPHONE6_W(15)));
    }];
    [self.nicknameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imagesView.mas_top).offset(IPHONE6_W(3));
        make.left.equalTo(self.imagesView.mas_right).offset(IPHONE6_W(10));
        make.height.equalTo(@(IPHONE6_W(12)));
    }];
    [self.datetimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.imagesView.mas_bottom).offset(IPHONE6_W(-1));
        make.left.equalTo(self.nicknameLabel);
        make.height.equalTo(@(IPHONE6_W(12)));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nicknameLabel);
        make.top.equalTo(self.imagesView.mas_bottom).offset(IPHONE6_W(10));
        make.bottom.equalTo(self.dynamicContainerView.mas_top).offset(IPHONE6_W(-15));
        make.right.equalTo(self.mas_right).offset(IPHONE6_W(-15));
    }];
    
    [self.dynamicContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.titleLabel);
        make.height.equalTo(@(IPHONE6_W(82)));
        make.bottom.equalTo(self.replyLineView.mas_top).offset(IPHONE6_W(-50));
    }];
    
    [self.delButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.dynamicContainerView.mas_bottom).offset(IPHONE6_W(15));
        make.width.equalTo(@(IPHONE6_W(50)));
        make.height.equalTo(@(IPHONE6_W(24)));
        make.right.equalTo(self.mas_right).offset(IPHONE6_W(-25));
    }];
    
    [self.isThroughLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.delButton.mas_left).offset(IPHONE6_W(-20));
        make.centerY.equalTo(self.delButton);
    }];
    
    CGFloat replyLine_bottom = 12.0;
    CGFloat replyContent_bottom = 15.0;
    CGFloat replyImages_bottom = 11.0;
    CGFloat replyLine_height = kLinerViewHeight;
    if (self.commentsModel.cp_isreply == 0) {
        replyLine_bottom = 0;
        replyLine_height = 0;
        replyContent_bottom = 0;
        replyImages_bottom = 0;
    }
    
    [self.replyLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.titleLabel);
        make.height.equalTo(@(replyLine_height));
        make.bottom.equalTo(self.replyContentLabel.mas_top).offset(IPHONE6_W(-replyLine_bottom));
    }];
    
    [self.replyImagesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nicknameLabel);
        make.height.width.equalTo(@(IPHONE6_W(replyImages_bottom)));
        make.top.equalTo(self.replyContentLabel.mas_top).offset(3);
    }];
    [self.replyContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.replyImagesView.mas_right).offset(IPHONE6_W(4));
        make.right.equalTo(self.titleLabel);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(IPHONE6_W(-replyImages_bottom));
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


- (UILabel *)isThroughLabel{
    if (!_isThroughLabel) {
        _isThroughLabel = [UILabel lz_labelWithTitle:@"" color:kTextColor153 font:kFontSizeMedium10];
    }
    return _isThroughLabel;
}

- (UIButton *)delButton{
    if (!_delButton) {
        _delButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_delButton setTitle:@"删除" forState:UIControlStateNormal];
        [_delButton setTitleColor:kTextColor153 forState:UIControlStateNormal];
        _delButton.titleLabel.font = kFontSizeMedium10;
        [_delButton lz_setCornerRadius:IPHONE6_W(12.0)];
        [_delButton setBorderColor:kColorWithRGB(221, 221, 221)];
        [_delButton setBorderWidth:0.5];
    }
    return _delButton;
}

- (UIView *)dynamicContainerView{
    if (!_dynamicContainerView) {
        _dynamicContainerView = [UIView lz_viewWithColor:kColorWithRGB(244, 248, 251)];
    }
    return _dynamicContainerView;
}

- (UIView *)replyLineView{
    if (!_replyLineView) {
        _replyLineView = [UIView lz_viewWithColor:kLinerViewColor];
    }
    return _replyLineView;
}

- (UIImageView *)replyImagesView{
    if (!_replyImagesView) {
        _replyImagesView = [[UIImageView alloc] init];
        _replyImagesView.image = kGetImage(@"mine_btn_reply");
    }
    return _replyImagesView;
}

- (UILabel *)replyLabel{
    if (!_replyLabel) {
        _replyLabel = [UILabel lz_labelWithTitle:@"" color:kTextColor153 font:kFontSizeMedium13];
    }
    return _replyLabel;
}

- (UILabel *)replyContentLabel{
    if (!_replyContentLabel) {
        _replyContentLabel = [UILabel lz_labelWithTitle:@"" color:kTextColor153 font:kFontSizeMedium13];
    }
    return _replyContentLabel;
}

- (UILabel *)replyDatetimeLabel{
    if (!_replyDatetimeLabel) {
        _replyDatetimeLabel = [UILabel lz_labelWithTitle:@"" color:kTextColor153 font:kFontSizeMedium12];
    }
    return _replyDatetimeLabel;
}
@end
