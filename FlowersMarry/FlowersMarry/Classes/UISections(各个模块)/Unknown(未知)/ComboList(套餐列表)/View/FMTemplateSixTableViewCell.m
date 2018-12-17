//
//  FMTemplateSixTableViewCell.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/8/15.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMTemplateSixTableViewCell.h"

@implementation FMTemplateSixTableViewCell

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
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}


- (void)setMetaModel:(BusinessTaoxiMetaModel *)metaModel{
    _metaModel = metaModel;
    [self initView];
    self.titleLabel.text = self.metaModel.name;
    NSString *printStr = @"";
    for (int i=0;i<metaModel.child.count;i++) {
        BusinessTaoxiMetaChildrenModel *model = self.metaModel.child[i];
        if (i==metaModel.child.count-1) {
            printStr = [printStr stringByAppendingFormat:@"%@:%@%@",model.title,model.value,model.unit];
        }else{
            printStr = [printStr stringByAppendingFormat:@"%@:%@%@\n",model.title,model.value,model.unit];
        }
    }
    
//    printStr = [printStr stringByAppendingString:@"回忆像个说书的人\n"
//                "用充满乡音的口吻\n"
//                "跳过水坑 绕过小村\n"
//                "等相遇的缘份\n"
//                "你用泥巴捏一座城\n"
//                "说将来要娶我进门\n"
//                "转多少身 过几次门 虚掷青春\n"
//                "小小的誓言还不稳\n"
//                "小小的泪水还在撑\n"
//                "稚嫩的唇 在说离分\n"
//                "我的心里从此住了一个人\n"
//                "曾经模样小小的我们\n"
//                "那年你搬小小的板凳\n"
//                "为戏入迷我也一路跟\n"
//                "我在找那个故事里的人\n"
//                "你是不能缺少的部份\n"
//                "你在树下小小的打盹\n"
//                "小小的我傻傻等\n"
//                "回忆像个说书的人\n"
//                "用充满乡音的口吻\n"
//                "跳过水坑 绕过小村\n"
//                "等相遇的缘份\n"
//                "你用泥巴捏一座城\n"
//                "说将来要娶我进门\n"
//                "转多少身 过几次门 虚掷青春\n"
//                "小小的感动雨纷纷\n"
//                "小小的别扭惹人疼\n"
//                "小小的人 还不会吻\n"
//                "我的心里从此住了一个人\n"
//                "曾经模样小小的我们\n"
//                "那年你搬小小的板凳\n"
//                "为戏入迷我也一路跟\n"
//                "我在找那个故事里的人\n"
//                "你是不能缺少的部份\n"
//                "你在树下小小的打盹\n"
//                "小小的我傻傻等\n"
//                "我的心里从此住了一个人\n"
//                "曾经模样小小的我们\n"
//                "当初学人说爱念剧本\n"
//                "缺牙的你发音却不准\n"
//                "我在找那个故事里的人\n"
//                "你是不能缺少的部份\n"
//                "小小的手牵小小的人\n"
//                "守着小小的永恒"];
    self.subtitleLabel.text = printStr;
    [UILabel changeLineSpaceForLabel:self.subtitleLabel WithSpace:8];
}

- (void) initView{
    
    [self addSubview:self.titleLabel];
    [self addSubview:self.subtitleLabel];
    
    [self setConstraint];
}

- (void) setConstraint{
    
    CGFloat margin = 15.0;
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(@(margin));
        make.right.equalTo(self.mas_right).offset(-(margin));
    }];
    [self.subtitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(margin);
        make.bottom.equalTo(self.mas_bottom).offset(-(margin));
        make.right.equalTo(self.mas_right).offset(-(margin));
    }];

}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel lz_labelWithTitle:@"" color:kTextColor34 font:kFontSizeScBold20];
    }
    return _titleLabel;
}
- (UILabel *)subtitleLabel{
    if (!_subtitleLabel) {
        _subtitleLabel = [UILabel lz_labelWithTitle:@"" color:kTextColor136 font:kFontSizeMedium12];
    }
    return _subtitleLabel;
}
@end
