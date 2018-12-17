//
//  FMToolsHeaderView.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/9/25.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMToolsHeaderView.h"

@interface FMToolsHeaderView ()
{
    dispatch_source_t _timer;
}
@end

@implementation FMToolsHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = kWhiteColor;
        [self setupUI];
        [self initConstraints];
        self.imagesAvatarL.cornerRadius = self.imagesAvatarR.cornerRadius = 55.0/2;
    }
    return self;
}

- (void) setupUI{
    self.imagesAvatarL.image = kGetImage(@"user1");
    self.imagesAvatarR.image = kGetImage(@"user4");
    self.nicknameLabel.text = @"肯定是个傻子";
//    self.labelTimer.text = @"距婚礼还有156天";
    [self activeCountDownAction:self.labelTimer];
    [self addSubview:self.imagesBgView];
    [self addSubview:self.bindButton];
    [self addSubview:self.nicknameLabel];
    [self addSubview:self.imagesAvatarL];
    [self addSubview:self.imagesAvatarR];
    [self addSubview:self.editButton];
    [self addSubview:self.labelTimer];
}

#pragma mark - 倒计时计数
- (void)activeCountDownAction:(UILabel *) timeLabel {
    // 1.计算截止时间与当前时间差值
    // 倒计时的时间 测试数据
    NSString *deadlineStr = @"2018-12-19 12:00:00";
//    NSString *deadlineStr = [Utils lz_timeWithTimeIntervalString:self.activityData.hd_end_time];
    // 当前时间的时间戳
    NSString *nowStr = [Utils lz_getCurrentTime];
    // 计算时间差值
    NSInteger secondsCountDown = [Utils getDateDifferenceWithNowDateStr:nowStr deadlineStr:deadlineStr];
    
    // 2.使用GCD来实现倒计时 用GCD这个写有一个好处，跳页不会清零 跳页清零会出现倒计时错误的
    if (_timer == nil) {
        __block NSInteger timeout = secondsCountDown; // 倒计时时间
        
        if (timeout!=0) {
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
            dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0*NSEC_PER_SEC,  0); //每秒执行
            dispatch_source_set_event_handler(_timer, ^{
                if(timeout <= 0){ //  当倒计时结束时做需要的操作: 关闭 活动到期不能提交
                    dispatch_source_cancel(self->_timer);
                    self->_timer = nil;
                    dispatch_async(dispatch_get_main_queue(), ^{
                        timeLabel.text = @"当前活动已结束";
                    });
                } else { // 倒计时重新计算 时/分/秒
                    NSInteger days = (int)(timeout/(3600*24));
//                    NSInteger hours = (int)((timeout-days*24*3600)/3600);
//                    NSInteger minute = (int)(timeout-days*24*3600-hours*3600)/60;
//                    NSInteger second = timeout - days*24*3600 - hours*3600 - minute*60;
                    NSString *strTime = [NSString stringWithFormat:@"距婚礼还有 %ld 天", days];
                    
                    NSString *daysStr = [NSString stringWithFormat:@"%ld",days];
//                    NSString *hoursStr = [NSString stringWithFormat:@"%ld",hours];
//                    NSString *minuteStr = [NSString stringWithFormat:@"%ld",minute];
//                    NSString *secondStr = [NSString stringWithFormat:@"%ld",second];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:strTime];
                        // 天数大小
                        [attributedStr addAttribute:NSFontAttributeName
                                              value:kFontSizeMedium25
                                              range:NSMakeRange(6, daysStr.length)];
                        timeLabel.attributedText = attributedStr;
                    });
                    timeout--; // 递减 倒计时-1(总时间以秒来计算)
                }
            });
            dispatch_resume(_timer);
        }
    }
}

- (void) initConstraints{
    [self.imagesBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [self.bindButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(15));
        make.top.equalTo(@(kiPhoneX_T(37)));
    }];
    [self.imagesAvatarL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(12));
        make.top.equalTo(@(kiPhoneX_T(77)));
        make.height.width.equalTo(@(55));
    }];
    [self.imagesAvatarR mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@(57));
        make.height.width.centerY.equalTo(self.imagesAvatarL);
    }];
    [self.nicknameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imagesAvatarR.mas_right).offset(10);
        make.centerY.equalTo(self.imagesAvatarL);
    }];
    [self.labelTimer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-15);
        make.top.equalTo(@(kiPhoneX_T(82)));
    }];
    [self.editButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-22);
        make.top.equalTo(self.labelTimer.mas_bottom).offset(10);
    }];
}


- (UIImageView *)imagesBgView{
    if (!_imagesBgView) {
        _imagesBgView = [[UIImageView alloc] init];
        _imagesBgView.image = kGetImage(@"tools_bg_img");
    }
    return _imagesBgView;
}

- (UILabel *)nicknameLabel{
    if (!_nicknameLabel) {
        _nicknameLabel = [UILabel lz_labelWithTitle:@"" color:kWhiteColor font:kFontSizeMedium13];
    }
    return _nicknameLabel;
}

- (UILabel *)labelTimer{
    if (!_labelTimer) {
        _labelTimer = [UILabel lz_labelWithTitle:@"" color:kWhiteColor font:kFontSizeMedium10];
    }
    return _labelTimer;
}

- (UIImageView *)imagesAvatarL{
    if (!_imagesAvatarL) {
        _imagesAvatarL = [[UIImageView alloc] init];
        _imagesAvatarL.borderColor = kWhiteColor;
        _imagesAvatarL.borderWidth = 3.0;
    }
    return _imagesAvatarL;
}

- (UIImageView *)imagesAvatarR{
    if (!_imagesAvatarR) {
        _imagesAvatarR = [[UIImageView alloc] init];
        _imagesAvatarR.borderColor = kWhiteColor;
        _imagesAvatarR.borderWidth = 3.0;
    }
    return _imagesAvatarR;
}

- (UIButton *)editButton{
    if (!_editButton) {
        _editButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_editButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
        _editButton.titleLabel.font = kFontSizeMedium10;
        _editButton.tag = 3;
        [_editButton setTitle:@"编辑" forState:UIControlStateNormal];
        [_editButton setImage:kGetImage(@"mine_btn_pen") forState:UIControlStateNormal];
        //image在左，文字在右，default
        [Utils lz_setButtonTitleWithImageEdgeInsets:_editButton postition:kMVImagePositionRight spacing:5];
    }
    return _editButton;
}

- (UIButton *)bindButton{
    if (!_bindButton) {
        _bindButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_bindButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
        _bindButton.tag = 3;
        _bindButton.titleLabel.font = kFontSizeMedium12;
        [_bindButton setTitle:@"绑定伴侣" forState:UIControlStateNormal];
    }
    return _bindButton;
}
@end
