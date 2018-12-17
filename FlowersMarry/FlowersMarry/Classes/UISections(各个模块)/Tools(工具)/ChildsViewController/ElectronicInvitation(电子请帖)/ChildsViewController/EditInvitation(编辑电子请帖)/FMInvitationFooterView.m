//
//  FMInvitationFooterView.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/11/2.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMInvitationFooterView.h"

@implementation FMInvitationFooterView


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kWhiteColor;
        [self setupUI];
    }
    return self;
}

- (void) handleControlEvent:(UIButton *)sender{
    MV(weakSelf)
    if (weakSelf.block) {
        weakSelf.block(sender.tag);
    }
}

- (void) setupUI{
    [self addSubview:self.addButton];
    [self addSubview:self.sortButton];
    [self addSubview:self.setupButton];
    [self addSubview:self.previewButton];
    [self addSubview:self.sendButton];
    
    [self.sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.equalTo(self);
        make.height.equalTo(@(49));
        make.width.equalTo(@(128));
    }];
    
    CGFloat width = (kScreenWidth - 128 - 3) / 4;
    [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(3));
        make.centerY.height.equalTo(self.sendButton);
        make.width.equalTo(@(width));
    }];
    [self.sortButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.addButton.mas_right).offset(0);
        make.width.height.centerY.equalTo(self.addButton);
    }];
    
    [self.setupButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.sortButton.mas_right);
        make.width.height.centerY.equalTo(self.addButton);
    }];
    
    [self.previewButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.setupButton.mas_right);
        make.width.height.centerY.equalTo(self.addButton);
    }];
}

- (void) buttonWithTitle:(NSString *)title image:(UIImage *)image button:(UIButton *)sender{
    [sender setTitle:title forState:UIControlStateNormal];
    [sender setImage:image forState:UIControlStateNormal];
    [sender setImage:image forState:UIControlStateSelected];
    sender.titleLabel.font = kFontSizeMedium14;
    CGFloat spacing = 3;
    //image在左，文字在右，default
    [Utils lz_setButtonTitleWithImageEdgeInsets:sender postition:kMVImagePositionTop spacing:spacing];
    [sender setTitleColor:kColorWithRGB(102, 102, 102) forState:UIControlStateNormal];
    [sender setTitleColor:kColorWithRGB(102, 102, 102) forState:UIControlStateHighlighted];
    MV(weakSelf);
    [sender lz_handleControlEvent:UIControlEventTouchUpInside withBlock:^{
        [weakSelf handleControlEvent:sender];
    }];
}

- (UIButton *)addButton{
    if (!_addButton) {
        _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self buttonWithTitle:@"加页" image:kGetImage(@"tools_invitation_jiaye") button:_addButton];
        _addButton.tag = 101;
    }
    return _addButton;
}

- (UIButton *)sortButton{
    if (!_sortButton) {
        _sortButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self buttonWithTitle:@"排序" image:kGetImage(@"tools_invitation_paixu") button:_sortButton];
        _sortButton.tag = 102;
    }
    return _sortButton;
}

- (UIButton *)setupButton{
    if (!_setupButton) {
        _setupButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self buttonWithTitle:@"设置" image:kGetImage(@"tools_invitation_shezhi") button:_setupButton];
        _setupButton.tag = 103;
    }
    return _setupButton;
}

- (UIButton *)previewButton{
    if (!_previewButton) {
        _previewButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self buttonWithTitle:@"预览" image:kGetImage(@"tools_invitation_yulan") button:_previewButton];
        _previewButton.tag = 104;
    }
    return _previewButton;
}

- (UIButton *)sendButton{
    if (!_sendButton) {
        _sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sendButton setBackgroundImage:imageColor(kColorWithRGB(255, 65, 99)) forState:UIControlStateNormal];
        _sendButton.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [_sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [_sendButton setTitle:@"发送" forState:UIControlStateNormal];
    }
    return _sendButton;
}
@end
