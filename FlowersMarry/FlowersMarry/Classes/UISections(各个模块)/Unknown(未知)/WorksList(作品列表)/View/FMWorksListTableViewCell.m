//
//  FMWorksListTableViewCell.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/2.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMWorksListTableViewCell.h"
@interface FMWorksListTableViewCell () <SDPhotoBrowserDelegate>

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation FMWorksListTableViewCell

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
    }
    return self;
}

- (void)setCasesModel:(BusinessCasesModel *)casesModel{
    _casesModel = casesModel;
    [self initView];
    
    [self.dataArray removeAllObjects];
    for (BusinessCasesPhotoModel *model in casesModel.photo) {
        [self.dataArray addObject:model.p_filename];
    }
        
    CGFloat widht = IPHONE6_W(113);
    CGFloat height = IPHONE6_W(229);
    NSString *imagesUrl0 = @"";
    NSString *imagesUrl1 = @"";
    NSString *imagesUrl2 = @"";
    if(self.casesModel.photo.count>2){
        imagesUrl0 = [SCSmallTools imageTailoring:self.casesModel.photo[0].p_filename width:height height:height];
        imagesUrl1 = [SCSmallTools imageTailoring:self.casesModel.photo[1].p_filename width:widht height:widht];
        imagesUrl2 = [SCSmallTools imageTailoring:self.casesModel.photo[2].p_filename width:widht height:widht];
    }else if(self.casesModel.photo.count>1){
        imagesUrl0 = [SCSmallTools imageTailoring:self.casesModel.photo[0].p_filename width:height height:height];
        imagesUrl1 = [SCSmallTools imageTailoring:self.casesModel.photo[1].p_filename width:widht height:widht];
    }else if (self.casesModel.photo.count>0) {
        imagesUrl0 = [SCSmallTools imageTailoring:self.casesModel.photo[0].p_filename width:height height:height];
    }
    
    [self.imagesView sd_setImageWithURL:kGetImageURL(imagesUrl0) placeholderImage:kGetImage(imagePlaceholder)];
    [self.imagesViewRightTop sd_setImageWithURL:kGetImageURL(imagesUrl1) placeholderImage:kGetImage(imagePlaceholder)];
    [self.imagesViewRightBottom sd_setImageWithURL:kGetImageURL(imagesUrl2) placeholderImage:kGetImage(imagePlaceholder)];
    self.titleLabel.text = self.casesModel.case_title;
    if (self.casesModel.case_fg.count>0) {
        NSString *printStr = @"";
        for (int i=0; i<self.casesModel.case_fg.count; i++) {
            BusinessCasesStyleModel *model = self.casesModel.case_fg[i];
            if (i!=0) {
                printStr = [printStr stringByAppendingFormat:@",%@", model.fg_name];
            }else{
                printStr = [printStr stringByAppendingFormat:@"%@", model.fg_name];
            }
        }
        self.styleLabel.text = [NSString stringWithFormat:@"风格:%@",printStr];
    }
    self.scenarioLabel.text = [NSString stringWithFormat:@"场景:%@",self.casesModel.place_name];
    self.imagesCountLabel.text = [NSString stringWithFormat:@"+%@",self.casesModel.case_filenum];
    self.subtitleLabel.text  = self.casesModel.case_content;
    NSAttributedString *commentAttr = [SCSmallTools sc_initBrowseImageWithText:self.casesModel.case_hits];
    self.browseLabel.attributedText = commentAttr;
}

-(void)singleTapAction:(UIGestureRecognizer *)recognizer{
    UITapGestureRecognizer *singleTap = (UITapGestureRecognizer *)recognizer;
    TTLog(@"%ld",[singleTap view].tag);
    //具体的实现
    SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
    browser.sourceImagesContainerView = self; // 原图的父控件
    browser.imageCount = self.dataArray.count; // 图片总数
    browser.currentImageIndex = [singleTap view].tag;
    browser.delegate = self;
    [browser show];
}

#pragma mark - photobrowser代理方法
// 返回临时占位图片（即原来的小图）
//- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index
//{
//    return [self.subviews[index] currentImage];
//}


// 返回高质量图片的url
- (NSURL *)photoBrowser:(SDPhotoBrowser *)browser highQualityImageURLForIndex:(NSInteger)index{
    NSString *imagesUrl = [SCSmallTools imageURLBetaReplace:self.dataArray[index]];
    return [NSURL URLWithString:imagesUrl];
}

- (void) initView{
    [self addSubview:self.imagesView];
    [self addSubview:self.imagesViewRightTop];
    [self addSubview:self.imagesViewRightBottom];
    [self addSubview:self.titleLabel];
    [self addSubview:self.subtitleLabel];
    [self addSubview:self.scenarioLabel];
    [self addSubview:self.styleLabel];
    [self addSubview:self.imagesCountLabel];
    [self addSubview:self.browseLabel];
    
    
    [self.imagesView setCornerRadius:3.0];
    [self.imagesViewRightTop setCornerRadius:3.0];
    [self.imagesViewRightBottom setCornerRadius:3.0];

    [self setConstraint];
    
}

- (void) setConstraint{
    
    CGFloat distance15 = 15;
    CGFloat distance10 = 10;
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(@(distance15));
        make.right.equalTo(self.mas_right).offset(-distance15);
    }];
    [self.subtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(distance10);
        make.height.equalTo(@(20));
        make.left.right.equalTo(self.titleLabel);
    }];
    
    [self.scenarioLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.subtitleLabel.mas_bottom).offset(distance10);
    }];
    [self.styleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.scenarioLabel.mas_right).offset(distance15);
        make.centerY.equalTo(self.scenarioLabel);
    }];
    [self.browseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.titleLabel);
        make.centerY.equalTo(self.scenarioLabel);
    }];
    
    [self.imagesView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.width.height.equalTo(@(IPHONE6_W(229)));
        make.top.equalTo(self.scenarioLabel.mas_bottom).offset(distance10);
    }];
    [self.imagesViewRightTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.titleLabel);
        make.top.equalTo(self.imagesView);
        make.width.height.equalTo(@(IPHONE6_W(113)));
    }];
    [self.imagesViewRightBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.right.equalTo(self.imagesViewRightTop);
        make.bottom.equalTo(self.imagesView);
    }];
    
    [self.imagesCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.centerX.equalTo(self.imagesViewRightBottom);

    }];
}

- (UIImageView *)imagesView{
    if (!_imagesView) {
        _imagesView = [[UIImageView alloc] init];
        _imagesView.userInteractionEnabled = YES;
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleTapAction:)];
        [_imagesView addGestureRecognizer:singleTap];
        UIView *singleTapView = [singleTap view];
        singleTapView.tag = 0;
    }
    return _imagesView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel lz_labelWithTitle:@"" color:kTextColor51 font:kFontSizeMedium14];
    }
    return _titleLabel;
}

- (UILabel *)subtitleLabel{
    if (!_subtitleLabel) {
        _subtitleLabel = [UILabel lz_labelWithTitle:@"" color:kTextColor136 font:kFontSizeMedium12];
    }
    return _subtitleLabel;
}

- (UILabel *)scenarioLabel{
    if (!_scenarioLabel) {
        _scenarioLabel = [UILabel lz_labelWithTitle:@"" color:kTextColor136 font:kFontSizeMedium12];
    }
    return _scenarioLabel;
}

- (UILabel *)styleLabel{
    if (!_styleLabel) {
        _styleLabel = [UILabel lz_labelWithTitle:@"" color:kTextColor136 font:kFontSizeMedium12];
    }
    return _styleLabel;
}
- (UIImageView *)imagesViewRightTop{
    if (!_imagesViewRightTop) {
        _imagesViewRightTop = [[UIImageView alloc] init];
        _imagesViewRightTop.userInteractionEnabled = YES;
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleTapAction:)];
        [_imagesViewRightTop addGestureRecognizer:singleTap];
        UIView *singleTapView = [singleTap view];
        singleTapView.tag = 1;
    }
    return _imagesViewRightTop;
}
- (UIImageView *)imagesViewRightBottom{
    if (!_imagesViewRightBottom) {
        _imagesViewRightBottom = [[UIImageView alloc] init];
        _imagesViewRightBottom.userInteractionEnabled = YES;
        UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleTapAction:)];
        [_imagesViewRightBottom addGestureRecognizer:singleTap];
        UIView *singleTapView = [singleTap view];
        singleTapView.tag = 2;
    }
    return _imagesViewRightBottom;
}

- (UILabel *)browseLabel{
    if (!_browseLabel) {
        _browseLabel = [UILabel lz_labelWithTitle:@"" color:kTextColor136 font:kFontSizeMedium12];
    }
    return _browseLabel;
}
- (UILabel *)imagesCountLabel{
    if (!_imagesCountLabel) {
        _imagesCountLabel = [UILabel lz_labelWithTitle:@"" color:kWhiteColor font:kFontSizeScBold22];
    }
    return _imagesCountLabel;
}

- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [[NSMutableArray alloc] init];
    }
    return _dataArray;
}

@end
