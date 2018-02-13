//  CHBaseUtil
//
//  Created by lichanghong on 13/02/2018.
//  Copyright © 2018 lichanghong. All rights reserved.

#import "NSDate+CHUtil.h"
#import "NSDateFormatter+CDFCommon.h"

#define CDF_MINUTE	(60)
#define CDF_HOUR	((CDF_MINUTE) * 60)
#define CDF_DAY		((CDF_HOUR) * 24)
#define CDF_WEEK	((CDF_DAY) * 7)
#define CDF_YEAR	((CDF_DAY) * 365)

#define CDF_DATE_COMPONENTS (NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekCalendarUnit |  NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSWeekdayCalendarUnit | NSWeekdayOrdinalCalendarUnit)
#define CDF_CURRENT_CALENDAR [NSCalendar currentCalendar]

@implementation NSDate (CHUtil)

- (NSTimeInterval)cdf_timeIntervalSince1970InMilliSecond
{
    NSTimeInterval ret = [self timeIntervalSince1970];
    return ret * 1000;
}

+ (NSDate *)cdf_dateWithTimeIntervalInMilliSecondSince1970:(NSTimeInterval)timeIntervalInMilliSecond
{
    NSDate *ret = nil;
    NSTimeInterval timeInterval = timeIntervalInMilliSecond;
    // judge if the argument is in secconds(for former data structure).
    if (timeIntervalInMilliSecond > 140000000000) {
        timeInterval = timeIntervalInMilliSecond / 1000;
    }
    ret = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    return ret;
}

#pragma mark Relative Dates

+ (NSDate *)cdf_dateWithDaysFromNow:(NSInteger)days
{
    return [[NSDate date] cdf_dateByAddingDays:days];
}

+ (NSDate *)cdf_dateWithDaysBeforeNow:(NSInteger)days
{
    return [[NSDate date] cdf_dateBySubtractingDays:days];
}

+ (NSDate *)cdf_dateTomorrow
{
    return [NSDate cdf_dateWithDaysFromNow:1];
}

+ (NSDate *)cdf_dateYesterday
{
    return [NSDate cdf_dateWithDaysBeforeNow:1];
}

+ (NSDate *)cdf_dateWithHoursFromNow:(NSInteger)dHours
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + CDF_HOUR * dHours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

+ (NSDate *)cdf_dateWithHoursBeforeNow: (NSInteger) dHours
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - CDF_HOUR * dHours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

+ (NSDate *)cdf_dateWithMinutesFromNow:(NSInteger)dMinutes
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + CDF_MINUTE * dMinutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

+ (NSDate *)cdf_dateWithMinutesBeforeNow:(NSInteger)dMinutes
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - CDF_MINUTE * dMinutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

#pragma mark Comparing Dates

- (BOOL)cdf_isEqualToDateIgnoringTime:(NSDate *)aDate
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    NSDateComponents *components1 = [CDF_CURRENT_CALENDAR components:CDF_DATE_COMPONENTS fromDate:self];
    NSDateComponents *components2 = [CDF_CURRENT_CALENDAR components:CDF_DATE_COMPONENTS fromDate:aDate];
#pragma clang diagnostic pop
    return ((components1.year == components2.year) &&
            (components1.month == components2.month) &&
            (components1.day == components2.day));
}

- (BOOL)cdf_isToday
{
    return [self cdf_isEqualToDateIgnoringTime:[NSDate date]];
}

- (BOOL)cdf_isTomorrow
{
    return [self cdf_isEqualToDateIgnoringTime:[NSDate cdf_dateTomorrow]];
}

- (BOOL)cdf_isYesterday
{
    return [self cdf_isEqualToDateIgnoringTime:[NSDate cdf_dateYesterday]];
}

// This hard codes the assumption that a week is 7 days
- (BOOL)cdf_isSameWeekAsDate:(NSDate *)aDate
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
#pragma clang diagnostic ignored "-Wincompatible-pointer-types"
    NSDateComponents *components1 = [CDF_CURRENT_CALENDAR components:CDF_DATE_COMPONENTS fromDate:self];
    NSDateComponents *components2 = [CDF_CURRENT_CALENDAR components:CDF_DATE_COMPONENTS fromDate:aDate];
    // Must be same week. 12/31 and 1/1 will both be week "1" if they are in the same week
    if (components1.week != components2.week) return NO;
    // Must have a time interval under 1 week. Thanks @aclark
    return (fabs([self timeIntervalSinceDate:aDate]) < CDF_WEEK);
#pragma clang pop
}

- (BOOL)cdf_isThisWeek
{
    return [self cdf_isSameWeekAsDate:[NSDate date]];
}

- (BOOL)cdf_isNextWeek
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + CDF_WEEK;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return [self cdf_isSameWeekAsDate:newDate];
}

- (BOOL)cdf_isLastWeek
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - CDF_WEEK;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return [self cdf_isSameWeekAsDate:newDate];
}

// Thanks, mspasov
- (BOOL)cdf_isSameMonthAsDate:(NSDate *)aDate
{
    NSDateComponents *components1 = [CDF_CURRENT_CALENDAR components:NSYearCalendarUnit | NSMonthCalendarUnit fromDate:self];
    NSDateComponents *components2 = [CDF_CURRENT_CALENDAR components:NSYearCalendarUnit | NSMonthCalendarUnit fromDate:aDate];
    return ((components1.month == components2.month) &&
            (components1.year == components2.year));
}

- (BOOL)cdf_isThisMonth
{
    return [self cdf_isSameMonthAsDate:[NSDate date]];
}

- (BOOL)cdf_isSameYearAsDate:(NSDate *)aDate
{
    NSDateComponents *components1 = [CDF_CURRENT_CALENDAR components:NSYearCalendarUnit fromDate:self];
    NSDateComponents *components2 = [CDF_CURRENT_CALENDAR components:NSYearCalendarUnit fromDate:aDate];
    return (components1.year == components2.year);
}

- (BOOL)cdf_isThisYear
{
    return [self cdf_isSameYearAsDate:[NSDate date]];
}

- (BOOL)cdf_isNextYear
{
    NSDateComponents *components1 = [CDF_CURRENT_CALENDAR components:NSYearCalendarUnit fromDate:self];
    NSDateComponents *components2 = [CDF_CURRENT_CALENDAR components:NSYearCalendarUnit fromDate:[NSDate date]];
    
    return (components1.year == (components2.year + 1));
}

- (BOOL)cdf_isLastYear
{
    NSDateComponents *components1 = [CDF_CURRENT_CALENDAR components:NSYearCalendarUnit fromDate:self];
    NSDateComponents *components2 = [CDF_CURRENT_CALENDAR components:NSYearCalendarUnit fromDate:[NSDate date]];
    
    return (components1.year == (components2.year - 1));
}

- (BOOL)cdf_isEarlierThanDate:(NSDate *)aDate
{
    return ([self compare:aDate] == NSOrderedAscending);
}

- (BOOL)cdf_isLaterThanDate:(NSDate *)aDate
{
    return ([self compare:aDate] == NSOrderedDescending);
}

- (BOOL)cdf_isInFuture
{
    return ([self cdf_isLaterThanDate:[NSDate date]]);
}

- (BOOL)cdf_isInPast
{
    return ([self cdf_isEarlierThanDate:[NSDate date]]);
}

#pragma mark Roles
- (BOOL)cdf_isTypicallyWeekend
{
    NSDateComponents *components = [CDF_CURRENT_CALENDAR components:NSWeekdayCalendarUnit fromDate:self];
    if ((components.weekday == 1) ||
        (components.weekday == 7))
        return YES;
    return NO;
}

- (BOOL)cdf_isTypicallyWorkday
{
    return ![self cdf_isTypicallyWeekend];
}

#pragma mark Adjusting Dates

- (NSDate *)cdf_dateByAddingDays:(NSInteger)dDays
{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + CDF_DAY * dDays;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

- (NSDate *)cdf_dateBySubtractingDays:(NSInteger)dDays
{
    return [self cdf_dateByAddingDays:(dDays * (-1))];
}

- (NSDate *)cdf_dateByAddingHours:(NSInteger)dHours
{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + CDF_HOUR * dHours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

- (NSDate *)cdf_dateBySubtractingHours:(NSInteger)dHours
{
    return [self cdf_dateByAddingHours:(dHours * (-1))];
}

- (NSDate *)cdf_dateByAddingMinutes:(NSInteger)dMinutes
{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + CDF_MINUTE * dMinutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

- (NSDate *)cdf_dateBySubtractingMinutes:(NSInteger)dMinutes
{
    return [self cdf_dateByAddingMinutes:(dMinutes * (-1))];
}

- (NSDate *)cdf_dateAtStartOfDay
{
    NSDateComponents *components = [CDF_CURRENT_CALENDAR components:CDF_DATE_COMPONENTS fromDate:self];
    components.hour = 0;
    components.minute = 0;
    components.second = 0;
    return [CDF_CURRENT_CALENDAR dateFromComponents:components];
}

- (NSDateComponents *)cdf_componentsWithOffsetFromDate:(NSDate *)aDate
{
    NSDateComponents *dTime = [CDF_CURRENT_CALENDAR components:CDF_DATE_COMPONENTS fromDate:aDate toDate:self options:0];
    return dTime;
}

#pragma mark Retrieving Intervals

- (NSInteger)cdf_minutesAfterDate:(NSDate *)aDate
{
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger)(ti / CDF_MINUTE);
}

- (NSInteger)cdf_minutesBeforeDate:(NSDate *)aDate
{
    NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
    return (NSInteger)(ti / CDF_MINUTE);
}

- (NSInteger)cdf_hoursAfterDate:(NSDate *)aDate
{
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger)(ti / CDF_HOUR);
}

- (NSInteger)cdf_hoursBeforeDate:(NSDate *)aDate
{
    NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
    return (NSInteger)(ti / CDF_HOUR);
}

- (NSInteger)cdf_daysAfterDate:(NSDate *)aDate
{
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger)(ti / CDF_DAY);
}

- (NSInteger)cdf_daysBeforeDate:(NSDate *)aDate
{
    NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
    return (NSInteger)(ti / CDF_DAY);
}

// Thanks, dmitrydims
// I have not yet thoroughly tested this
- (NSInteger)cdf_distanceInDaysToDate:(NSDate *)anotherDate
{
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorianCalendar components:NSDayCalendarUnit fromDate:self toDate:anotherDate options:0];
    return components.day;
}

#pragma mark Decomposing Dates

- (NSInteger)nearestHour
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + CDF_MINUTE * 30;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    NSDateComponents *components = [CDF_CURRENT_CALENDAR components:NSHourCalendarUnit fromDate:newDate];
    return components.hour;
}

- (NSInteger)hour
{
    NSDateComponents *components = [CDF_CURRENT_CALENDAR components:CDF_DATE_COMPONENTS fromDate:self];
    return components.hour;
}

- (NSInteger)minute
{
    NSDateComponents *components = [CDF_CURRENT_CALENDAR components:CDF_DATE_COMPONENTS fromDate:self];
    return components.minute;
}

- (NSInteger)seconds
{
    NSDateComponents *components = [CDF_CURRENT_CALENDAR components:CDF_DATE_COMPONENTS fromDate:self];
    return components.second;
}

- (NSInteger)day
{
    NSDateComponents *components = [CDF_CURRENT_CALENDAR components:CDF_DATE_COMPONENTS fromDate:self];
    return components.day;
}

- (NSInteger)month
{
    NSDateComponents *components = [CDF_CURRENT_CALENDAR components:CDF_DATE_COMPONENTS fromDate:self];
    return components.month;
}

- (NSInteger)week
{
    NSDateComponents *components = [CDF_CURRENT_CALENDAR components:CDF_DATE_COMPONENTS fromDate:self];
    return components.week;
}

- (NSInteger)weekday
{
    NSDateComponents *components = [CDF_CURRENT_CALENDAR components:CDF_DATE_COMPONENTS fromDate:self];
    return components.weekday;
}

- (NSInteger)nthWeekday // e.g. 2nd Tuesday of the month is 2
{
    NSDateComponents *components = [CDF_CURRENT_CALENDAR components:CDF_DATE_COMPONENTS fromDate:self];
    return components.weekdayOrdinal;
}

- (NSInteger)year
{
    NSDateComponents *components = [CDF_CURRENT_CALENDAR components:CDF_DATE_COMPONENTS fromDate:self];
    return components.year;
}

@end
