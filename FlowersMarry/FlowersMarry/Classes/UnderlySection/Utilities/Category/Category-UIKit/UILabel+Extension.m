//
//  UILabel+Extension.m
//  LZExtension
//
//  Created by 寕小陌 on 2016/12/12.
//  Copyright © 2016年 寕小陌. All rights reserved.
//

#import "UILabel+Extension.h"
#import <CoreText/CoreText.h>

@implementation UILabel (Extension)

+ (instancetype)lz_labelWithTitle:(NSString *)title color:(UIColor *)color fontSize:(CGFloat)fontSize {
    return [self lz_labelWithTitle:title color:color fontSize:fontSize alignment:NSTextAlignmentCenter];
}

+ (instancetype)lz_labelWithTitle:(NSString *)title color:(UIColor *)color fontSize:(CGFloat)fontSize alignment:(NSTextAlignment)alignment {
    
    UILabel *label = [[UILabel alloc] init];
    
    label.text = title;
    label.textColor = color;
    label.font = [UIFont systemFontOfSize:fontSize];
    label.numberOfLines = 0;
    label.textAlignment = alignment;
    [label sizeToFit];
    
    return label;
}

+ (instancetype)lz_labelWithTitle:(NSString *)title color:(UIColor *)color font:(UIFont *)font {
    return [self lz_labelWithTitle:title color:color font:font alignment:NSTextAlignmentLeft];
}

+ (instancetype)lz_labelWithTitle:(NSString *)title color:(UIColor *)color font:(UIFont *)font alignment:(NSTextAlignment)alignment {
    
    UILabel *label = [[UILabel alloc] init];
    label.text = title;
    label.textColor = color;
    label.font = font;
    label.numberOfLines = 0;
    label.textAlignment = alignment;
    [label sizeToFit];
    return label;
}


#pragma mark  /////  新增
-(CGSize)lz_messageBodyLabelwith:(float)labelwith andLabelheight:(float)labelheieht
{
    CGSize size = [self.text boundingRectWithSize:CGSizeMake(labelwith, labelheieht) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:self.font} context:nil].size;
    
    return size;
}

+(CGSize)lz_messageBodyText:(NSString *)text andSyFontofSize:(float)fontsize andLabelwith:(float)labelwith andLabelheight:(float)labelheieht
{
    CGSize size = [text boundingRectWithSize:CGSizeMake(labelwith, labelheieht) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontsize]} context:nil].size;
    
    return size;
}

+ (NSArray *)lz_getSeparatedLinesFromText:(NSString*)labelText  font:(UIFont*)labelFont  frame:(CGRect)labelFrame
{
    NSString *text = labelText;
    UIFont   *font = labelFont;
    CGRect    rect = labelFrame;
    
    CTFontRef myFont = CTFontCreateWithName((__bridge CFStringRef)([font fontName]), [font pointSize], NULL);
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:text];
    [attStr addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)myFont range:NSMakeRange(0, attStr.length)];
    
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((__bridge CFAttributedStringRef)attStr);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0,0,rect.size.width,100000));
    
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);
    
    NSArray *lines = (__bridge NSArray *)CTFrameGetLines(frame);
    NSMutableArray *linesArray = [[NSMutableArray alloc]init];
    
    for (id line in lines)
    {
        CTLineRef lineRef = (__bridge CTLineRef )line;
        CFRange lineRange = CTLineGetStringRange(lineRef);
        NSRange range = NSMakeRange(lineRange.location, lineRange.length);
        
        NSString *lineString = [text substringWithRange:range];
        [linesArray addObject:lineString];
    }
    return (NSArray *)linesArray;
}


+(CGSize)lz_messageBodyText:(NSString *)text andBoldSystemFontOfSize:(float)fontsize andLabelwith:(float)labelwith andLabelheight:(float)labelheieht
{
    CGSize size = [text boundingRectWithSize:CGSizeMake(labelwith, labelheieht) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:fontsize]} context:nil].size;
    
    return size;
}

+ (NSAttributedString *)lz_getLabelParagraph:(NSString*)text  height:(CGFloat)height{
    if (text == nil ||  text.length == 0) return nil;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:text];;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:height];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, text.length)];
    return attributedString;
}

- (CGFloat)lz_calculatedHeight {
    CGSize size = CGSizeZero;
    if (self.text.length > 0) {
        CGRect frame = [self.text boundingRectWithSize:CGSizeMake(self.frame.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName: self.font } context:nil];
        size = CGSizeMake(frame.size.width, frame.size.height + 1);
    }
    
    return size.height;
}

- (void)lz_setFont:(UIFont * _Nonnull)font fromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.text];
    [attributedString addAttribute:NSFontAttributeName value:font range:NSMakeRange(fromIndex, toIndex - fromIndex)];
    
    [self setAttributedText:attributedString];
}

@end

