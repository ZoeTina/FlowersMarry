//
//  SCEmptyDataTableViewCell.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/8/23.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "SCEmptyDataTableViewCell.h"

@implementation SCEmptyDataTableViewCell

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
    [self addSubview:self.noDataView];
    [self.noDataView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.centerY.equalTo(@100);
        make.height.equalTo(@150);
    }];
}

- (SCNoDataView *)noDataView {
    if (!_noDataView) {
        _noDataView = [[SCNoDataView alloc] initWithFrame:self.bounds
                                                imageName:@"live_k_pinglun"
                                            tipsLabelText:@"当前商家没有任何动态哦~"];
        _noDataView.userInteractionEnabled = YES;
    }
    return _noDataView;
}

@end
