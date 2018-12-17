//
//  FMPreviewTemplateViewController.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/11/5.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMPreviewTemplateViewController.h"
#import <WebKit/WebKit.h>
#import "FMBasicInformationViewController.h"

@interface FMPreviewTemplateViewController ()<WKNavigationDelegate, WKUIDelegate>

@property (nonatomic, strong) UIButton *startedMakingBtn;
@property (nonatomic, strong) WKWebView *wkWebView;
@property (nonatomic, strong)  UIButton *reloadButton;
@property (nonatomic, copy) NSString *webUrl;
@property (nonatomic, strong) UIProgressView *progress;
@property (nonatomic, strong) InvitationModel *invitationModel;

@end

@implementation FMPreviewTemplateViewController
- (id)initInvitationModel:(InvitationModel *)invitationModel{
    if ( self = [super init] ){
        self.invitationModel = invitationModel;
        self.webUrl = self.invitationModel.url;
        [self loadData];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.wkWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    self.wkWebView.navigationDelegate = self;
    self.wkWebView.UIDelegate = self;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.wkWebView removeObserver:self forKeyPath:@"estimatedProgress"];
    self.wkWebView.navigationDelegate = nil;
    self.wkWebView.UIDelegate = nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.webUrl = @"http://www.baidu.com";
    [self initView];
    self.reloadButton.layer.zPosition = 2;
    [self.startedMakingBtn setTitle:@"开始制作" forState:UIControlStateNormal];
//    if (self.pageType) {
//        [self.startedMakingBtn setTitle:@"开始制作" forState:UIControlStateNormal];
//    }else{
//        [self.startedMakingBtn setTitle:@"发送" forState:UIControlStateNormal];
//    }
}

- (void)initView {
    [self.view addSubview:self.wkWebView];
    
    [self.view addSubview:self.startedMakingBtn];
    [self.view addSubview:self.reloadButton];
    [self.startedMakingBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).offset(0);
        make.width.equalTo(self.view);
        make.height.equalTo(@(45));
    }];
    [self.reloadButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.centerX.equalTo(self.view);
    }];
    
    [self.wkWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_offset(0);
        make.bottom.equalTo(self.startedMakingBtn.mas_top).mas_offset(0);
    }];
    
    [self.view addSubview:self.progress];
    [self.progress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_offset(0);
        make.height.mas_equalTo(1);
    }];
}

//// 加载数据
- (void)loadData {
    if (self.webUrl.length == 0 || ![self.webUrl hasPrefix:@"http:"]) {
        MVLog(@"缺少链接");
        return;
    }
    NSURL* url = [NSURL URLWithString:self.webUrl];
    NSURLRequest* request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15];
    [self.wkWebView loadRequest:request];
    
}

- (void) handleButtonTapped:(UIButton *)sender{
    if (sender.tag == 100) {
        self.wkWebView.hidden = NO;
        self.reloadButton.hidden = YES;
        [self.wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.webUrl]]];
    }else{
//        if (self.pageType) {//制作
        FMBasicInformationViewController *vc = [[FMBasicInformationViewController alloc] initInvitationModel:self.invitationModel];
        TTPushVC(vc);
//        }else{//发送
//            FMSendInvitationViewController *vc = [[FMSendInvitationViewController alloc] init];
//            [self.navigationController pushViewController:vc animated:YES];
//        }
    }
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        float estimateProgress = [change[NSKeyValueChangeNewKey] doubleValue];
        [self.progress setProgress:estimateProgress animated:YES];
    }
}

#pragma mark - WKNavigationDelegate
///页面开始加载
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    self.reloadButton.hidden = YES;
    self.wkWebView.hidden = NO;
    [self.progress setHidden:NO];
    [self.progress setProgress:0.1 animated:YES];
}

/// 5 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [self.progress setProgress:1.0 animated:YES];
    [self.progress setHidden:YES];
}

/// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    self.reloadButton.hidden = NO;
    self.wkWebView.hidden = YES;
    [self.progress setHidden:YES];
}

- (UIProgressView *)progress {
    if (!_progress) {
        _progress = [[UIProgressView alloc] initWithProgressViewStyle:UIProgressViewStyleBar];
        _progress.frame = CGRectMake(0, 0, self.wkWebView.width, 1);
        _progress.progressTintColor= kColorWithRGB(27, 230, 71);//设置已过进度部分的颜色
        _progress.trackTintColor= kColorWithRGB(210, 210, 210);//设置未过进度部分的颜色
        _progress.backgroundColor = [UIColor groupTableViewBackgroundColor];//设置背景色
        [self.view insertSubview:_progress aboveSubview:self.navigationController.navigationBar];
    }
    return _progress;
}

- (WKWebView *)wkWebView {
    if (!_wkWebView) {
        
        WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
        
        WKPreferences *preferences = [WKPreferences new];
        preferences.javaScriptCanOpenWindowsAutomatically = YES;
        preferences.minimumFontSize = 40.0;
        configuration.preferences = preferences;
        _wkWebView = [[WKWebView alloc] initWithFrame:CGRectZero configuration:configuration];
        _wkWebView.scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _wkWebView.backgroundColor = [UIColor whiteColor];
        _wkWebView.scrollView.backgroundColor = [UIColor whiteColor];
        _wkWebView.scrollView.showsVerticalScrollIndicator = false;
        _wkWebView.scrollView.showsHorizontalScrollIndicator = false;
        
        DisableAutoAdjustScrollViewInsets(_wkWebView.scrollView, self);
    }
    return _wkWebView;
}

- (UIButton *)startedMakingBtn{
    if (!_startedMakingBtn) {
        _startedMakingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_startedMakingBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_startedMakingBtn setBackgroundImage:imageHexString(@"#FF4163") forState:UIControlStateNormal];
        [_startedMakingBtn setTitle:@"开始制作" forState:UIControlStateNormal];
        _startedMakingBtn.titleLabel.font = kFontSizeMedium16;
        _startedMakingBtn.tag = 101;
        MV(weakSelf);
        [_startedMakingBtn lz_handleControlEvent:UIControlEventTouchUpInside withBlock:^{
            [weakSelf handleButtonTapped:weakSelf.startedMakingBtn];
        }];
    }
    return _startedMakingBtn;
}

- (UIButton *)reloadButton{
    if (!_reloadButton) {
        _reloadButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_reloadButton setTitleColor:HexString(@"#FF4163") forState:UIControlStateNormal];
        [_reloadButton setTitle:@"重新加载" forState:UIControlStateNormal];
        _reloadButton.titleLabel.font = kFontSizeMedium15;
        _reloadButton.tag = 100;
        MV(weakSelf);
        [_reloadButton lz_handleControlEvent:UIControlEventTouchUpInside withBlock:^{
            [weakSelf handleButtonTapped:weakSelf.reloadButton];
        }];
    }
    return _reloadButton;
}

@end
