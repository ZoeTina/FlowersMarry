//
//  FMStoreLiveTableViewCell.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/19.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMStoreLiveTableViewCell.h"
#import "FMTravelCollectionViewCell.h"

static NSString * const reuseIdentifier = @"FMTravelCollectionViewCell";
@interface FMStoreLiveTableViewCell()<UICollectionViewDelegate,UICollectionViewDataSource,SDPhotoBrowserDelegate>

@property (nonatomic,strong) UICollectionView * collectionView;
/// 标题
@property (nonatomic, strong) UILabel *titleLabel;
/// 大图数组
@property (nonatomic, strong) NSMutableArray *dataArray;
@end
@implementation FMStoreLiveTableViewCell

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
    }
    return self;
}

- (void)setListModel:(NSMutableArray<BusinessCasesPhotoModel *> *)listModel{
    _listModel = listModel;
    [self initView];
    [self.collectionView reloadData];
    [self.dataArray removeAllObjects];
    for (BusinessCasesPhotoModel *model in listModel) {
        [self.dataArray addObject:model.p_filename];
    }
}

#pragma mark - photobrowser代理方法
// 返回临时占位图片（即原来的小图）
- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index {
    return kGetImage(CROSSMAPBITMAP);
}

// 返回高质量图片的url
- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index {
    NSString *imagesUrl = [NSString stringWithFormat:@"http:%@",self.dataArray[index]];
    return [NSURL URLWithString:imagesUrl];
}


- (void) initView{
    if (self.listModel.count == 0) {
        self.titleLabel.hidden = NO;
        [self addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }else{
        self.titleLabel.hidden = YES;
        [self addSubview:self.collectionView];
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
    }
}

#pragma mark ---- UICollectionViewDataSource
// MARK:- ====UICollectionViewDataSource,UICollectionViewDelegate=====
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

//每个分区有多少个数据
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.listModel.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    FMTravelCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.backgroundColor = kColorWithRGB(231, 242, 248);
    cell.containerView.hidden = NO;
    cell.linerView.hidden = YES;
    
    BusinessCasesPhotoModel *model = self.listModel[indexPath.row];
    [cell.imagesView sd_setImageWithURL:kGetImageURL(model.p_filename) placeholderImage:kGetImage(imagePlaceholder)];
    return cell;
}

/// 点击collectionViewCell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectStoreLiveItemAtIndexPath:)]) {
        //        [self.delegate didSelectStoreLiveItemAtIndexPath:indexPath];
    }
    
    //具体的实现
    SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
    browser.sourceImagesContainerView = self; // 原图的父控件
    browser.imageCount = self.dataArray.count; // 图片总数
    browser.currentImageIndex = indexPath.row;
    browser.delegate = self;
    [browser show];
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        CGFloat margin = IPHONE6_W(15);
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        //确定滚动方向
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        //确定item的大小
        flowLayout.itemSize = CGSizeMake(IPHONE6_W(120), IPHONE6_W(80));
        //确定横向间距(设置行间距)
        flowLayout.minimumLineSpacing = 5;
        //确定纵向间距(设置列间距)
        flowLayout.minimumInteritemSpacing = 5;
        //确定距离上左下右的距离
        flowLayout.sectionInset = UIEdgeInsetsMake(margin,margin,margin,margin);
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

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel lz_labelWithTitle:@"暂无相关实景~" color:kTextColor170 font:kFontSizeMedium13];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

@end
