//
//  NSDate+BRPickerView.h
//  BRPickerViewDemo
//
//  Created by 任波 on 2018/3/15.
//  Copyright © 2018年 91renb. All rights reserved.
//
//  最新代码下载地址：https://github.com/91renb/BRPickerView

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#define TTPickerViewDeprecated(instead) NS_DEPRECATED(2_0, 2_0, 2_0, 2_0, instead)

@interface NSDate (TTPickerView)
/// 获取指定date的详细信息
@property (readonly) NSInteger tt_year;    // 年
@property (readonly) NSInteger tt_month;   // 月
@property (readonly) NSInteger tt_day;     // 日
@property (readonly) NSInteger tt_hour;    // 时
@property (readonly) NSInteger tt_minute;  // 分
@property (readonly) NSInteger tt_second;  // 秒
@property (readonly) NSInteger tt_weekday; // 星期

/** 创建 date */
/** yyyy */
+ (nullable NSDate *)tt_setYear:(NSInteger)year;
/** yyyy-MM */
+ (nullable NSDate *)tt_setYear:(NSInteger)year month:(NSInteger)month;
/** yyyy-MM-dd */
+ (nullable NSDate *)tt_setYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;
/** yyyy-MM-dd HH:mm */
+ (nullable NSDate *)tt_setYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute;
/** MM-dd HH:mm */
+ (nullable NSDate *)tt_setMonth:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute;
/** MM-dd */
+ (nullable NSDate *)tt_setMonth:(NSInteger)month day:(NSInteger)day;
/** HH:mm */
+ (nullable NSDate *)tt_setHour:(NSInteger)hour minute:(NSInteger)minute;

/** yyyy */
+ (nullable NSDate *)setYear:(NSInteger)year TTPickerViewDeprecated("过期提醒：请使用带tt前缀的方法");
/** yyyy-MM */
+ (nullable NSDate *)setYear:(NSInteger)year month:(NSInteger)month TTPickerViewDeprecated("过期提醒：请使用带tt前缀的方法");
/** yyyy-MM-dd */
+ (nullable NSDate *)setYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day TTPickerViewDeprecated("过期提醒：请使用带tt前缀的方法");
/** yyyy-MM-dd HH:mm */
+ (nullable NSDate *)setYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute TTPickerViewDeprecated("过期提醒：请使用带tt前缀的方法");
/** MM-dd HH:mm */
+ (nullable NSDate *)setMonth:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute TTPickerViewDeprecated("过期提醒：请使用带tt前缀的方法");
/** MM-dd */
+ (nullable NSDate *)setMonth:(NSInteger)month day:(NSInteger)day TTPickerViewDeprecated("过期提醒：请使用带tt前缀的方法");
/** HH:mm */
+ (nullable NSDate *)setHour:(NSInteger)hour minute:(NSInteger)minute TTPickerViewDeprecated("过期提醒：请使用带tt前缀的方法");

/** 日期和字符串之间的转换：NSDate --> NSString */
+ (nullable  NSString *)tt_getDateString:(NSDate *)date format:(NSString *)format;
/** 日期和字符串之间的转换：NSString --> NSDate */
+ (nullable  NSDate *)tt_getDate:(NSString *)dateString format:(NSString *)format;
/** 获取某个月的天数（通过年月求每月天数）*/
+ (NSUInteger)tt_getDaysInYear:(NSInteger)year month:(NSInteger)month;

/**  获取 日期加上/减去某天数后的新日期 */
- (nullable NSDate *)tt_getNewDate:(NSDate *)date addDays:(NSTimeInterval)days;

/**
 *  比较两个时间大小（可以指定比较级数，即按指定格式进行比较）
 */
- (NSComparisonResult)tt_compare:(NSDate *)targetDate format:(NSString *)format;

@end

NS_ASSUME_NONNULL_END
