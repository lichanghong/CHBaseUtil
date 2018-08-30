//  CHBaseUtil
//
//  Created by lichanghong on 13/02/2018.
//  Copyright © 2018 lichanghong. All rights reserved.

#import <Foundation/Foundation.h>

@interface NSDate (CHUtil)

/// 获取毫秒
- (NSTimeInterval)ch_timeIntervalSince1970InMilliSecond;

/// 根据毫秒的时间戳获取对应的date
+ (NSDate *)ch_dateWithTimeIntervalInMilliSecondSince1970:(NSTimeInterval)timeIntervalInMilliSecond;


// Relative dates from the current date
+ (NSDate *)ch_dateTomorrow;
+ (NSDate *)ch_dateYesterday;
+ (NSDate *)ch_dateWithDaysFromNow:(NSInteger)days;
+ (NSDate *)ch_dateWithDaysBeforeNow:(NSInteger)days;
+ (NSDate *)ch_dateWithHoursFromNow:(NSInteger)dHours;
+ (NSDate *)ch_dateWithHoursBeforeNow:(NSInteger)dHours;
+ (NSDate *)ch_dateWithMinutesFromNow:(NSInteger)dMinutes;
+ (NSDate *)ch_dateWithMinutesBeforeNow:(NSInteger)dMinutes;

// Comparing dates
- (BOOL)ch_isEqualToDateIgnoringTime:(NSDate *)aDate;
- (BOOL)ch_isToday;
- (BOOL)ch_isTomorrow;
- (BOOL)ch_isYesterday;
- (BOOL)ch_isSameWeekAsDate:(NSDate *)aDate;
- (BOOL)ch_isThisWeek;
- (BOOL)ch_isNextWeek;
- (BOOL)ch_isLastWeek;
- (BOOL)ch_isSameMonthAsDate:(NSDate *)aDate;
- (BOOL)ch_isThisMonth;
- (BOOL)ch_isSameYearAsDate:(NSDate *)aDate;
- (BOOL)ch_isThisYear;
- (BOOL)ch_isNextYear;
- (BOOL)ch_isLastYear;
- (BOOL)ch_isEarlierThanDate:(NSDate *)aDate;
- (BOOL)ch_isLaterThanDate:(NSDate *)aDate;
- (BOOL)ch_isInFuture;
- (BOOL)ch_isInPast;

// Date roles
- (BOOL)ch_isTypicallyWorkday;
- (BOOL)ch_isTypicallyWeekend;

// Adjusting dates
- (NSDate *)ch_dateByAddingDays:(NSInteger)dDays;
- (NSDate *)ch_dateBySubtractingDays:(NSInteger)dDays;
- (NSDate *)ch_dateByAddingHours:(NSInteger)dHours;
- (NSDate *)ch_dateBySubtractingHours:(NSInteger)dHours;
- (NSDate *)ch_dateByAddingMinutes:(NSInteger)dMinutes;
- (NSDate *)ch_dateBySubtractingMinutes:(NSInteger)dMinutes;
- (NSDate *)ch_dateAtStartOfDay;

// Retrieving intervals
- (NSInteger)ch_minutesAfterDate:(NSDate *)aDate;
- (NSInteger)ch_minutesBeforeDate:(NSDate *)aDate;
- (NSInteger)ch_hoursAfterDate:(NSDate *)aDate;
- (NSInteger)ch_hoursBeforeDate:(NSDate *)aDate;
- (NSInteger)ch_daysAfterDate:(NSDate *)aDate;
- (NSInteger)ch_daysBeforeDate:(NSDate *)aDate;
- (NSInteger)ch_distanceInDaysToDate:(NSDate *)anotherDate;

// Decomposing dates
@property (readonly) NSInteger nearestHour;
@property (readonly) NSInteger hour;
@property (readonly) NSInteger minute;
@property (readonly) NSInteger seconds;
@property (readonly) NSInteger day;
@property (readonly) NSInteger month;
@property (readonly) NSInteger week;
@property (readonly) NSInteger weekday;
@property (readonly) NSInteger nthWeekday; // e.g. 2nd Tuesday of the month == 2
@property (readonly) NSInteger year;

@end
