//
//  FMShowPhotoCollectionViewCell.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/6/28.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMShowPhotoCollectionViewCell.h"

@interface FMShowPhotoCollectionViewCell ()
@property (nonatomic, weak) UILabel *label;
@end

@implementation FMShowPhotoCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self addLabel];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.backgroundColor = [UIColor clearColor];
        [self addLabel];
    }
    return self;
}

- (void)setGalleryModel:(DynamicGalleryModel *)galleryModel{
    _galleryModel = galleryModel;
    [self addLabel];
    [self.imagesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self);
    }];
    NSString *URLString = [SCSmallTools imageTailoring:self.galleryModel.path width:kScreenWidth height:kScreenHeight];
    [self.imagesView sd_setImageWithURL:kGetImageURL(URLString) placeholderImage:kGetImage(imagePlaceholder)];
    //    [self.imagesView sd_setImageWithURL:kGetImageURL(model.path)
    //                       placeholderImage:kGetImage(imagePlaceholder)
    //                              completed:^(UIImage *image, NSError *error,SDImageCacheType cacheType, NSURL *imageURL) {
    //                                  if (image.size.height) {
    //                                      /**  < 图片宽度 >  */
    //                                      CGFloat imageW = kScreenWidth;
    //                                      /**  <根据比例 计算图片高度 >  */
    //                                      CGFloat ratio = image.size.height / image.size.width;
    //                                      /**  < 图片高度 + 间距 >  */
    //                                      CGFloat imageH = ratio * imageW;
    //                                      /**  < 缓存图片高度 没有缓存则缓存 刷新indexPath >  */
    //                                      [self.imagesView mas_makeConstraints:^(MASConstraintMaker *make) {
    //                                          make.centerY.centerX.width.equalTo(self);
    //                                          make.height.equalTo(@(imageH));
    //                                      }];
    //                                  }
    //                              }];
}

- (UIImageView *)imagesView{
    if (!_imagesView) {
        _imagesView = [[UIImageView alloc] init];
        _imagesView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imagesView;
}

- (void)addLabel {
    UILabel *label = [[UILabel alloc]init];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:18];
    [self.contentView addSubview:label];
    _label = label;
    [self.contentView addSubview:self.imagesView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _label.frame = self.bounds;
}


@end
