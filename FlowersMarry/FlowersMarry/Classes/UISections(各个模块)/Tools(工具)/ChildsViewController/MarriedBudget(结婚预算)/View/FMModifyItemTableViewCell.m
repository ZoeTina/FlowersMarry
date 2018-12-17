//
//  FMModifyItemTableViewCell.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/10/11.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMModifyItemTableViewCell.h"

@implementation FMModifyItemTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    //点击整个cell时
    self.selectBtn.userInteractionEnabled = NO;
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
    }
    return self;
}

- (void) initView{
    [self addSubview:self.selectBtn];
    [self addSubview:self.titleLabel];
    
    [self.selectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(45));
        make.centerY.equalTo(self);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.selectBtn.mas_right).offset(13);
    }];
}

- (void)setModel:(FMBudgetDetailsModel *)model{
    _model = model;
    self.titleLabel.text = [NSString stringWithFormat:@"%@",model.title];
    if (model.isSelected) {
        self.selectBtn.selected = YES;
    } else {
        self.selectBtn.selected = NO;
    }
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel lz_labelWithTitle:@"" color:kTextColor51 font:kFontSizeMedium12];
    }
    return _titleLabel;
}

- (UIButton *)selectBtn{
    if (!_selectBtn) {
        _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _selectBtn.selected = NO;
        [_selectBtn setImage:kGetImage(@"unselected_tools_btn") forState:UIControlStateNormal];
        [_selectBtn setImage:kGetImage(@"selected_tools_btn") forState:UIControlStateSelected];
    }
    return _selectBtn;
}

@end
