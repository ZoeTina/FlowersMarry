//
//  SCSmallTools.m
//  FlowersMarry
//
//  Created by 宁小陌 on 2018/7/24.
//  Copyright © 2018年 宁小陌. All rights reserved.
//

#import "SCSmallTools.h"

@implementation SCSmallTools

+(NSString *)getModelTime {
    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString *dateTime=[formatter stringFromDate:[NSDate date]];
    
    return dateTime;
    
}

+ (NSMutableAttributedString *)attributed:(NSString *)text color1:(UIColor *)color1 color2:(UIColor *)color2 length:(NSUInteger)length {
    NSRange range0;
    range0.location = 0;
    range0.length = text.length - length;
    
    NSRange range1;
    range1.location = text.length - length;
    range1.length = length;
    
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:text];
    [attributedText addAttribute:NSForegroundColorAttributeName value:color1 range:range0];
    [attributedText addAttribute:NSForegroundColorAttributeName value:color2 range:range1];
    
    return attributedText;
}

+ (BOOL)checkTelNumber:(NSString *) telNumber
{
    if (telNumber.length != 11)
    {
        return NO;
    }
    /**
     * 手机号码:
     * 13[0-9], 14[5,7], 15[0, 1, 2, 3, 5, 6, 7, 8, 9], 17[6, 7, 8], 18[0-9], 170[0-9]
     * 移动号段: 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
     * 联通号段: 130,131,132,155,156,185,186,145,176,1709
     * 电信号段: 133,153,180,181,189,177,1700
     */
    NSString *MOBILE = @"^1(3[0-9]|4[57]|5[0-35-9]|8[0-9]|7[0678])\\d{8}$";
    /**
     * 中国移动：China Mobile
     * 134,135,136,137,138,139,150,151,152,157,158,159,182,183,184,187,188,147,178,1705
     */
    NSString *CM = @"(^1(3[4-9]|4[7]|5[0-27-9]|7[8]|8[2-478])\\d{8}$)|(^1705\\d{7}$)";
    /**
     * 中国联通：China Unicom
     * 130,131,132,155,156,185,186,145,176,1709
     */
    NSString *CU = @"(^1(3[0-2]|4[5]|5[56]|7[6]|8[56])\\d{8}$)|(^1709\\d{7}$)";
    /**
     * 中国电信：China Telecom
     * 133,153,180,181,189,177,1700
     */
    NSString *CT = @"(^1(33|53|77|8[019])\\d{8}$)|(^1700\\d{7}$)";
    /**
     25     * 大陆地区固话及小灵通
     26     * 区号：010,020,021,022,023,024,025,027,028,029
     27     * 号码：七位或八位
     28     */
    //  NSString * PHS = @"^(0[0-9]{2})\\d{8}$|^(0[0-9]{3}(\\d{7,8}))$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    if (([regextestmobile evaluateWithObject:telNumber] == YES)
        || ([regextestcm evaluateWithObject:telNumber] == YES)
        || ([regextestct evaluateWithObject:telNumber] == YES)
        || ([regextestcu evaluateWithObject:telNumber] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

+ (NSString *)getHHMMSSFromSS:(NSInteger)totalTime {
    NSInteger seconds = totalTime;
    
    //format of hour
    NSString *str_hour = [NSString stringWithFormat:@"%02ld",seconds/3600];
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(seconds%3600)/60];
    NSString *str_second = [NSString stringWithFormat:@"%02ld",seconds%60];
    NSString *format_time = [NSString stringWithFormat:@"%@:%@:%@",str_hour,str_minute,str_second];
    return format_time;
}

+ (int)convertToInt:(NSString *)strtemp {
    int length = 0;
    char *p = (char *)[strtemp cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i = 0; i < [strtemp lengthOfBytesUsingEncoding:NSUnicodeStringEncoding]; i ++) {
        if (*p) {
            p ++;
            length ++;
        }else {
            p ++;
        }
    }
    return length;
}
//表情符号的判断
+ (BOOL)stringContainsEmoji:(NSString *)string {
    
    __block BOOL returnValue = NO;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            returnValue = YES;
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3) {
                                        returnValue = YES;
                                    }
                                } else {
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        returnValue = YES;
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        returnValue = YES;
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        returnValue = YES;
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        returnValue = YES;
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        returnValue = YES;
                                    }
                                }
                            }];
    
    return returnValue;
}


// 实现图文混排的方法
+ (NSAttributedString *) sc_initBrowseImageWithText:(NSString *) textStr{
    
    // NSTextAttachment可以将图片转换为富文本内容
    NSTextAttachment *attachment = [[NSTextAttachment alloc] init];
    attachment.image = kGetImage(@"base_liulan");
    // 通过NSTextAttachment创建富文本
    // 图片的富文本
    NSAttributedString *imageAttr = [NSAttributedString attributedStringWithAttachment:attachment];
    
    // 文字的富文本
    NSAttributedString *textAttr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@" %@",textStr] attributes:@{NSFontAttributeName:kFontSizeMedium12}];
    
    NSMutableAttributedString *mutableAttr = [[NSMutableAttributedString alloc] init];
    
    // 将图片、文字拼接
    // 如果要求图片在文字的后面只需要交换下面两句的顺序
    [mutableAttr appendAttributedString:imageAttr];
    [mutableAttr appendAttributedString:textAttr];
    
    return [mutableAttr copy];
}

+ (NSString *)imageTailoring:(NSString *)currentString width:(NSInteger)width height:(NSInteger)height{
    NSString *totalUrl = imageBaseUrl;

    //http://pic11.wed114.cn/pic6/20180514/2018051417220097963615x640_360_0.jpg
    //http://pic11.wed114.cn/pic/20180521/2018052115293270585048x300_168_0.jpg
    //http:// pic.wed114.cn/20180521//2018052115293270585048.jpg
    
    currentString = [currentString stringByReplacingOccurrencesOfString:@"beta." withString:@""];
    /// 根据 / 分割字符串
    NSArray *array = [currentString componentsSeparatedByString:@".net/"];
    /// 得到 pic
    NSArray *array1 = [array[0] componentsSeparatedByString:@"//"];
    NSArray *array2 = [array1[1] componentsSeparatedByString:@"."];
    /// 得到文件名字
    NSArray *array3 = [array[1] componentsSeparatedByString:@"."];
    
    /// 拼接 pic
    NSString *folder = [NSString stringWithFormat:@"%@/",array2[0]];
    totalUrl = [totalUrl stringByAppendingString:folder];
    /// 拼接 文件名字 20180521/2018052115293270585048
    NSString *file = [NSString stringWithFormat:@"%@",array3[0]];
    totalUrl = [totalUrl stringByAppendingString:file];
    
    NSString *suffix = [NSString stringWithFormat:@"x%ld_%ld_%@.jpg",(long)width*2,(long)height*2,environment];
    totalUrl = [totalUrl stringByAppendingString:suffix];
//    TTLog(@"%@ --- \n %@",totalUrl,currentString);
    
    return totalUrl;
}

/**
 *  去掉图片URL带有Beta.
 *
 *  @param currentString 当前URL
 *  @return 返回结果组合后的URL地址
 */
+ (NSString *)imageURLBetaReplace:(NSString *)currentString{
    NSString *totalUrl = [currentString stringByReplacingOccurrencesOfString:@"//beta." withString:@"http://"];
    return totalUrl;
}

@end
