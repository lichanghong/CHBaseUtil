//  CHBaseUtil
//
//  Created by lichanghong on 13/02/2018.
//  Copyright © 2018 lichanghong. All rights reserved.

#import <Foundation/Foundation.h>

@interface NSDate (CHUtil)

/// 获取毫秒
- (NSTimeInterval)cdf_timeIntervalSince1970InMilliSecond;

/// 根据毫秒的时间戳获取对应的date
+ (NSDate *)cdf_dateWithTimeIntervalInMilliSecondSince1970:(NSTimeInterval)timeIntervalInMilliSecond;


// Relative dates from the current date
+ (NSDate *)cdf_dateTomorrow;
+ (NSDate *)cdf_dateYesterday;
+ (NSDate *)cdf_dateWithDaysFromNow:(NSInteger)days;
+ (NSDate *)cdf_dateWithDaysBeforeNow:(NSInteger)days;
+ (NSDate *)cdf_dateWithHoursFromNow:(NSInteger)dHours;
+ (NSDate *)cdf_dateWithHoursBeforeNow:(NSInteger)dHours;
+ (NSDate *)cdf_dateWithMinutesFromNow:(NSInteger)dMinutes;
+ (NSDate *)cdf_dateWithMinutesBeforeNow:(NSInteger)dMinutes;

// Comparing dates
- (BOOL)cdf_isEqualToDateIgnoringTime:(NSDate *)aDate;
- (BOOL)cdf_isToday;
- (BOOL)cdf_isTomorrow;
- (BOOL)cdf_isYesterday;
- (BOOL)cdf_isSameWeekAsDate:(NSDate *)aDate;
- (BOOL)cdf_isThisWeek;
- (BOOL)cdf_isNextWeek;
- (BOOL)cdf_isLastWeek;
- (BOOL)cdf_isSameMonthAsDate:(NSDate *)aDate;
- (BOOL)cdf_isThisMonth;
- (BOOL)cdf_isSameYearAsDate:(NSDate *)aDate;
- (BOOL)cdf_isThisYear;
- (BOOL)cdf_isNextYear;
- (BOOL)cdf_isLastYear;
- (BOOL)cdf_isEarlierThanDate:(NSDate *)aDate;
- (BOOL)cdf_isLaterThanDate:(NSDate *)aDate;
- (BOOL)cdf_isInFuture;
- (BOOL)cdf_isInPast;

// Date roles
- (BOOL)cdf_isTypicallyWorkday;
- (BOOL)cdf_isTypicallyWeekend;

// Adjusting dates
- (NSDate *)cdf_dateByAddingDays:(NSInteger)dDays;
- (NSDate *)cdf_dateBySubtractingDays:(NSInteger)dDays;
- (NSDate *)cdf_dateByAddingHours:(NSInteger)dHours;
- (NSDate *)cdf_dateBySubtractingHours:(NSInteger)dHours;
- (NSDate *)cdf_dateByAddingMinutes:(NSInteger)dMinutes;
- (NSDate *)cdf_dateBySubtractingMinutes:(NSInteger)dMinutes;
- (NSDate *)cdf_dateAtStartOfDay;

// Retrieving intervals
- (NSInteger)cdf_minutesAfterDate:(NSDate *)aDate;
- (NSInteger)cdf_minutesBeforeDate:(NSDate *)aDate;
- (NSInteger)cdf_hoursAfterDate:(NSDate *)aDate;
- (NSInteger)cdf_hoursBeforeDate:(NSDate *)aDate;
- (NSInteger)cdf_daysAfterDate:(NSDate *)aDate;
- (NSInteger)cdf_daysBeforeDate:(NSDate *)aDate;
- (NSInteger)cdf_distanceInDaysToDate:(NSDate *)anotherDate;

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
