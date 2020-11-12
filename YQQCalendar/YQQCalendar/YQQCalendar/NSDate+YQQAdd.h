//
//  NSDate+YQQAdd.h
//  YQQCalendar
//
//  Created by zhuyi on 2020/11/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (YQQAdd)

#pragma mark - Component Properties

@property (nonatomic, readonly) NSInteger year; ///< Year component
@property (nonatomic, readonly) NSInteger month; ///< Month component (1~12)
@property (nonatomic, readonly) NSInteger day; ///< Day component (1~31)
@property (nonatomic, readonly) NSInteger hour; ///< Hour component (0~23)
@property (nonatomic, readonly) NSInteger minute; ///< Minute component (0~59)
@property (nonatomic, readonly) NSInteger second; ///< Second component (0~59)
@property (nonatomic, readonly) NSInteger nanosecond; ///< Nanosecond component
@property (nonatomic, readonly) NSInteger weekday; ///< Weekday component (1~7, first day is based on user setting)
@property (nonatomic, readonly) NSInteger weekdayOrdinal; ///< WeekdayOrdinal component
@property (nonatomic, readonly) NSInteger weekOfMonth; ///< WeekOfMonth component (1~5)
@property (nonatomic, readonly) NSInteger weekOfYear; ///< WeekOfYear component (1~53)
@property (nonatomic, readonly) NSInteger yearForWeekOfYear; ///< YearForWeekOfYear component
@property (nonatomic, readonly) NSInteger quarter; ///< Quarter component
@property (nonatomic, readonly) BOOL isLeapMonth; ///< whether the month is leap month
@property (nonatomic, readonly) BOOL isLeapYear; ///< whether the year is leap year
@property (nonatomic, readonly) BOOL isToday; ///< whether date is today (based on current locale)
@property (nonatomic, readonly) BOOL isYesterday; ///< whether date is yesterday (based on current locale)

#pragma mark - Date modify

- (nullable NSDate *)dateByAddingYears:(NSInteger)years;

- (nullable NSDate *)dateByAddingMonths:(NSInteger)months;

- (nullable NSDate *)dateByAddingWeeks:(NSInteger)weeks;

- (nullable NSDate *)dateByAddingDays:(NSInteger)days;

- (nullable NSDate *)dateByAddingHours:(NSInteger)hours;

- (nullable NSDate *)dateByAddingMinutes:(NSInteger)minutes;

- (nullable NSDate *)dateByAddingSeconds:(NSInteger)seconds;

#pragma mark - Date Addition

+ (nullable NSDate *)firstDayOfMonth:(NSDate *)month;

+ (nullable NSDate *)fs_lastDayOfMonth:(NSDate *)month;

+ (NSInteger)numberOfDaysInMonth:(NSDate *)month;

+ (NSInteger)numberOfMonthInRange:(NSDate *)startDate endDate:(NSDate *)endDate;

#pragma mark - Date Creation

/** yyyy */
+ (nullable NSDate *)dateWithYear:(NSInteger)year;

/** yyyy-MM */
+ (nullable NSDate *)dateWithYear:(NSInteger)year month:(NSInteger)month;

/** yyyy-MM-dd */
+ (nullable NSDate *)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day;

/** yyyy-MM-dd HH */
+ (nullable NSDate *)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour;

/** yyyy-MM-dd HH:mm */
+ (nullable NSDate *)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute;

/** yyyy-MM-dd HH:mm:ss */
+ (nullable NSDate *)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second;

/** MM-dd HH:mm */
+ (nullable NSDate *)dateWithMonth:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute;

/** MM-dd */
+ (nullable NSDate *)dateWithMonth:(NSInteger)month day:(NSInteger)day;

/** HH:mm:ss */
+ (nullable NSDate *)dateWithHour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second;

/** HH:mm */
+ (nullable NSDate *)dateWithHour:(NSInteger)hour minute:(NSInteger)minute;

/** mm:ss */
+ (nullable NSDate *)dateWithMinute:(NSInteger)minute second:(NSInteger)second;

#pragma mark - Date Format

- (nullable NSString *)stringWithFormat:(NSString *)format;

- (nullable NSString *)stringWithFormat:(NSString *)format
                               timeZone:(nullable NSTimeZone *)timeZone
                                 locale:(nullable NSLocale *)locale;

- (nullable NSString *)stringWithISOFormat;

+ (nullable NSDate *)dateWithString:(NSString *)dateString format:(NSString *)format;

+ (nullable NSDate *)dateWithString:(NSString *)dateString
                             format:(NSString *)format
                           timeZone:(nullable NSTimeZone *)timeZone
                             locale:(nullable NSLocale *)locale;

+ (nullable NSDate *)dateWithISOFormatString:(NSString *)dateString;

#pragma mark - 获取当前时区(不使用夏时制)
+ (NSTimeZone *)currentTimeZone;

@end

NS_ASSUME_NONNULL_END
