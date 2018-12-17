//
//  SCMatchLabel.h
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/25.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 
 self.textLabel.text = @"#SCLabel# 用于匹配字符串的内容显示, 用户:@盼盼, 包括话题:#怎么追漂亮女孩?#, 链接:https://www.baidu.com, 协议:《退款政策》, 还有自定义要 高亮显示 的字符串.";
 
 // 非匹配内容文字颜色
 self.textLabel.textColorNormal = kColorWithRGB(112.0, 93.0, 77.0);
 
 // 点选高亮文字颜色
 self.textLabel.textHightLightBackgroundColor = kColorWithRGB(237.0, 213.0, 177.0);
 
 // 匹配文字颜色
 [self.textLabel setHightLightTextColor:kColorWithRGB(132.0, 77.0, 255.0) forHandleStyle:HandleStyleUser];
 [self.textLabel setHightLightTextColor:kColorWithRGB(9.0, 163.0, 213.0) forHandleStyle:HandleStyleLink];
 [self.textLabel setHightLightTextColor:kColorWithRGB(254.0, 156.0, 59.0) forHandleStyle:HandleStyleTopic];
 [self.textLabel setHightLightTextColor:kColorWithRGB(255.0, 69.0, 0.0) forHandleStyle:HandleStyleAgreement];
 
 // 自定义匹配的文字和颜色#8FDF5C
 self.textLabel.matchArr = @[
 @{
 @"string" : @"高亮显示",
 @"color" : kColorWithRGB(0.55, 0.86, 0.34)
 }
 ];
 
 // 匹配到合适内容的回调
 self.textLabel.tapOperation = ^(UILabel *label, SCHandleStyle style, NSString *selectedString, NSRange range){
 
 // 你想要做的事
 TTLog(@"block打印 %@", selectedString);
 
 if (style == HandleStyleLink) {
 }
 self.textLabel.delegate = self;
 
 #pragma mark --------------------------------------------------
 #pragma mark SCMatchLabelDelegate
 
 -(void)sc_label:(SCMatchLabel *)label didSelectedString:(NSString *)selectedStr forStyle:(SCHandleStyle)style inRange:(NSRange)range{
 
 // 你想要做的事
 NSLog(@"代理打印 %@", selectedStr);
 }
 */

typedef NS_ENUM(NSUInteger, SCHandleStyle) {
    SCHandleStyleNone = 0,
    SCHandleStyleUser = 1,
    SCHandleStyleTopic = 2,
    SCHandleStyleLink = 3,
    SCHandleStyleAgreement = 4,
    SCHandleStyleUserDefine = 5
};

@class SCMatchLabel;

@protocol SCMatchLabelDelegate <NSObject>

@optional

-(void)sc_label:(SCMatchLabel *)label didSelectedString:(NSString *)selectedStr forStyle:(SCHandleStyle)style inRange:(NSRange)range;

@end

typedef void(^TapHandle)(UILabel *, SCHandleStyle, NSString *, NSRange);


@interface SCMatchLabel : UILabel

/** 普通文字颜色 */
@property(nonatomic, strong)UIColor *textColorNormal;

/** 选中时高亮背景色 */
@property(nonatomic, strong)UIColor *textHightLightBackgroundColor;

/** 给不同种类的高亮文字设置颜色*/
-(void)setHightLightTextColor:(UIColor *)hightLightColor forHandleStyle:(SCHandleStyle)handleStyle;

/** 自定义要高亮匹配的 字符串+显示颜色 字典数组, 请把要匹配的文字用string这个key存入字典, 把要高亮的颜色用color这个key存入字典, 具体见demo */
@property(nonatomic, strong)NSArray<NSDictionary *> *matchArr;

/** 点击事件block */
@property(nonatomic, strong)TapHandle tapOperation;

/** delegate */
@property(nonatomic, weak)id<SCMatchLabelDelegate> delegate;

@end
