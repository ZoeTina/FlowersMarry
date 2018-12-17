//
//  FMMerchantsHomeHeaderView.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/11.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMMerchantsHomeHeaderView.h"
#import "FMShowPhotoCollectionViewCell.h"
#import "TYPageControl.h"
#import "TYCyclePagerView.h"

static NSString* reuseIdentifiers = @"resuRoundRobinCell";

@interface FMMerchantsHomeHeaderView()<TYCyclePagerViewDataSource,TYCyclePagerViewDelegate>

@property (nonatomic, strong) TYCyclePagerView *pagerView;
@property (nonatomic, strong) TYPageControl *pageControl;
@property (nonatomic, copy)FMImageTemmpletCellCallBlock callBlock;

@end

@implementation FMMerchantsHomeHeaderView

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
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setListModel:(NSMutableArray<BusinessHuodongModel *> *)listModel{
    _listModel = listModel;
    [self initView];
}

- (void) initView{
    [self addPagerView];
    
    if (self.listModel.count>1) {
        self.pagerView.autoScrollInterval = 3;//自动轮播时间
    }

    self.pageControl.numberOfPages = self.listModel.count;
    [self.pagerView reloadData];
    
}

- (void)addPagerView {
    [self addSubview:self.pagerView];
    [self addPageControl];
    
    [self.pagerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.bottom.right.equalTo(self);
    }];
    
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(-20);
        make.centerX.equalTo(self);
    }];
}

- (void)setImagesTemmpletCellCallBlock:(FMImageTemmpletCellCallBlock)block{
    self.callBlock = block;
}

- (void)pagerView:(TYCyclePagerView *)pageView didSelectedItemCell:(__kindof UICollectionViewCell *)cell atIndex:(NSInteger)index {
    if (self.callBlock) {
        self.callBlock(index);
    }
}

#pragma mark - TYCyclePagerViewDataSource

- (NSInteger)numberOfItemsInPagerView:(TYCyclePagerView *)pageView {
    return self.listModel.count;
}

- (UICollectionViewCell *)pagerView:(TYCyclePagerView *)pagerView cellForItemAtIndex:(NSInteger)index {
    FMShowPhotoCollectionViewCell *cell = [pagerView dequeueReusableCellWithReuseIdentifier:reuseIdentifiers forIndex:index];
    
    BusinessHuodongModel *model = self.listModel[index];
    NSString *hd_thumb = [SCSmallTools imageTailoring:model.hd_thumb width:kScreenWidth height:self.height];
    [cell.imagesView sd_setImageWithURL:kGetImageURL(hd_thumb)
                       placeholderImage:kGetImage(imagePlaceholder)
                              completed:^(UIImage *image, NSError *error,SDImageCacheType cacheType, NSURL *imageURL) {
                                  if (image.size.height) {
                                      /**  < 图片宽度 >  */
                                      CGFloat imageW = kScreenWidth;
                                      /**  <根据比例 计算图片高度 >  */
                                      CGFloat ratio = image.size.height / image.size.width;
                                      /**  < 图片高度 + 间距 >  */
                                      CGFloat imageH = ratio * imageW;
                                      /**  < 缓存图片高度 没有缓存则缓存 刷新indexPath >  */
                                      [cell.imagesView mas_makeConstraints:^(MASConstraintMaker *make) {
                                          make.centerY.centerX.width.equalTo(cell);
                                          make.height.equalTo(@(imageH));
                                      }];
                                  }
                              }];
    return cell;
}

- (TYCyclePagerViewLayout *)layoutForPagerView:(TYCyclePagerView *)pageView {
    TYCyclePagerViewLayout *layout = [[TYCyclePagerViewLayout alloc]init];
    layout.itemSize = CGSizeMake(kScreenWidth, kScreenHeight);
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.itemSpacing = 0.0;//间距
    layout.itemVerticalCenter = YES;
    layout.minimumAlpha = 0.3;
    return layout;
}

- (void)pagerView:(TYCyclePagerView *)pageView didScrollFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    _pageControl.currentPage = toIndex;
    //[_pageControl setCurrentPage:newIndex animate:YES];
//    TTLog(@"%ld ->  %ld",fromIndex,toIndex);
}

- (TYCyclePagerView *)pagerView{
    if (!_pagerView) {
        _pagerView = [[TYCyclePagerView alloc]  init];
        [_pagerView registerClass:[FMShowPhotoCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifiers];
        _pagerView.dataSource = self;
        _pagerView.delegate = self;
        _pagerView.isInfiniteLoop = YES;//是否回到第一页
        _pagerView.autoScrollInterval = 0;//自动轮播时间
    }
    return _pagerView;
}

- (void)addPageControl {
    TYPageControl *pageControl = [[TYPageControl alloc]init];
    //pageControl.numberOfPages = _datas.count;
    pageControl.currentPageIndicatorSize = CGSizeMake(6, 6);
    pageControl.pageIndicatorSize = CGSizeMake(12, 6);
    pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    pageControl.pageIndicatorTintColor = [UIColor grayColor];
    pageControl.pageIndicatorImage = kGetImage(@"live_gunlun_nor");
    pageControl.currentPageIndicatorImage = kGetImage(@"live_gunlun_press");
    //    pageControl.contentInset = UIEdgeInsetsMake(0, 20, 0, 20);
    //    pageControl.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    //    pageControl.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    //    [pageControl addTarget:self action:@selector(pageControlValueChangeAction:) forControlEvents:UIControlEventValueChanged];
    [_pagerView addSubview:pageControl];
    _pageControl = pageControl;
}
@end
