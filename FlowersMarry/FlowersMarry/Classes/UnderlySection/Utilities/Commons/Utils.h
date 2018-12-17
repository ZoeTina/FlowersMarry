//
//  Utils.h
//  LZKit
//
//  Created by 寕小陌 on 2016/12/15.
//  Copyright © 2016年 寜小陌. All rights reserved.
//

#import <Foundation/Foundation.h>

/***************************************************************************
 *
 * 工具类
 *
 ***************************************************************************/
@interface Utils : NSObject

/**
 *  加载tabelViewCell
 *
 *  @param tableViewCell tableViewCell
 *  @param index         第几个视图
 */
+ (UITableViewCell *) lz_loadCellNib:(UITableViewCell *) tableViewCell objectAtIndex:(NSUInteger)index;

/**
 *  设置UILabel北背景透明
 *
 *  @param label 当前label
 *
 *  @return 设置后的label
 */
+ (UILabel *) lz_setLabelTransparent:(UILabel *) label;

#pragma mark - 读取plist的文件数据
//-------------------------------------------------------------------------------------------------------------------------------------------------
+ (NSArray *) lz_loadLocalResources :(NSString *) fileName;

#pragma mark --- 清除tableView多余分割线
//-------------------------------------------------------------------------------------------------------------------------------------------------
+ (UITableView *)lz_setExtraCellLineHidden: (UITableView *)tableView;

/**
 *  生成图片
 *
 *  @param color  图片颜色
 *
 *  @return 生成的图片
 */
+ (UIImage *) lz_imageWithColor:(UIColor *)color;

/**
 *  设置公共按钮背景图
 *
 *  @param button 需要设置的按钮
 *  @param cornerRadius 圆角大小
 *  @return 返回已经设置好的内容
 */
+ (UIButton *) lz_setButtonWithBGImage:(UIButton *) button cornerRadius:(CGFloat)cornerRadius;


/**
 *  11. 将十六进制颜色转换为 UIColor 对象
 *
 *  @param color 颜色值
 *
 *  @return 将十六进制颜色转换为 UIColor 对象
 */
+ (UIColor *)lz_colorWithHexString:(NSString *)color;

/**
 *  设置公共按钮背景图
 *
 *  @param text 文字内容
 *  @param font 文字字体
 *  @param maxW 最大宽度
 *
 *  @return 返回已经设置好的内容
 */
+ (CGSize)lz_sizeWithText:(NSString *)text font:(UIFont *)font maxW:(CGFloat)maxW;

/**
 *  时间戳转换为时间
 *
 *  @param timeString 时间戳
 *
 *  @return 返回字符串格式时间
 */
+ (NSString *)lz_timeWithTimeIntervalString:(NSString *)timeString;
/**
 *  获取当前系统时间
 *
 *  @return 返回字符串格式时间
 */
+ (NSString *)lz_getCurrentTime;

/**
 *  获取当前系统日期
 *
 *  @return 返回字符串格式时间
 */
+ (NSString*)lz_getCurrentDate;

/**
 *  获取当前时间的时间戳
 *
 *  @return 返回字符串格式时间
 */
+ (NSString*)lz_getCurrentTimestamp;

/**
 *  获取时间差值  截止时间-当前时间
 *  nowDateStr : 当前时间
 *  deadlineStr : 截止时间
 *  @return 时间戳差值
 */
+ (NSInteger)getDateDifferenceWithNowDateStr:(NSString*)nowDateStr deadlineStr:(NSString*)deadlineStr;

/**
 *  据图片名将图片保存到ImageFile文件夹中
 *
 *  @param imageName 图片名称
 *
 *  @return 返回字符串格式时间
 */
+ (NSString *)lz_imageSavedPath :(NSString *) imageName;

/**
 *  解析编码格式
 *
 *  @param responseObject 解析的数据
 *
 *  @return 返回字符串格式
 */
+ (NSString *) lz_dataWithJSONObject:(NSDictionary *) responseObject;

/**
 *  解析编码格式(数组)
 *
 *  @param responseObject 数组
 *  @return 返回字符串格式
 */
+ (NSString *) lz_arrayWithJSONObject:(NSMutableArray *) responseObject;

/**
 *  将数字转换为 时、分、秒、
 *
 *  @param totalSecond 时间转换
 *
 *  @return 返回字符串格式
 */
+ (NSString *) lz_timeFormatted:(int) totalSecond;

/**
 *  设置searchBar的背景色使用的
 *
 *  @param size searchBar 的size
 *
 *  @return 返回设置好的图片
 */
+ (UIImage *) lz_imageWithColor:(UIColor *)color size:(CGSize)size;

/**
 *  银行卡字符串格式化
 *  参数 str 银行卡号
 */
+ (NSString *) lz_backCardOrFormatString:(NSString *) string;

/**
 *  银行卡字符串格式化星号显示
 *  参数 bankCard 银行卡号
 */
+ (NSString*) lz_bankCardToAsterisk:(NSString *) bankCard;

/**
 *  设置UILabel的字体和颜色(通用颜色52)
 *  参数 label 需要被设置的UILabel
 */
+ (void) setLabelFontOrColor:(UILabel *) label;
/**
 *  设置UILabel的字体和颜色
 *  参数 label 需要被设置的UILabel
 *  参数 color 需要设置的颜色
 *  参数 font  需要设置的字体
 */
+ (void) setLabelFontOrColor:(UILabel *) label color:(UIColor *) color font:(UIFont *) font;
/**
 *  设置UITextField的字体和颜色
 *  参数 textField 需要被设置的UITextField
 */
+ (void) setTextFieldFontOrColor:(UITextField *) textField;

/**
 *  调整图片大小
 *
 *  @param image 图片
 *  @param size 大小
 *  @return 调整图片大小
 */
+ (UIImage *)lz_scaleToSize:(UIImage *)image size:(CGSize)size;
/**
 *  设置按钮图片与文字的位置间隔(图片居左)
 *  利用UIButton的titleEdgeInsets和imageEdgeInsets来实现文字和图片的自由排列
 *  注意：这个方法需要在设置图片和文字之后才可以调用，且button的大小要大于 图片大小+文字大小+spacing
 *
 *  @param button 按钮
 *  @param spacing 间距
 */
+ (void)lz_setButtonTitleWithImageEdgeInsets:(UIButton *)button postition:(MVImagePosition)postition spacing:(CGFloat)spacing;


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
+ (void)setBorderWithView:(UIView *)view top:(BOOL)top left:(BOOL)left bottom:(BOOL)bottom right:(BOOL)right borderColor:(UIColor *)color borderWidth:(CGFloat)width;
/**
 *  UILabel修改行距,首行缩进(优化版)

 @param lineSpacing 行间距
 @param firstLineHeadIndent 首行缩进字符个数
 @param fontOfSize 字号
 @param textColor 字体颜色
 @param text 字符串内容
 @param label 在哪个LB上面使用该特性
 */
+ (void)settingLabelTextAttributesWithLineSpacing:(CGFloat)lineSpacing FirstLineHeadIndent:(CGFloat)firstLineHeadIndent FontOfSize:(CGFloat)fontOfSize TextColor:(UIColor *)textColor text:(NSString *)text AddLabel:(UILabel *)label;

/**
 *  对字典(Key-Value)排序 不区分大小写
 *
 *  @param dictionary 要排序的字典
 */
+ (NSString *)sortedDictionarybyCaseConversion:(NSMutableDictionary *)dictionary;

/**
 *  根据状态 转换 类型
 *
 *  @param status 状态 0:待审核 1:已通过 2:拒绝 3:管理员关闭 4:已过期 5:待上线 9:回收站 10:草稿 11:修改后提交 12:结束 13:商家关闭 21:商家的商铺关闭
 *
 *  @return 返回字符串格式时间
 */
+ (NSString *)lz_conversionState :(NSInteger) status;
@end
