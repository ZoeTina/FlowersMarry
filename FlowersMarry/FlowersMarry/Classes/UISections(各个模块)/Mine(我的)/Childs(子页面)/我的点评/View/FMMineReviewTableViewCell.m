//
//  FMMineReviewTableViewCell.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/16.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMMineReviewTableViewCell.h"
#import "FMMineReviewChildTableViewCell.h"
#import "FMTravelCollectionViewCell.h"
#import "FMMineReviewModel.h"
#import "SCStartRating.h"

static NSString * const reuseIdentifiers = @"FMTravelCollectionViewCell";
static NSString * const reuseIdentifier = @"FMMineReviewChildTableViewCell";

@interface FMMineReviewTableViewCell()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) UICollectionView * collectionView;

/// 记录最后的height
@property (nonatomic, assign) CGFloat endHeight;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *itemModelArray;
/// 星星控件
@property (nonatomic, strong) SCStartRating *startRating;

/// headerView的高度
@property (nonatomic, assign) CGFloat headerHeight;
@property (nonatomic, assign) CGFloat collectionViewHeight;
@property (nonatomic, assign) NSInteger imagesCount;
@property (nonatomic, strong) NSMutableArray *commentPhoto;
@end

@implementation FMMineReviewTableViewCell

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
        self.contentView.backgroundColor = kWhiteColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        [self initView];
    }
    return self;
}

- (void)setModel:(MineReviewListModel *)model{
    
    _model = model;
    self.commentPhoto = model.photo;
    self.datetimeLabel.text = model.ct_add_time;
    TTLog(@" -- -%@",model.ct_add_time);
    _imagesCount = model.photo.count;
    
    [self.imagesView sd_setImageWithURL:kGetVideoURL(self.model.avatar) placeholderImage:kGetImage(mineAvatar)];
    self.nicknameLabel.text = model.user_name;
    self.titleLabel.text = model.ct_content;
    // 请在设置完成最大最小的分数后再设置当前分数
    self.startRating.currentScore = model.ct_level;

    if (model.ct_isreply==1) {
        
        NSString *replyTips = @"回复：";
        NSString *replyStr = model.ct_re_content;
        NSString *replyTime = model.reply_at;
        NSString *replyContent = [NSString stringWithFormat:@"%@%@ %@",replyTips,replyStr,replyTime];
        
        NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:replyContent];
        /// 中间面文字颜色
        [attributedStr addAttribute:NSForegroundColorAttributeName
                              value:kTextColor51
                              range:NSMakeRange(replyTips.length, replyContent.length-replyTime.length-replyTips.length)];
        
        self.replyContentLabel.attributedText = attributedStr;
        self.replyImagesView.image = kGetImage(@"mine_btn_reply");

    }
    
    //    self.replyContentLabel.text = @"回复：感谢您的选择和信任，我们会一如既往地为更多人服务! 1 分钟前";
    self.replyDatetimeLabel.text = @"";
    if ([model.status_text isEqualToString:@"待审核"]) {
        self.isThroughLabel.textColor = kColorWithRGB(41, 198, 107);
    }else if ([model.status_text isEqualToString:@"未通过"]){
        self.isThroughLabel.textColor = kColorWithRGB(255, 65, 99);
    }
    self.isThroughLabel.text = model.status_text;
    
    /// 状态 0:待审核 1:已通过 2:拒绝 3:管理员关闭 4:已过期 5:待上线 9:回收站 10:草稿 11:修改后提交 12:结束 13:商家关闭 21:商家的商铺关闭
    self.isThroughLabel.text = [Utils lz_conversionState:model.ct_status];
    
    if (model.ct_status == 0) {
        self.isThroughLabel.textColor = kColorWithRGB(41, 198, 107);
    }else if (model.ct_status == 2){
        self.isThroughLabel.textColor = kColorWithRGB(255, 65, 99);
    }
    [self.collectionView reloadData];
    [self initConstraint:model.ct_isreply];
}

- (void) initView{
    
    [self addSubview:self.imagesView];
    [self addSubview:self.nicknameLabel];
    [self addSubview:self.startRating];
    [self addSubview:self.datetimeLabel];
    [self addSubview:self.titleLabel];
    
    [self addSubview:self.isThroughLabel];
    [self addSubview:self.delButton];
    
    [self addSubview:self.dynamicContainerView];
    [self addSubview:self.replyLineView];
    [self addSubview:self.replyImagesView];
    [self addSubview:self.replyLabel];
    [self addSubview:self.replyContentLabel];
    [self addSubview:self.replyDatetimeLabel];
    
    [self addSubview:self.collectionView];
    
    
    /// 计算collectionViewHeight高度
//    CGFloat idx = 2/3.0;
//    TTLog(@"---- %d---- %d",(int)ceilf(0.33333333),(int)ceilf(idx));
//    self.collectionViewHeight = 2*97+5*2;
    
    [Utils lz_setExtraCellLineHidden:self.tableView];
    [self.dynamicContainerView addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self.dynamicContainerView);
    }];
}

#pragma mark - Table view data source
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FMMineReviewChildTableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.model = self.model;
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return IPHONE6_W(70);
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark ---- UICollectionViewDataSource
// MARK:- ====UICollectionViewDataSource,UICollectionViewDelegate=====
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

//每个分区有多少个数据
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _imagesCount;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FMTravelCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.backgroundColor = kColorWithRGB(231, 242, 248);
    cell.containerView.hidden = NO;
    cell.linerView.hidden = YES;
    
    MineCommentPhotoModel *model = self.commentPhoto[indexPath.row];
    [cell.imagesView sd_setImageWithURL:kGetImageURL(model.p_filename) placeholderImage:kGetImage(imagePlaceholder)];
    [self updateCollectionViewHeight:self.collectionView.collectionViewLayout.collectionViewContentSize.height];
    
    return cell;
}

/// 点击collectionViewCell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectItemAtIndexPath:withContent:)]) {
        [self.delegate didSelectItemAtIndexPath:indexPath withContent:self.dataArray[indexPath.section][indexPath.row]];
    }
}

/// 更新CollectionViewHeight
- (void)updateCollectionViewHeight:(CGFloat)height {
    if (self.endHeight != height) {
        self.endHeight = height;
//        self.collectionView.frame = CGRectMake(IPHONE6_W(60), 0, self.collectionView.width, height);
//        [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.left.right.equalTo(self.titleLabel);
//            make.height.equalTo(IPHONE6_W(204));
//            make.bottom.equalTo(self.dynamicContainerView.mas_top).offset(IPHONE6_W(-15));
//        }];
        if (_delegate && [_delegate respondsToSelector:@selector(updateTableViewCellHeight:andheight:andIndexPath:)]) {
            [self.delegate updateTableViewCellHeight:self andheight:height andIndexPath:self.indexPath];
        }
    }
}

//布局协议对应的方法实现
#pragma mark - UICollectionViewDelegateFlowLayout
//设置每个一个Item（cell）的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat item = 3;
    CGFloat spacing = 5.0*2;
    CGFloat width = (kScreenWidth-IPHONE6_W(75)-IPHONE6_W(spacing))/item;
    return CGSizeMake(width, width);
}

//设置所有的cell组成的视图与section 上、左、下、右的间隔
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{

    return UIEdgeInsetsMake(0,0,0,0);
}


- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        //确定滚动方向
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        //确定item的大小
        //        flowLayout.itemSize = CGSizeMake(100, 120);
        //确定横向间距(设置行间距)
        flowLayout.minimumLineSpacing = 5;
        //确定纵向间距(设置列间距)
        flowLayout.minimumInteritemSpacing = 5;
        //确定距离上左下右的距离
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        //头尾部高度
        flowLayout.headerReferenceSize = CGSizeMake(0, 0);
        flowLayout.footerReferenceSize = CGSizeMake(0, 0);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:[FMTravelCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.bounces = YES;
    }
    return _collectionView;
}

-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.showsVerticalScrollIndicator = false;
        [_tableView registerClass:[FMMineReviewChildTableViewCell class] forCellReuseIdentifier:reuseIdentifier];
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

#pragma mark ----- 约束设置 ------
- (void) initConstraint:(NSInteger )isReply{
    [self.imagesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.equalTo(@(IPHONE6_W(33)));
        make.left.top.equalTo(@15);
    }];
    [self.nicknameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imagesView.mas_top).offset(IPHONE6_W(3));
        make.left.equalTo(self.imagesView.mas_right).offset(IPHONE6_W(10));
        make.height.equalTo(@12);
    }];
    [self.datetimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-15);
        make.centerY.height.equalTo(self.nicknameLabel);
    }];
    
    [self.startRating mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nicknameLabel).mas_offset(-5);
        make.height.equalTo(@20);
        make.bottom.equalTo(self.imagesView.mas_bottom).offset(-1);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nicknameLabel);
        make.top.equalTo(self.imagesView.mas_bottom).offset(IPHONE6_W(10));
        make.bottom.equalTo(self.collectionView.mas_top).offset(IPHONE6_W(-10));
        make.right.equalTo(self.mas_right).offset(-15);
    }];
    
    CGFloat idx = _imagesCount/3.0;
    /// 进位法，得到有多少列
//    TTLog(@"---- %d---- %d",(int)ceilf(0.33333333),(int)ceilf(idx));
    if (_imagesCount>0) {
        self.collectionViewHeight = (int)ceilf(idx)*97+5*2;
    }else{
        self.collectionViewHeight = 0.0f;
    }
    MV(weakSelf)
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.titleLabel);
        make.height.equalTo(@(IPHONE6_W(self.collectionViewHeight)));
        CGFloat mas_bottom = weakSelf.imagesCount>0?0:15;
        make.bottom.equalTo(self.dynamicContainerView.mas_top).offset(IPHONE6_W(-mas_bottom));
    }];
    
    [self.dynamicContainerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.titleLabel);
        make.height.equalTo(@(IPHONE6_W(70)));
        make.bottom.equalTo(self.replyLineView.mas_top).offset(IPHONE6_W(-50));
    }];
    
    [self.delButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.dynamicContainerView.mas_bottom).offset(15);
        make.width.equalTo(@50);
        make.height.equalTo(@24);
        make.right.equalTo(self.mas_right).offset(-25);
    }];
    
    [self.isThroughLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.delButton.mas_left).offset(-20);
        make.centerY.equalTo(self.delButton);
    }];
    
    CGFloat replyLine_bottom = 12.0;
    CGFloat replyContent_bottom = 15.0;
    CGFloat replyImages_bottom = 11.0;
    CGFloat replyLine_height = kLinerViewHeight;
    if (isReply==0) {
        replyLine_bottom = 0;
        replyLine_height = 0;
        replyImages_bottom = 0;
        replyContent_bottom = 0;
    }
    
    [self.replyLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.titleLabel);
        make.height.equalTo(@(replyLine_height));
        make.bottom.equalTo(self.replyContentLabel.mas_top).offset(IPHONE6_W(-replyLine_bottom));
    }];
    
    [self.replyImagesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nicknameLabel);
        make.height.width.equalTo(@(replyImages_bottom));
        make.top.equalTo(self.replyContentLabel.mas_top);
    }];
    [self.replyContentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.replyImagesView.mas_right).offset(IPHONE6_W(4));
        make.right.equalTo(self.titleLabel);
        make.bottom.equalTo(self.mas_bottom).offset(IPHONE6_W(-replyContent_bottom));
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
        [_delButton lz_setCornerRadius:12.0];
        [_delButton setBorderColor:kColorWithRGB(221, 221, 221)];
        [_delButton setBorderWidth:0.7];
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
    }
    return _replyImagesView;
}

- (UILabel *)replyLabel{
    if (!_replyLabel) {
        _replyLabel = [UILabel lz_labelWithTitle:@"" color:kTextColor153 font:kFontSizeMedium13];
    }
    return _replyLabel;
}

- (SCVerticallyAlignedLabel *)replyContentLabel{
    if (!_replyContentLabel) {
        _replyContentLabel = [[SCVerticallyAlignedLabel alloc] init];
        _replyContentLabel.textColor = kTextColor153;
        _replyContentLabel.font = kFontSizeMedium13;
        _replyContentLabel.verticalAlignment = SCVerticalAlignmentTop;
        _replyContentLabel.numberOfLines = 0;
    }
    return _replyContentLabel;
}

- (SCStartRating *)startRating{
    if (!_startRating) {
        _startRating = [[SCStartRating alloc] initWithFrame:CGRectMake(0, 0, 80, 0) Count:5];
        _startRating.spacing = 5.0f;
        _startRating.checkedImage = kGetImage(@"business_shixing");
        _startRating.uncheckedImage = kGetImage(@"business_kongxing");
        _startRating.type = SCRatingTypeHalf;
        _startRating.touchEnabled = YES;
        _startRating.slideEnabled = YES;
        _startRating.maximumScore = 5.0f;
        _startRating.minimumScore = 0.0f;
    }
    return _startRating;
}

- (UILabel *)replyDatetimeLabel{
    if (!_replyDatetimeLabel) {
        _replyDatetimeLabel = [UILabel lz_labelWithTitle:@"" color:kTextColor153 font:kFontSizeMedium12];
    }
    return _replyDatetimeLabel;
}
@end
