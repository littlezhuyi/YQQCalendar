//
//  NSDate+YQQAdd.m
//  YQQCalendar
//
//  Created by zhuyi on 2020/11/12.
//

#import "NSDate+YQQAdd.h"

@implementation NSDate (YQQAdd)

#pragma mark - Component Properties

- (NSInteger)year {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitYear fromDate:self] year];
}

- (NSInteger)month {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitMonth fromDate:self] month];
}

- (NSInteger)day {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitDay fromDate:self] day];
}

- (NSInteger)hour {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitHour fromDate:self] hour];
}

- (NSInteger)minute {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitMinute fromDate:self] minute];
}

- (NSInteger)second {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitSecond fromDate:self] second];
}

- (NSInteger)nanosecond {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitSecond fromDate:self] nanosecond];
}

- (NSInteger)weekday {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekday fromDate:self] weekday];
}

- (NSInteger)weekdayOrdinal {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekdayOrdinal fromDate:self] weekdayOrdinal];
}

- (NSInteger)weekOfMonth {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekOfMonth fromDate:self] weekOfMonth];
}

- (NSInteger)weekOfYear {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitWeekOfYear fromDate:self] weekOfYear];
}

- (NSInteger)yearForWeekOfYear {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitYearForWeekOfYear fromDate:self] yearForWeekOfYear];
}

- (NSInteger)quarter {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitQuarter fromDate:self] quarter];
}

- (BOOL)isLeapMonth {
    return [[[NSCalendar currentCalendar] components:NSCalendarUnitQuarter fromDate:self] isLeapMonth];
}

- (BOOL)isLeapYear {
    NSUInteger year = self.year;
    return ((year % 400 == 0) || ((year % 100 != 0) && (year % 4 == 0)));
}

- (BOOL)isToday {
    if (fabs(self.timeIntervalSinceNow) >= 60 * 60 * 24) return NO;
    return [NSDate new].day == self.day;
}

- (BOOL)isYesterday {
    NSDate *added = [self dateByAddingDays:1];
    return [added isToday];
}

#pragma mark - Date modify

- (NSDate *)dateByAddingYears:(NSInteger)years {
    NSCalendar *calendar =  [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setYear:years];
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)dateByAddingMonths:(NSInteger)months {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setMonth:months];
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)dateByAddingWeeks:(NSInteger)weeks {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setWeekOfYear:weeks];
    return [calendar dateByAddingComponents:components toDate:self options:0];
}

- (NSDate *)dateByAddingDays:(NSInteger)days {
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + 86400 * days;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

- (NSDate *)dateByAddingHours:(NSInteger)hours {
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + 3600 * hours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

- (NSDate *)dateByAddingMinutes:(NSInteger)minutes {
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + 60 * minutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

- (NSDate *)dateByAddingSeconds:(NSInteger)seconds {
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + seconds;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

#pragma mark - Date Addition

+ (nullable NSDate *)firstDayOfMonth:(NSDate *)month {
    if (!month) return nil;
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour fromDate:month];
    components.day = 1;
    return [[NSCalendar currentCalendar] dateFromComponents:components];
}

+ (nullable NSDate *)fs_lastDayOfMonth:(NSDate *)month {
    if (!month) return nil;
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour fromDate:month];
    components.month++;
    components.day = 0;
    return [[NSCalendar currentCalendar] dateFromComponents:components];
}

+ (NSInteger)numberOfDaysInMonth:(NSDate *)month {
    if (!month) return 0;
    NSRange days = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay
                                                      inUnit:NSCalendarUnitMonth
                                                     forDate:month];
    return days.length;
}

+ (NSInteger)numberOfMonthInRange:(NSDate *)startDate endDate:(NSDate *)endDate {
    return [[NSCalendar currentCalendar] components:NSCalendarUnitMonth fromDate:startDate toDate:endDate options:0].month + 1;
}

#pragma mark - Date Creation

/** yyyy */
+ (nullable NSDate *)dateWithYear:(NSInteger)year {
    return [self dateWithYear:year month:0 day:0 hour:0 minute:0 second:0];
}

/** yyyy-MM */
+ (nullable NSDate *)dateWithYear:(NSInteger)year month:(NSInteger)month {
    return [self dateWithYear:year month:month day:0 hour:0 minute:0 second:0];
}

/** yyyy-MM-dd */
+ (nullable NSDate *)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day {
    return [self dateWithYear:year month:month day:day hour:0 minute:0 second:0];
}

/** yyyy-MM-dd HH */
+ (nullable NSDate *)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour {
    return [self dateWithYear:year month:month day:day hour:hour minute:0 second:0];
}

/** yyyy-MM-dd HH:mm */
+ (nullable NSDate *)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute {
    return [self dateWithYear:year month:month day:day hour:hour minute:minute second:0];
}

/** yyyy-MM-dd HH:mm:ss */
+ (nullable NSDate *)dateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // 获取当前日期组件
    NSDateComponents *components = [calendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekOfMonth |  NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday | NSCalendarUnitWeekdayOrdinal fromDate:[NSDate date]];
    if (year > 0) {
        // 初始化日期组件
        components = [[NSDateComponents alloc]init];
        components.year = year;
    }
    if (month > 0) {
        components.month = month;
    }
    if (day > 0) {
        components.day = day;
    }
    if (hour >= 0) {
        components.hour = hour;
    }
    if (minute >= 0) {
        components.minute = minute;
    }
    if (second >= 0) {
        components.second = second;
    }
    
    NSDate *date = [calendar dateFromComponents:components];
    
    return date;
}

/** MM-dd HH:mm */
+ (nullable NSDate *)dateWithMonth:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minute:(NSInteger)minute {
    return [self dateWithYear:0 month:month day:day hour:hour minute:minute second:0];
}

/** MM-dd */
+ (nullable NSDate *)dateWithMonth:(NSInteger)month day:(NSInteger)day {
    return [self dateWithYear:0 month:month day:day hour:0 minute:0 second:0];
}

/** HH:mm:ss */
+ (nullable NSDate *)dateWithHour:(NSInteger)hour minute:(NSInteger)minute second:(NSInteger)second {
    return [self dateWithYear:0 month:0 day:0 hour:hour minute:minute second:second];
}

/** HH:mm */
+ (nullable NSDate *)dateWithHour:(NSInteger)hour minute:(NSInteger)minute {
    return [self dateWithYear:0 month:0 day:0 hour:hour minute:minute second:0];
}

/** mm:ss */
+ (nullable NSDate *)dateWithMinute:(NSInteger)minute second:(NSInteger)second {
    return [self dateWithYear:0 month:0 day:0 hour:0 minute:minute second:second];
}

#pragma mark - Date Format

- (NSString *)stringWithFormat:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    [formatter setLocale:[NSLocale currentLocale]];
    return [formatter stringFromDate:self];
}

- (NSString *)stringWithFormat:(NSString *)format timeZone:(NSTimeZone *)timeZone locale:(NSLocale *)locale {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    if (timeZone) [formatter setTimeZone:timeZone];
    if (locale) [formatter setLocale:locale];
    return [formatter stringFromDate:self];
}

- (NSString *)stringWithISOFormat {
    static NSDateFormatter *formatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [[NSDateFormatter alloc] init];
        formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssZ";
    });
    return [formatter stringFromDate:self];
}

+ (NSDate *)dateWithString:(NSString *)dateString format:(NSString *)format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    return [formatter dateFromString:dateString];
}

+ (NSDate *)dateWithString:(NSString *)dateString format:(NSString *)format timeZone:(NSTimeZone *)timeZone locale:(NSLocale *)locale {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    if (timeZone) [formatter setTimeZone:timeZone];
    if (locale) [formatter setLocale:locale];
    return [formatter dateFromString:dateString];
}

+ (NSDate *)dateWithISOFormatString:(NSString *)dateString {
    static NSDateFormatter *formatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        formatter = [[NSDateFormatter alloc] init];
        formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
        formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ssZ";
    });
    return [formatter dateFromString:dateString];
}

#pragma mark - 获取当前时区(不使用夏时制)
+ (NSTimeZone *)currentTimeZone {
    // 当前时区
    NSTimeZone *localTimeZone = [NSTimeZone localTimeZone];
    // 当前时区相对于GMT(零时区)的偏移秒数
    NSInteger interval = [localTimeZone secondsFromGMTForDate:[NSDate date]];
    // 当前时区(不使用夏时制)：由偏移量获得对应的NSTimeZone对象
    // 注意：一些夏令时时间 NSString 转 NSDate 时，默认会导致 NSDateFormatter 格式化失败，返回 null
    return [NSTimeZone timeZoneForSecondsFromGMT:interval];
}

@end
