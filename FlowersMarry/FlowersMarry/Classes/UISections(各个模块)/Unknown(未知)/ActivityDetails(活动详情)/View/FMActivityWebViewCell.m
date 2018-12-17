//
//  FMActivityWebViewCell.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/10/23.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "FMActivityWebViewCell.h"
#import <WebKit/WebKit.h>

@interface FMActivityWebViewCell()<WKNavigationDelegate>

@property (nonatomic, strong) WKWebView *webView;
/// 记录最后的height
@property (nonatomic, assign) CGFloat endHeight;

@end

@implementation FMActivityWebViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

- (void) initView{
    self.webView = [[WKWebView alloc] init];
    self.webView.frame = CGRectMake(0, 0, self.contentView.width, 0);
    self.webView.navigationDelegate = self;
    self.webView.scrollView.scrollEnabled = NO;
    [self.webView sizeToFit];
    [self.contentView addSubview:self.webView];
}

- (void)refreshWebView:(NSString *)hd_content indexPath:(NSIndexPath *)indexPath{
    NSString *headerStr = @"<header><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'></header>";
    TTLog(@"hd_content ==== %@",hd_content);
    
//    NSString *hd_c = @"<div style=\"text-align:center;\">\r\n\t<img src=\"http://pic.wed114.cn/20180525/2018052511100362367349.jpg\" title=\"263941550227454282_01.jpg\" alt=\"263941550227454282_01.jpg\"><img src=\"http://pic.wed114.cn/20180525/2018052511100486126649.jpg\" title=\"263941550227454282_02.jpg\" alt=\"263941550227454282_02.jpg\"><img src=\"http://pic.wed114.cn/20180525/2018052511100552448132.jpg\" title=\"263941550227454282_03.jpg\" alt=\"263941550227454282_03.jpg\"><img src=\"http://pic.wed114.cn/20180525/2018052511100639839859.jpg\" title=\"263941550227454282_04.jpg\" alt=\"263941550227454282_04.jpg\"><img src=\"http://pic.wed114.cn/20180525/2018052511100734539162.jpg\" title=\"263941550227454282_07.jpg\" alt=\"263941550227454282_07.jpg\"><img src=\"http://pic.wed114.cn/20180525/2018052511100837329807.jpg\" title=\"263941550227454282_08.jpg\" alt=\"263941550227454282_08.jpg\"><img src=\"http://pic.wed114.cn/20180525/2018052511100998794448.jpg\" title=\"263941550227454282_09.jpg\" alt=\"263941550227454282_09.jpg\"><img src=\"http://pic.wed114.cn/20180525/2018052511101117557981.jpg\" title=\"263941550227454282_10.jpg\" alt=\"263941550227454282_10.jpg\"><img src=\"http://pic.wed114.cn/20180525/2018052511101198374253.jpg\" title=\"263941550227454282_11.jpg\" alt=\"263941550227454282_11.jpg\"><img src=\"http://pic.wed114.cn/20180525/2018052511101305977868.jpg\" title=\"263941550227454282_12.jpg\" alt=\"263941550227454282_12.jpg\"><br></div>";
    NSString *newString = hd_content;
    
    newString =[NSString stringWithFormat:@"<html>"
                "<head>"
                
                "</style>"
                "<style>*{margin:3px 0px 3px 0px;padding:0 ;max-width:%f;}</style>"
                "</head>"
                "<body>%@</body>"
                "</html>",self.contentView.width,newString];
    [self.webView loadHTMLString:[headerStr stringByAppendingString:newString] baseURL:nil];
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange{
    TTLog(@"点击了链接URL%@",URL);
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange{
    TTLog(@"点击了图片%@",textAttachment);
    return YES;
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation*)navigation{
    
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation*)navigation{
    [webView evaluateJavaScript:@"document.body.scrollHeight"completionHandler:^(id _Nullable result,NSError * _Nullable error){
        CGFloat height = [result floatValue];
        self.webView.frame = CGRectMake(0, 0, self.contentView.width, height);
        [self updateCollectionViewHeight:height];
    }];
}

/// 更新CollectionViewHeight
- (void)updateCollectionViewHeight:(CGFloat)height {
    if (self.endHeight != height) {
        self.endHeight = height;
        self.webView.frame = CGRectMake(0, 0, self.webView.width, height);
        if (_delegate && [_delegate respondsToSelector:@selector(updateTableViewCellHeight:andheight:andIndexPath:)]) {
            [self.delegate updateTableViewCellHeight:self andheight:height andIndexPath:self.indexPath];
        }
    }
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    NSString *js = @"function changeImgWH() { \
                        var imgs = document.getElementsByTagName('img'); \
                        for (var i = 0; i < imgs.length; ++i) {\
                            var img = imgs[i];\
                            var imgW = img.width;\
                            var imgH = img.height;\
                            var s = imgH/imgW;\
                            img.style.maxWidth = %f;\
                            img.height = img.width*s; \
                        } \
                    }";
    js = [NSString stringWithFormat:js,  [UIScreen mainScreen].bounds.size.width - 15];
    [webView stringByEvaluatingJavaScriptFromString:js];
    [webView stringByEvaluatingJavaScriptFromString:@"changeImgWH()"];
}

- (void)layoutSubviews{
    [super layoutSubviews];
}

@end
