//
//  Utils.m
//  LZKit
//
//  Created by 寕小陌 on 2016/12/15.
//  Copyright © 2016年 寜小陌. All rights reserved.
//


/*********************************************
 ******
 ******        自定义公共的方法
 ******
 *********************************************/

#import "Utils.h"
#import <UIKit/UIKit.h>
@implementation Utils

/**
 *  加载tabelViewCell
 *
 *  @param tableViewCell tableViewCell
 *  @param index         第几个视图
 */
+ (UITableViewCell *) lz_loadCellNib:(UITableViewCell *) tableViewCell objectAtIndex:(NSUInteger)index{

    UITableViewCell *cell;
//    UITableViewCell *cell1= (tableViewCell *)[[[NSBundle  mainBundle]  loadNibNamed:tableViewCell owner:self options:nil]  objectAtIndex:index];
    return cell;
}

// 19.按照文字计算高度
- (void)lz_descHeightWithDesc:(NSString *)desc{
    
    CGRect rect = [desc boundingRectWithSize:CGSizeMake(240, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:@""} context:nil];
    //按照文字计算高度
    float textHeight = rect.size.height;
    TTLog(@"%f", textHeight);
//    CGRect frame = self.descLabel.frame;
//    frame.size.height = textHeight;
//    self.descLabel.frame = frame;
    
}

//图片转字符串
-(NSString *)lz_UIImageToBase64Str:(UIImage *) image{
    NSData *data = UIImageJPEGRepresentation(image, 1.0f);
    NSString *encodedImageStr = [data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return encodedImageStr;
}

//字符串转图片
-(UIImage *)lz_Base64StrToUIImage:(NSString *)_encodedImageStr
{
//    NSData *_decodedImageData   = [[NSData alloc] initWithBase64Encoding:_encodedImageStr];
    NSData *_decodedImageData   = [[NSData alloc] initWithBase64EncodedString:_encodedImageStr options:0];
    UIImage *_decodedImage      = [UIImage imageWithData:_decodedImageData];
    return _decodedImage;
}

/**
 *  设置UILabel背景透明
 *
 *  @param label 当前label
 *
 *  @return 设置后的label
 */
+ (UILabel *) lz_setLabelTransparent:(UILabel *) label{

    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor colorWithRed:0.1f green:0.1f blue:0.1f alpha:0.4f];
    label.layer.cornerRadius = 8;
    label.clipsToBounds = YES;
    
    return label;
}

#pragma mark - 读取plist的文件数据
//-------------------------------------------------------------------------------------------------------------------------------------------------
+ (NSArray *) lz_loadLocalResources :(NSString *) fileName
//-------------------------------------------------------------------------------------------------------------------------------------------------
{
    NSString *paths = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
    NSArray *data = [NSArray arrayWithContentsOfFile:paths];
    
    return data;
}

#pragma mark --- 清除tableView多余分割线
//-------------------------------------------------------------------------------------------------------------------------------------------------
/** 清除tableView多余分割线 */
+ (UITableView *)lz_setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    return tableView;
}

/**
 *  生成图片
 *
 *  @param color  图片颜色
 *
 *  @return 生成的图片
 */
+ (UIImage *) lz_imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);   //图片尺寸
    UIGraphicsBeginImageContext(rect.size);             //填充画笔
    CGContextRef context = UIGraphicsGetCurrentContext();//根据所传颜色绘制
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);                       //联系显示区域
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();// 得到图片信息
    UIGraphicsEndImageContext();//消除画笔
    
    return image;
}

/**
 *  设置公共按钮背景图(视频播放以及直播界面底部按钮)
 *
 *  @param button 需要设置的按钮
 *  @param cornerRadius 圆角大小
 *  @return 返回已经设置好的内容
 */
+ (UIButton *) lz_setButtonWithBGImage:(UIButton *) button cornerRadius:(CGFloat)cornerRadius{

    button.tintColor = [UIColor whiteColor];
//    button.titleLabel.font = kFontSizeMedium15;
    button.layer.cornerRadius = cornerRadius;
    button.layer.masksToBounds = YES;
//    [button setBackgroundImage:[Utils lz_imageWithColor:kButtonColorNormal] forState:UIControlStateNormal];
//    [button setBackgroundImage:[Utils lz_imageWithColor:kButtonColorHighlighted] forState:UIControlStateHighlighted];
    return button;
}

/**
 *  11. 将十六进制颜色转换为 UIColor 对象
 *
 *  @param color 颜色值
 *
 *  @return 将十六进制颜色转换为 UIColor 对象
 */
+ (UIColor *)lz_colorWithHexString:(NSString *)color{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    // strip "0X" or "#" if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}

#pragma mark -- 标签自适应，测算高度
/**
 *  设置公共按钮背景图
 *
 *  @param text 文字内容
 *  @param font 文字字体
 *  @param maxW 最大宽度
 *
 *  @return 返回已经设置好的内容
 */
+ (CGSize)lz_sizeWithText:(NSString *)text font:(UIFont *)font maxW:(CGFloat)maxW {
    
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSFontAttributeName] = font;
    CGSize textSize = CGSizeMake(maxW, MAXFLOAT);
    return [text boundingRectWithSize:textSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attr context:nil].size;
}

/**
 *  时间戳转换为时间
 *
 *  @param timeString 时间戳
 *
 *  @return 返回字符串格式时间
 */
+ (NSString *)lz_timeWithTimeIntervalString:(NSString *)timeString{
    
    NSTimeInterval interval = [timeString doubleValue] + 28800;//因为时差问题要加8小时 == 28800 sec
    NSDate *detaildate = [NSDate dateWithTimeIntervalSince1970:interval];
    TTLog(@"date:%@",[detaildate description]);
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString*currentDateStr = [dateFormatter stringFromDate:detaildate];
    TTLog(@"时间戳转换后的日期时间:%@",currentDateStr);
    return currentDateStr;
}

/**
 *  获取当前系统时间
 *
 *  @return 返回字符串格式时间
 */
+ (NSString *)lz_getCurrentTime {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyy-MM-dd HH:mm:ss"];
    NSString*dateTime = [formatter stringFromDate:[NSDate date]];
    TTLog(@"当前时间是===%@",dateTime);
    return dateTime;
}

/**
 *  获取当前系统日期
 *
 *  @return 返回字符串格式时间
 */
+ (NSString*)lz_getCurrentDate {
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyy-MM-dd"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    NSLog(@"当前日期===%@",dateTime);
    return dateTime;
}

/**
 *  获取当前时间的时间戳
 *
 *  @return 返回字符串格式时间时间戳
 */
+ (NSString*)lz_getCurrentTimestamp{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a = [dat timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%0.f", a];//转为字符型
    NSLog(@"当前时间是时间戳===%@",timeString);
    
    return timeString;
}


/**
 *  获取时间差值  截止时间-当前时间
 *  nowDateStr : 当前时间
 *  deadlineStr : 截止时间
 *  @return 时间戳差值
 */
+ (NSInteger)getDateDifferenceWithNowDateStr:(NSString*)nowDateStr deadlineStr:(NSString*)deadlineStr {
    
    NSInteger timeDifference = 0;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yy-MM-dd HH:mm:ss"];
    NSDate *nowDate = [formatter dateFromString:nowDateStr];
    NSDate *deadline = [formatter dateFromString:deadlineStr];
    NSTimeInterval oldTime = [nowDate timeIntervalSince1970];
    NSTimeInterval newTime = [deadline timeIntervalSince1970];
    timeDifference = newTime - oldTime;
    
    return timeDifference;
}

/**
 *  据图片名将图片保存到ImageFile文件夹中
 *
 *  @param imageName 图片名称
 *
 *  @return 返回字符串格式时间
 */
+ (NSString *)lz_imageSavedPath :(NSString *) imageName{
    
    //获取Documents文件夹目录
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [path objectAtIndex:0];
    //获取文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //指定新建文件夹路径
    NSString *imageDocPath = [documentPath stringByAppendingPathComponent:@"ImageFile"];
    //创建ImageFile文件夹
    [fileManager createDirectoryAtPath:imageDocPath withIntermediateDirectories:YES attributes:nil error:nil];
    //返回保存图片的路径（图片保存在ImageFile文件夹下）
    NSString * imagePath = [imageDocPath stringByAppendingPathComponent:imageName];
    return imagePath;
    
}

/**
 *  解析编码格式
 *
 *  @param responseObject 解析的数据
 *
 *  @return 返回字符串格式
 */
+ (NSString *) lz_dataWithJSONObject:(NSDictionary *) responseObject{

    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:nil];
    NSString *json  = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return json;
}

/**
 *  解析编码格式(数组)
 *
 *  @param responseObject 数组
 *  @return 返回字符串格式
 */
+ (NSString *) lz_arrayWithJSONObject:(NSMutableArray *) responseObject{
    NSString *json = [self lz_dataWithJSONObject:@{@"data":responseObject}];
    return json;
}

/**
 *  将数字转换为 时、分、秒、
 *
 *  @param totalSeconds 时间转换
 *
 *  @return 返回字符串格式
 */
+ (NSString *)lz_timeFormatted:(int)totalSeconds {
    
    int seconds = totalSeconds % 60;
    int minutes = (totalSeconds / 60) % 60;
//    int hours = totalSeconds / 3600;
    
    return [NSString stringWithFormat:@"%02d:%02d",minutes, seconds];
}

/**
 *  设置searchBar的背景色使用的
 *
 *  @param size searchBar 的size
 *
 *  @return 返回设置好的图片
 */
+ (UIImage *)lz_imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

/**
 *  银行卡字符串格式化
 *  参数 str 银行卡号
 */
+ (NSString *)lz_backCardOrFormatString:(NSString *) string{
    string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSString *newString = @"";
    while (string.length > 0) {
        NSString *subString = [string substringToIndex:MIN(string.length, 4)];
        newString = [newString stringByAppendingString:subString];
        if (subString.length == 4) {
            newString = [newString stringByAppendingString:@" "];
        }
        string = [string substringFromIndex:MIN(string.length, 4)];
    }
    
    return newString;
}

/**
 *  银行卡字符串格式化星号显示
 *  参数 bankCard 银行卡号
 */
+ (NSString*) lz_bankCardToAsterisk:(NSString *) bankCard{
    

    // 后四位
    bankCard = [bankCard substringFromIndex:bankCard.length - 4];
    NSString *string = [NSString stringWithFormat:@"************%@",bankCard];
    
    return string;
}

/**
 *  获取当前的ViewController
 *
 *  @return 返回当前的ViewController
 */
- (UIViewController *)lz_getCurrentVC
{
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        
        result = nextResponder;
    else
        
        result = window.rootViewController;
    return result;
}

/**
 *  设置UILabel的字体和颜色
 *  参数 label 需要被设置的UILabel
 */
+ (void) setLabelFontOrColor:(UILabel *) label{
    
//    label.textColor = kTitleColor52;
//    label.font = kFontSizeMedium13;
}
/**
 *  设置UILabel的字体和颜色
 *  参数 label 需要被设置的UILabel
 *  参数 color 需要设置的颜色
 *  参数 font  需要设置的字体
 */
+ (void) setLabelFontOrColor:(UILabel *) label color:(UIColor *) color font:(UIFont *) font{
    label.textColor = color;
    label.font = font;
}

/**
 *  设置UITextField的字体和颜色
 *  参数 textField 需要被设置的UITextField
 */
+ (void) setTextFieldFontOrColor:(UITextField *) textField{
    
//    textField.textColor = kTitleColor52;
//    textField.font = kFontSizeMedium13;
}

/// 调整图片大小
+ (UIImage *)lz_scaleToSize:(UIImage *)image size:(CGSize)size{
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height+20)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}
/**
 *  设置按钮图片与文字的位置间隔
 *  利用UIButton的titleEdgeInsets和imageEdgeInsets来实现文字和图片的自由排列
 *  注意：这个方法需要在设置图片和文字之后才可以调用，且button的大小要大于 图片大小+文字大小+spacing
 *
 *  @param button 按钮
 *  @param spacing 间距
 */
+ (void)lz_setButtonTitleWithImageEdgeInsets:(UIButton *)button postition:(MVImagePosition)postition spacing:(CGFloat)spacing{
    button.imageEdgeInsets = UIEdgeInsetsMake(0, -spacing/2, 0, spacing/2);
    button.titleEdgeInsets = UIEdgeInsetsMake(0, spacing/2, 0, -spacing/2);
    [button setImagePosition:postition spacing:spacing];
}

/**
 *  让视图单独显示某一侧的边框线
 *
 *  @param view 需要设置的视图
 *  @param top 是否需要显示top边线
 *  @param left 是否需要显示left边线
 *  @param bottom 是否需要显示bottom边线
 *  @param right 是否需要显示right边线
 *  @param color 边框线的颜色
 *  @param width 边框的宽度
 */
+ (void)setBorderWithView:(UIView *)view top:(BOOL)top left:(BOOL)left bottom:(BOOL)bottom right:(BOOL)right borderColor:(UIColor *)color borderWidth:(CGFloat)width {
    if (top) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, 0, view.frame.size.width, width);
        layer.backgroundColor = color.CGColor;
        [view.layer addSublayer:layer];
    }
    if (left) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, 0, width, view.frame.size.height);
        layer.backgroundColor = color.CGColor;
        [view.layer addSublayer:layer];
    }
    if (bottom) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(0, view.frame.size.height - width, view.frame.size.width, width);
        layer.backgroundColor = color.CGColor;
        [view.layer addSublayer:layer];
    }
    if (right) {
        CALayer *layer = [CALayer layer];
        layer.frame = CGRectMake(view.frame.size.width - width, 0, width, view.frame.size.height);
        layer.backgroundColor = color.CGColor;
        [view.layer addSublayer:layer];
    }
}

+(void)settingLabelTextAttributesWithLineSpacing:(CGFloat)lineSpacing FirstLineHeadIndent:(CGFloat)firstLineHeadIndent FontOfSize:(CGFloat)fontOfSize TextColor:(UIColor *)textColor text:(NSString *)text AddLabel:(UILabel *)label{
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    //行间距
    paragraphStyle.lineSpacing = lineSpacing;
    //首行缩进 (缩进个数 * 字号)
    paragraphStyle.firstLineHeadIndent = firstLineHeadIndent * fontOfSize;
    
    NSDictionary *attributeDic = @{
                                   
                                   NSFontAttributeName : [UIFont systemFontOfSize:fontOfSize],
                                   
                                   NSParagraphStyleAttributeName : paragraphStyle,
                                   
                                   NSForegroundColorAttributeName : textColor
                                   
                                   };
    
    label.attributedText = [[NSAttributedString alloc] initWithString:text attributes:attributeDic];
    
}

/**
 *  对字典(Key-Value)排序 不区分大小写
 *
 *  @param dictionary 要排序的字典
 */
+ (NSString *)sortedDictionarybyCaseConversion:(NSMutableDictionary *)dictionary{
    
    //将所有的key放进数组
    NSArray *allKeyArray = [dictionary allKeys];
    //序列化器对数组进行排序的block 返回值为排序后的数组
    NSArray *afterSortKeyArray = [allKeyArray sortedArrayUsingComparator:^NSComparisonResult(id _Nonnull obj1, id _Nonnull obj2) {
        /**
         In the compare: methods, the range argument specifies the
         subrange, rather than the whole, of the receiver to use in the
         comparison. The range is not applied to the search string.  For
         example, [@"AB" compare:@"ABC" options:0 range:NSMakeRange(0,1)]
         compares "A" to "ABC", not "A" to "A", and will return
         NSOrderedAscending. It is an error to specify a range that is
         outside of the receiver's bounds, and an exception may be raised.
         
         - (NSComparisonResult)compare:(NSString *)string;
         
         compare方法的比较原理为,依次比较当前字符串的第一个字母:
         如果不同,按照输出排序结果
         如果相同,依次比较当前字符串的下一个字母(这里是第二个)
         以此类推
         
         排序结果
         NSComparisonResult resuest = [obj1 compare:obj2];为从小到大,即升序;
         NSComparisonResult resuest = [obj2 compare:obj1];为从大到小,即降序;
         
         注意:compare方法是区分大小写的,即按照ASCII排序
         */
        //小写转化：lowercaseString 大写转换：uppercaseString
        obj1 = [obj1 uppercaseString];
        obj2 = [obj2 uppercaseString];
        //排序操作
        NSComparisonResult resuest = [obj1 compare:obj2];
        return resuest;
    }];
//    TTLog(@"Sort After Key Array:%@",afterSortKeyArray);
    
    //通过排列的key值获取value
    NSMutableArray *valueArray = [NSMutableArray array];
    NSString *signString = @"";
    for (NSString *sortsing in afterSortKeyArray) {
        NSString *valueString = [dictionary objectForKey:sortsing];
        [valueArray addObject:valueString];
        NSString *k_v = [NSString stringWithFormat:@"%@=%@&",sortsing,valueString];
        signString = [signString stringByAppendingString:k_v];

    }
    signString = [signString stringByAppendingString:@"-"];
    /// 分割
    NSArray *segmentationArray = [signString componentsSeparatedByString:@"&-"];
    NSString *segmentationAfterstr = [segmentationArray[0] uppercaseString];
//    TTLog(@"大小写转换str --- - %@",segmentationAfterstr);
//    TTLog(@"dictionary value:%@",valueArray);
    
//    if (kUserInfo.sid.length>=0) {
//        segmentationAfterstr = segmentationAfterstr.sc_md5String;
//    }else{
//        segmentationAfterstr = [segmentationAfterstr stringByAppendingString:@"wed.114@&%detclkq$"];
//    }
    TTLog(@"大小写转换str --- - %@",segmentationAfterstr);

    return segmentationAfterstr;
}

/**
 *  根据状态 转换 类型
 *
 *  @param status 状态 0:待审核 1:已通过 2:拒绝 3:管理员关闭 4:已过期 5:待上线 9:回收站 10:草稿 11:修改后提交 12:结束 13:商家关闭 21:商家的商铺关闭
 *
 *  @return 返回字符串格式时间
 */
+ (NSString *)lz_conversionState :(NSInteger) status{
    NSString *statusStr = @"";
    switch (status) {
        case 0:
            statusStr = @"待审核";
            break;
        case 1:
            statusStr = @"已通过";
            break;
        case 2:
            statusStr = @"未通过";
            break;
        case 3:
            statusStr = @"管理员关闭";
            break;
        case 4:
            statusStr = @"已过期";
            break;
        case 5:
            statusStr = @"待上线";
            break;
        case 9:
            statusStr = @"回收站";
            break;
        case 10:
            statusStr = @"草稿";
            break;
        case 11:
            statusStr = @"修改后提交";
            break;
        case 12:
            statusStr = @"结束";
            break;
        case 13:
            statusStr = @"商家关闭";
            break;
        case 21:
            statusStr = @"商家的商铺关闭";
            break;
    }
    return statusStr;
}

@end
