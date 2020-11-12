//
//  YQQCalendarModel.h
//  YQQCalendar
//
//  Created by zhuyi on 2020/11/12.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, YQQCalendarItemSelectedType) {
    YQQCalendarItemSelectedTypeNone,
    YQQCalendarItemSelectedTypeFirst,
    YQQCalendarItemSelectedTypeMiddle,
    YQQCalendarItemSelectedTypeLast
};

NS_ASSUME_NONNULL_BEGIN

@interface YQQCalendarItem : NSObject

@property (nonatomic, strong) NSDate *date;

@property (nonatomic, assign) YQQCalendarItemSelectedType selectedType;

@end

@interface YQQCalendarModel : NSObject

@property (nonatomic, strong) NSDate *date;

@property (nonatomic, strong) NSArray *items;

@end

NS_ASSUME_NONNULL_END
