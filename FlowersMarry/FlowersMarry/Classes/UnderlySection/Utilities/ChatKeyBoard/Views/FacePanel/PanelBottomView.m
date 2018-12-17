//
//  PanelBottomView.m
//  FaceKeyboard

//  Company：     SunEee
//  Blog:        devcai.com
//  Communicate: 2581502433@qq.com

//  Created by ruofei on 16/3/31.
//  Copyright © 2016年 ruofei. All rights reserved.
//

#import "PanelBottomView.h"
#import "FaceThemeModel.h"
#import "ChatKeyBoardMacroDefine.h"

@interface PanelBottomView()
/// 添加按钮
@property (nonatomic, strong) UIButton *addButton;
/// scrollView
@property (nonatomic, strong) UIScrollView *scrollView;
/// 发送按钮
@property (nonatomic, strong) UIButton *sendButton;
/// 设置按钮
@property (nonatomic, strong) UIButton *setupButton;
/// 当前高度
@property (nonatomic, assign) CGFloat height;
@end

@implementation PanelBottomView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _height = kFacePanelBottomToolBarHeight;
        [self initSubViews];
    }
    return self;
}

- (void)initSubViews {
    
//    [self addSubview:self.addButton];
    [self addSubview:self.scrollView];
    [self addSubview:self.sendButton];
    [self addSubview:self.setupButton];
}


- (void)loadfaceThemePickerSource:(NSArray *)pickerSource {
    for (int i = 0; i<pickerSource.count; i++) {
        FaceThemeModel *themeM = pickerSource[i];
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        if (i == 0) {
            btn.selected = YES;
        }
        btn.tag = i+100;
        [btn setTitle:themeM.themeDecribe forState:UIControlStateNormal];
//        [btn setImage:kGetImage(@"EmotionsEmojiHL") forState:UIControlStateNormal];
        [btn setTitleColor:kColorWithRGB(142, 142, 142) forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(subjectPicBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.frame = CGRectMake(i*_height, 0, _height, _height);
        [self.scrollView addSubview:btn];
        
        if (i == pickerSource.count - 1) {
            NSInteger pages = CGRectGetMaxX(btn.frame) / CGRectGetWidth(self.scrollView.frame) + 1;
            self.scrollView.contentSize = CGSizeMake(pages*CGRectGetWidth(self.scrollView.frame), 0);
        }
    }
}

- (void)changeFaceSubjectIndex:(NSInteger)subjectIndex {
    [self.scrollView setContentOffset:CGPointMake(subjectIndex*_height, 0) animated:YES];
    
    for (UIView *sub in self.scrollView.subviews) {
        if ([sub isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)sub;
            if (btn.tag-100 == subjectIndex) {
                btn.selected = YES;
            }else {
                btn.selected = NO;
            }
        }
    }
    
    if (subjectIndex > 0) {
        _setupButton.hidden = NO;
        _sendButton.hidden = YES;
    }else {
        _setupButton.hidden = YES;
        _sendButton.hidden = NO;
    }
    
}

#pragma mark -- 点击事件
- (void)addBtnClick:(UIButton *)sender {
    if (self.addAction) {
        self.addAction();
    }
}

- (void)sendBtnClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(panelBottomViewSendAction:)]) {
        [self.delegate panelBottomViewSendAction:self];
    }
}

- (void)setBtnClick:(UIButton *)sender {
    if (self.setAction) {
        self.setAction();
    }
}

- (void)subjectPicBtnClick:(UIButton *)sender {
    for (UIView *sub in self.scrollView.subviews) {
        if ([sub isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)sub;
            if (btn == sender) {
                sender.selected = YES;
            }else {
                btn.selected = NO;
            }
        }
    }
    
    if (sender.tag-100 > 0) {
        _setupButton.hidden = NO;
        _sendButton.hidden = YES;
    }else {
        _setupButton.hidden = YES;
        _sendButton.hidden = NO;
    }
    
    if ([self.delegate respondsToSelector:@selector(panelBottomView:didPickerFaceSubjectIndex:)]) {
        [self.delegate panelBottomView:self didPickerFaceSubjectIndex:sender.tag-100];
    }
}


#pragma mark ---- 懒加载 ----
- (UIButton *)addButton{
    if (!_addButton) {
        _addButton = [UIButton buttonWithType:UIButtonTypeContactAdd];
        _addButton.frame = CGRectMake(0, 0, _height, _height);
        [_addButton addTarget:self action:@selector(addBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addButton;
}

- (UIButton *)sendButton{
    if (!_sendButton) {
        _sendButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _sendButton.frame = CGRectMake(kScreenWidth-_height-10, 0, _height+10, _height);
        [_sendButton setTitle:@"发送" forState:UIControlStateNormal];
        [_sendButton setTitleColor:kColorWithRGB(142, 142, 142) forState:UIControlStateNormal];
        [_sendButton addTarget:self action:@selector(sendBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendButton;
}

- (UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth-_height-10, _height)];
    }
    return _scrollView;
}

- (UIButton *)setupButton{
    if (!_setupButton) {
        _setupButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _setupButton.frame = CGRectMake(kScreenWidth-_height-10, 0, _height+10, _height);
        [_setupButton setTitle:@"设置" forState:UIControlStateNormal];
        [_setupButton setTitleColor:kColorWithRGB(142, 142, 142) forState:UIControlStateNormal];
        _setupButton.hidden = YES;
        [_setupButton addTarget:self action:@selector(setBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _setupButton;
}

@end
