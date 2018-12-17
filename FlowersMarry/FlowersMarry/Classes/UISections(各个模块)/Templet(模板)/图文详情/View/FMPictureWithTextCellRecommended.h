//
//  FMPictureWithTextCellRecommended.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/6/29.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FMRecommendedTableViewCellDelegate <NSObject>
- (void)recommendedCollectionCellClickWithUrl:(NSString *)url code:(NSString *)code;
@end

@interface FMPictureWithTextCellRecommended : UITableViewCell

@property (nonatomic, weak) id <FMRecommendedTableViewCellDelegate>cellDelegate;

@property (nonatomic, strong) NSMutableArray<DynamicModel *> *dataArray;

@end

//历史记录，单元格
@interface FMRecommendedCollectionViewCell : UICollectionViewCell

@property(nonatomic,strong,readonly)UIImageView * imagesView;
@property(nonatomic,strong,readonly)UILabel * titleLabel;
/// 点赞按钮
@property (nonatomic, strong) UIButton *likeButton;
@property (nonatomic, strong) UIImageView *likeImageViews;
@property (nonatomic, strong) UILabel *likeLabel;
/// 点赞按钮
@property (nonatomic, strong) UIButton *imagesCountButton;

@end
