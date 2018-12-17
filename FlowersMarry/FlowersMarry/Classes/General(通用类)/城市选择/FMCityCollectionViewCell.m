//
//  FMCityCollectionViewCell.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/8/2.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMCityCollectionViewCell.h"

@implementation FMCityCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        self.contentView.backgroundColor = kColorWithRGB(246, 247, 251);
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    [self addSubview:self.titleLabel];
    [self lz_setCornerRadius:3.0];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.centerX.mas_equalTo(self);
    }];
}

- (void)setCurrentCityStr:(NSString *)currentCityStr{
    _currentCityStr = currentCityStr;
    if (self.isIcon) {
        NSString *cityStr = @"正在定位...";
        if (currentCityStr.length!=0) {
            cityStr = currentCityStr;
        }
        NSAttributedString *commentAttr = [self creatAttrStringWithText:cityStr image:kGetImage(@"live_btn_current_position")];
        self.titleLabel.attributedText = commentAttr;
    }else{
        self.titleLabel.text = currentCityStr;
        self.titleLabel.textColor = kTextColor34;
    }
}

// 实现图文混排的方法
- (NSAttributedString *) creatAttrStringWithText:(NSString *) text image:(UIImage *) image{
    
    // NSTextAttachment可以将图片转换为富文本内容
    NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
    attachment.image = image;
    // 通过NSTextAttachment创建富文本
    // 图片的富文本
    NSAttributedString *imageAttr = [NSAttributedString attributedStringWithAttachment:attachment];
    
    // 文字的富文本
    NSAttributedString *textAttr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@" %@",text] attributes:@{NSFontAttributeName:kFontSizeMedium14}];
    
    NSMutableAttributedString *mutableAttr = [[NSMutableAttributedString alloc] init];
    
    // 将图片、文字拼接
    // 如果要求图片在文字的后面只需要交换下面两句的顺序
    [mutableAttr appendAttributedString:imageAttr];
    [mutableAttr appendAttributedString:textAttr];
    
    return [mutableAttr copy];
}

#pragma mark -- setter getter
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel lz_labelWithTitle:@"" color:kColorWithRGB(255, 65, 99) font:kFontSizeMedium14];
    }
    return _titleLabel;
}
@end
