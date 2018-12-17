//
//  MVChooseTableViewCell.m
//  MerchantVersion
//
//  Created by 寜小陌 on 2018/3/2.
//  Copyright © 2018年 寜小陌. All rights reserved.
//

#import "MVChooseTableViewCell.h"
#define HorizonGap 15
#define TilteBtnGap 10
@implementation MVChooseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)drawRect:(CGRect)rect {
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextFillRect(context, rect);
    CGContextSetStrokeColorWithColor(context, [UIColor lz_colorWithHex:0xf7f7f7].CGColor);
    CGContextStrokeRect(context, CGRectMake(0, rect.size.height - 0.5, rect.size.width, 0.5));
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void)initView{
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.selectBtn];
    
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.top.equalTo(self.contentView.mas_top);
        make.height.mas_equalTo(self.contentView.mas_height);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@44);
        make.top.equalTo(self.contentView.mas_top);
        make.height.equalTo(self.contentView.mas_height);
    }];
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.textColor = kColorWithRGB(34, 34, 34);
        _titleLabel.font = [UIFont systemFontOfSize:14.0];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}

- (UIButton *)selectBtn{
    if (!_selectBtn) {
        _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_selectBtn setImage:kGetImage(@"unSelect_btn") forState:UIControlStateNormal];
//        [_selectBtn setImage:kGetImage(@"selected_btn") forState:UIControlStateSelected];
        [_selectBtn setImage:kGetImage(@"music_btn_selected") forState:UIControlStateSelected];
        _selectBtn.userInteractionEnabled = NO;
    }
    return _selectBtn;
}


- (void)updateCellWithState:(BOOL)select{
    self.selectBtn.selected = select;
    _isSelected = select;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end
