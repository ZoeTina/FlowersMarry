//
//  FMPictureWithTextCellPicture.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/6/29.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMPictureWithTextCellPicture.h"

@implementation FMPictureWithTextCellPicture

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
        [self initView];
    }
    return self;
}

- (void) initView{
    [self addSubview:self.imagesView];
    [self.imagesView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(@5);
        make.top.left.right.bottom.equalTo(self);
//        make.bottom.equalTo(self.mas_bottom).offset(-5);
    }];
}
- (UIImageView *)imagesView{
    if (!_imagesView) {
        _imagesView = [[UIImageView alloc] init];
    }
    return _imagesView;
}


@end
