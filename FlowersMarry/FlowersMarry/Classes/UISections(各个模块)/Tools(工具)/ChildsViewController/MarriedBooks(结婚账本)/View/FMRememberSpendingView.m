//
//  FMRememberSpendingView.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/10/9.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMRememberSpendingView.h"

#define NUM_ROWS 2
#define NUM_COLS 4

#define CELL_SIZE (kScreenWidth - 60)/4

@interface LLCollectionShareCell ()

//@property (nonatomic) LLCellData *data;

@property (nonatomic) UIImageView *imageView;

@property UILabel *label;

@end


@implementation LLCollectionShareCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.label = [[UILabel alloc] init];
        self.label.font = [UIFont systemFontOfSize:13];
        self.label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.label];
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.centerY.equalTo(self.contentView);
        }];
    }
    return self;
}
@end


@interface FMRememberSpendingView () <UICollectionViewDataSource, UICollectionViewDelegate>

@property (nonatomic) UICollectionView *collectionView;
@property (nonatomic) UIPageControl *pageControl;
@property (nonatomic) NSMutableArray *itemModels;

@end

@implementation FMRememberSpendingView{
    NSInteger pageNum;
    NSInteger totalSection;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupDatas];
        [self setupViews];
        self.translatesAutoresizingMaskIntoConstraints = NO;
    }
    
    return self;
}

#pragma mark - PageControll
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger section = scrollView.contentOffset.x / kScreenWidth;
    self.pageControl.currentPage = section;
    [self.pageControl updateCurrentPageDisplay];
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    NSInteger section = scrollView.contentOffset.x / kScreenWidth;
    self.pageControl.currentPage = section;
    [self.pageControl updateCurrentPageDisplay];
}

#pragma mark - CollectionView
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return totalSection;
}

- (NSInteger)collectionView :(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return pageNum;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LLCollectionShareCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LLCollectionShareCell" forIndexPath:indexPath];
    
    NSInteger row = indexPath.item % NUM_ROWS;
    NSInteger col = indexPath.item / NUM_ROWS;
    NSInteger position = NUM_COLS * row + col;
    NSInteger newItem = position + pageNum * indexPath.section;
    [cell.contentView lz_setCornerRadius:3.0];
    [cell.contentView setBorderColor:HexString(@"#D7D7D7")];
    [cell.contentView setBorderWidth:1.0];
    if (newItem < self.itemModels.count){
        cell.label.text = self.itemModels[newItem];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:NO];
//    LLCollectionShareCell *cell = (LLCollectionShareCell *)[collectionView cellForItemAtIndexPath:indexPath];
//    [self.delegate cellWithTagDidTapped:cell.tag];
    
}


- (void)setupViews {
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flowLayout.itemSize = CGSizeMake (CELL_SIZE, 28);
    
    flowLayout.minimumLineSpacing = 10;
    flowLayout.minimumInteritemSpacing = 10;
    flowLayout.sectionInset = UIEdgeInsetsMake(15, 15, 5, 15);

    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 96) collectionViewLayout:flowLayout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.pagingEnabled = YES;
    [self addSubview:self.collectionView];
    
    [self.collectionView registerClass:[LLCollectionShareCell class] forCellWithReuseIdentifier:@"LLCollectionShareCell"];
    
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 96, 0, 20)];
    self.pageControl.backgroundColor = kClearColor;
    self.pageControl.userInteractionEnabled = NO;
    self.pageControl.hidesForSinglePage = YES;
    self.pageControl.currentPageIndicatorTintColor = HexString(@"#FF8DA1");
    self.pageControl.pageIndicatorTintColor = HexString(@"#EEEEEE");
    self.pageControl.defersCurrentPageDisplay = YES;
    [self addSubview:self.pageControl];
    
    self.pageControl.numberOfPages = totalSection;
    self.pageControl.currentPage = 0;
}

- (void)setupDatas {
    self.itemModels = [[NSMutableArray alloc] init];
    NSArray *array = @[@"婚礼",@"婚宴酒店",@"婚车",@"婚庆策划",@"婚礼",@"婚礼",@"婚礼",@"婚礼",@"婚礼",@"婚礼",@"婚礼",@"婚礼"];
    self.itemModels = [array mutableCopy];
    pageNum = NUM_COLS * NUM_ROWS;
    totalSection = ceil((CGFloat)self.itemModels.count / pageNum);
}

@end
