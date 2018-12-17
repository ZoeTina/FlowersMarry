//
//  FMTemplateSevenTableViewCell.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/10/29.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMTemplateSevenTableViewCell.h"
@interface FMTemplateSevenTableViewCell()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic,strong,readonly)UICollectionView * collectionView;
@property(nonatomic,strong,readonly)UIImageView * iconImageView;
@property(nonatomic,strong,readonly)UILabel * titleLabel;

/// 记录最后的height
@property (nonatomic, assign) CGFloat endHeight;
/// headerView的高度
@property (nonatomic, assign) CGFloat headerHeight;

@end
@implementation FMTemplateSevenTableViewCell

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
        [self initView];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.headerHeight = 38;
    }
    return self;
}

- (void) initView{
    
}

/// 点击collectionViewCell
- (void)collectionView:(UITableView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectItemAtIndexPath:withContent:)]) {
//        [self.delegate didSelectItemAtIndexPath:indexPath withContent:self.dataArray[indexPath.section][indexPath.row]];
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

@end
