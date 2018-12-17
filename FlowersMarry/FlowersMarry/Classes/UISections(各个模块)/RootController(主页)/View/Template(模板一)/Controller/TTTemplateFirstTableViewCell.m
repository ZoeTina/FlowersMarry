//
//  TTTemplateFirstTableViewCell.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/12/7.
//  Copyright © 2018 宁小陌. All rights reserved.
//

#import "TTTemplateFirstTableViewCell.h"
#import "TTTemplateFirstCollectionViewCell.h"
#import "TTTemplateFirstsCollectionViewCell.h"
#import "TTTemplateModel.h"
static NSString* reuseIdentifier = @"TTTemplateFirstCollectionViewCell";
static NSString* reuseIdentifiers = @"TTTemplateFirstsCollectionViewCell";

@interface TTTemplateFirstTableViewCell()<UICollectionViewDelegate, UICollectionViewDataSource>
{
@private
    UICollectionView * _collectionView;
    UIImageView * _iconImageView;
    UILabel * _titleLabel;
}
@property(nonatomic,strong,readonly)UICollectionView * collectionView;
/// 记录最后的height
@property (nonatomic, assign) CGFloat endHeight;
/// headerView的高度
@property (nonatomic, assign) CGFloat headerHeight;

@end
@implementation TTTemplateFirstTableViewCell

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
        self.headerHeight = 0;
    }
    return self;
}

- (void) initView{
    [self.contentView addSubview:self.collectionView];
    self.collectionView.frame = CGRectMake(0, self.headerHeight, kScreenWidth, self.height+self.headerHeight);
}

// MARK:- ====UICollectionViewDataSource,UICollectionViewDelegate=====
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.dataArray.count;
}

// 每个分区有多少个数据
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSArray *subArray = [self.dataArray lz_safeObjectAtIndex:section];
    TTLog(@"self.dataArray.count -- %lu",(unsigned long)subArray.count);
    return subArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section==0) {
        TTTemplateFirstCollectionViewCell *tools = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
        TTTemplateModel* templateModel = self.dataArray[indexPath.section][indexPath.row];
        
        tools.titleLabel.text = templateModel.title;
        tools.imagesView.image = kGetImage(templateModel.imageText);
        self.indexPath = indexPath;
        [self updateCollectionViewHeight:self.collectionView.collectionViewLayout.collectionViewContentSize.height+self.headerHeight];
        return tools;
    }else{
        TTTemplateFirstsCollectionViewCell *tools = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifiers forIndexPath:indexPath];
        TTTemplateModel* templateModel = self.dataArray[indexPath.section][indexPath.row];
        
        tools.titleLabel.text = templateModel.title;
        tools.imagesView.image = kGetImage(templateModel.imageText);
        self.indexPath = indexPath;
        [self updateCollectionViewHeight:self.collectionView.collectionViewLayout.collectionViewContentSize.height+self.headerHeight];
        return tools;
    }
}

/// 点击collectionViewCell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    TTTemplateModel* templateModel = self.dataArray[indexPath.section][indexPath.row];
    if (self.delegate && [self.delegate respondsToSelector:@selector(didToolsSelectItemAtIndexPath:withContent:)]) {
        [self.delegate didToolsSelectItemAtIndexPath:indexPath withContent:templateModel.title];
    }
}

/// 更新CollectionViewHeight
- (void)updateCollectionViewHeight:(CGFloat)height {
    if (self.endHeight != height) {
        self.endHeight = height;
        self.collectionView.frame = CGRectMake(0, self.headerHeight, self.collectionView.width, height);
        if (_delegate && [_delegate respondsToSelector:@selector(updateTableViewCellHeight:andheight:andIndexPath:)]) {
            [self.delegate updateTableViewCellHeight:self andheight:height andIndexPath:self.indexPath];
        }
    }
}

/// 同一行的cell的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

//布局协议对应的方法实现
#pragma mark - UICollectionViewDelegateFlowLayout
//设置每个一个Item（cell）的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat width = kScreenWidth/4;
    if (indexPath.section==0)return CGSizeMake(width, IPHONE6_W(95));
    return CGSizeMake(width, IPHONE6_W(67));
}

//设置所有的cell组成的视图与section 上、左、下、右的间隔
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0,0,0,0);
}

//设置footer呈现的size, 如果布局是垂直方向的话，size只需设置高度，宽与collectionView一致
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return CGSizeMake(0,0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(0,0);
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        //确定滚动方向
        flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        //确定item的大小
        //        flowLayout.itemSize = CGSizeMake(100, 120);
        //确定横向间距(设置行间距)
        flowLayout.minimumLineSpacing = 0;
        //确定纵向间距(设置列间距)
        flowLayout.minimumInteritemSpacing = 0;
        //确定距离上左下右的距离
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        //头尾部高度
        flowLayout.headerReferenceSize = CGSizeMake(0, 0);
        flowLayout.footerReferenceSize = CGSizeMake(0, 0);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:[TTTemplateFirstCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
        [_collectionView registerClass:[TTTemplateFirstsCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifiers];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.bounces = YES;
    }
    return _collectionView;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
        NSArray* titleArr = @[@[@"婚纱摄影",@"婚礼策划",@"婚纱礼服",@"婚宴酒店"],
                              @[@"电子请帖",@"结婚吉日",@"结婚登记处",@"婚嫁百科"]];
        NSArray* imagesArr = @[@[@"home_tools_sheying",@"home_tools_cehua",@"home_tools_lifu",@"home_tools_hotel"],
                               @[@"home_tools_qingjian",@"home_tools_jiri",@"home_tools_dengjichu",@"home_tools_baike"]];
        NSArray* classArr = @[@[@"FMLikeMerchantsViewController",@"FMLikeDynamicViewController",@"FMMineMommentsViewController"],
                              @[@"FMMineConventionViewController",@"FMMineReviewViewController"],
                              @[@"FMTelPhoneBindViewController",@"FMThirdPartyViewController"]];
        for (int i=0; i<titleArr.count; i++) {
            NSArray *subTitlesArray = [titleArr lz_safeObjectAtIndex:i];
            NSArray *subImagesArray = [imagesArr lz_safeObjectAtIndex:i];
            NSArray *classArray = [classArr lz_safeObjectAtIndex:i];
            NSMutableArray *subArray = [NSMutableArray array];
            for (int j = 0; j < subTitlesArray.count; j ++) {
                TTTemplateModel* templateModel = [[TTTemplateModel alloc] init];
                templateModel.title = [subTitlesArray lz_safeObjectAtIndex:j];
                templateModel.imageText = [subImagesArray lz_safeObjectAtIndex:j];
                templateModel.showClass = [classArray lz_safeObjectAtIndex:j];
                [subArray addObject:templateModel];
            }
            [_dataArray addObject:subArray];
        }
    }
    return _dataArray;
}



- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel lz_labelWithTitle:@"全球旅拍" color:kTextColor102 font:kFontSizeMedium14];
    }
    return _titleLabel;
}

- (UIImageView *)iconImageView{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.image = kGetImage(@"base_icon_plane");
    }
    return _iconImageView;
}


@end
