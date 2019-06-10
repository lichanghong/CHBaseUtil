//  CHBaseUtil
//
//  Created by lichanghong on 13/02/2018.
//  Copyright © 2018 lichanghong. All rights reserved.

#import "NSDate+CHUtil.h"
#import "NSDateFormatter+CHCommon.h"

#define ch_MINUTE	(60)
#define ch_HOUR	((ch_MINUTE) * 60)
#define ch_DAY		((ch_HOUR) * 24)
#define ch_WEEK	((ch_DAY) * 7)
#define ch_YEAR	((ch_DAY) * 365)

#define ch_DATE_COMPONENTS (NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekCalendarUnit |  NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSWeekdayCalendarUnit | NSWeekdayOrdinalCalendarUnit)
#define ch_CURRENT_CALENDAR [NSCalendar currentCalendar]

@implementation NSDate (CHUtil)

- (NSTimeInterval)ch_timeIntervalSince1970InMilliSecond
{
    NSTimeInterval ret = [self timeIntervalSince1970];
    return ret * 1000;
}

+ (NSDate *)ch_dateWithTimeIntervalInMilliSecondSince1970:(NSTimeInterval)timeIntervalInMilliSecond
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

+ (NSDate *)ch_dateWithDaysFromNow:(NSInteger)days
{
    return [[NSDate date] ch_dateByAddingDays:days];
}

+ (NSDate *)ch_dateWithDaysBeforeNow:(NSInteger)days
{
    return [[NSDate date] ch_dateBySubtractingDays:days];
}

+ (NSDate *)ch_dateTomorrow
{
    return [NSDate ch_dateWithDaysFromNow:1];
}

+ (NSDate *)ch_dateYesterday
{
    return [NSDate ch_dateWithDaysBeforeNow:1];
}

+ (NSDate *)ch_dateWithHoursFromNow:(NSInteger)dHours
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + ch_HOUR * dHours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

+ (NSDate *)ch_dateWithHoursBeforeNow: (NSInteger) dHours
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - ch_HOUR * dHours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

+ (NSDate *)ch_dateWithMinutesFromNow:(NSInteger)dMinutes
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + ch_MINUTE * dMinutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

+ (NSDate *)ch_dateWithMinutesBeforeNow:(NSInteger)dMinutes
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - ch_MINUTE * dMinutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

#pragma mark Comparing Dates

- (BOOL)ch_isEqualToDateIgnoringTime:(NSDate *)aDate
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    NSDateComponents *components1 = [ch_CURRENT_CALENDAR components:ch_DATE_COMPONENTS fromDate:self];
    NSDateComponents *components2 = [ch_CURRENT_CALENDAR components:ch_DATE_COMPONENTS fromDate:aDate];
#pragma clang diagnostic pop
    return ((components1.year == components2.year) &&
            (components1.month == components2.month) &&
            (components1.day == components2.day));
}

- (BOOL)ch_isToday
{
    return [self ch_isEqualToDateIgnoringTime:[NSDate date]];
}

- (BOOL)ch_isTomorrow
{
    return [self ch_isEqualToDateIgnoringTime:[NSDate ch_dateTomorrow]];
}

- (BOOL)ch_isYesterday
{
    return [self ch_isEqualToDateIgnoringTime:[NSDate ch_dateYesterday]];
}

// This hard codes the assumption that a week is 7 days
- (BOOL)ch_isSameWeekAsDate:(NSDate *)aDate
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
#pragma clang diagnostic ignored "-Wincompatible-pointer-types"
    NSDateComponents *components1 = [ch_CURRENT_CALENDAR components:ch_DATE_COMPONENTS fromDate:self];
    NSDateComponents *components2 = [ch_CURRENT_CALENDAR components:ch_DATE_COMPONENTS fromDate:aDate];
    // Must be same week. 12/31 and 1/1 will both be week "1" if they are in the same week
    if (components1.week != components2.week) return NO;
    // Must have a time interval under 1 week. Thanks @aclark
    return (fabs([self timeIntervalSinceDate:aDate]) < ch_WEEK);
#pragma clang pop
}

- (BOOL)ch_isThisWeek
{
    return [self ch_isSameWeekAsDate:[NSDate date]];
}

- (BOOL)ch_isNextWeek
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + ch_WEEK;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return [self ch_isSameWeekAsDate:newDate];
}

- (BOOL)ch_isLastWeek
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - ch_WEEK;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return [self ch_isSameWeekAsDate:newDate];
}

// Thanks, mspasov
- (BOOL)ch_isSameMonthAsDate:(NSDate *)aDate
{
    NSDateComponents *components1 = [ch_CURRENT_CALENDAR components:NSYearCalendarUnit | NSMonthCalendarUnit fromDate:self];
    NSDateComponents *components2 = [ch_CURRENT_CALENDAR components:NSYearCalendarUnit | NSMonthCalendarUnit fromDate:aDate];
    return ((components1.month == components2.month) &&
            (components1.year == components2.year));
}

- (BOOL)ch_isThisMonth
{
    return [self ch_isSameMonthAsDate:[NSDate date]];
}

- (BOOL)ch_isSameYearAsDate:(NSDate *)aDate
{
    NSDateComponents *components1 = [ch_CURRENT_CALENDAR components:NSYearCalendarUnit fromDate:self];
    NSDateComponents *components2 = [ch_CURRENT_CALENDAR components:NSYearCalendarUnit fromDate:aDate];
    return (components1.year == components2.year);
}

- (BOOL)ch_isThisYear
{
    return [self ch_isSameYearAsDate:[NSDate date]];
}

- (BOOL)ch_isNextYear
{
    NSDateComponents *components1 = [ch_CURRENT_CALENDAR components:NSYearCalendarUnit fromDate:self];
    NSDateComponents *components2 = [ch_CURRENT_CALENDAR components:NSYearCalendarUnit fromDate:[NSDate date]];
    
    return (components1.year == (components2.year + 1));
}

- (BOOL)ch_isLastYear
{
    NSDateComponents *components1 = [ch_CURRENT_CALENDAR components:NSYearCalendarUnit fromDate:self];
    NSDateComponents *components2 = [ch_CURRENT_CALENDAR components:NSYearCalendarUnit fromDate:[NSDate date]];
    
    return (components1.year == (components2.year - 1));
}

- (BOOL)ch_isEarlierThanDate:(NSDate *)aDate
{
    return ([self compare:aDate] == NSOrderedAscending);
}

- (BOOL)ch_isLaterThanDate:(NSDate *)aDate
{
    return ([self compare:aDate] == NSOrderedDescending);
}

- (BOOL)ch_isInFuture
{
    return ([self ch_isLaterThanDate:[NSDate date]]);
}

- (BOOL)ch_isInPast
{
    return ([self ch_isEarlierThanDate:[NSDate date]]);
}

#pragma mark Roles
- (BOOL)ch_isTypicallyWeekend
{
    NSDateComponents *components = [ch_CURRENT_CALENDAR components:NSWeekdayCalendarUnit fromDate:self];
    if ((components.weekday == 1) ||
        (components.weekday == 7))
        return YES;
    return NO;
}

- (BOOL)ch_isTypicallyWorkday
{
    return ![self ch_isTypicallyWeekend];
}

#pragma mark Adjusting Dates

- (NSDate *)ch_dateByAddingDays:(NSInteger)dDays
{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + ch_DAY * dDays;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

- (NSDate *)ch_dateBySubtractingDays:(NSInteger)dDays
{
    return [self ch_dateByAddingDays:(dDays * (-1))];
}

- (NSDate *)ch_dateByAddingHours:(NSInteger)dHours
{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + ch_HOUR * dHours;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

- (NSDate *)ch_dateBySubtractingHours:(NSInteger)dHours
{
    return [self ch_dateByAddingHours:(dHours * (-1))];
}

- (NSDate *)ch_dateByAddingMinutes:(NSInteger)dMinutes
{
    NSTimeInterval aTimeInterval = [self timeIntervalSinceReferenceDate] + ch_MINUTE * dMinutes;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    return newDate;
}

- (NSDate *)ch_dateBySubtractingMinutes:(NSInteger)dMinutes
{
    return [self ch_dateByAddingMinutes:(dMinutes * (-1))];
}

- (NSDate *)ch_dateAtStartOfDay
{
    NSDateComponents *components = [ch_CURRENT_CALENDAR components:ch_DATE_COMPONENTS fromDate:self];
    components.hour = 0;
    components.minute = 0;
    components.second = 0;
    return [ch_CURRENT_CALENDAR dateFromComponents:components];
}

- (NSDateComponents *)ch_componentsWithOffsetFromDate:(NSDate *)aDate
{
    NSDateComponents *dTime = [ch_CURRENT_CALENDAR components:ch_DATE_COMPONENTS fromDate:aDate toDate:self options:0];
    return dTime;
}

#pragma mark Retrieving Intervals

- (NSInteger)ch_minutesAfterDate:(NSDate *)aDate
{
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger)(ti / ch_MINUTE);
}

- (NSInteger)ch_minutesBeforeDate:(NSDate *)aDate
{
    NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
    return (NSInteger)(ti / ch_MINUTE);
}

- (NSInteger)ch_hoursAfterDate:(NSDate *)aDate
{
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger)(ti / ch_HOUR);
}

- (NSInteger)ch_hoursBeforeDate:(NSDate *)aDate
{
    NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
    return (NSInteger)(ti / ch_HOUR);
}

- (NSInteger)ch_daysAfterDate:(NSDate *)aDate
{
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
    return (NSInteger)(ti / ch_DAY);
}

- (NSInteger)ch_daysBeforeDate:(NSDate *)aDate
{
    NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
    return (NSInteger)(ti / ch_DAY);
}

// Thanks, dmitrydims
// I have not yet thoroughly tested this
- (NSInteger)ch_distanceInDaysToDate:(NSDate *)anotherDate
{
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorianCalendar components:NSDayCalendarUnit fromDate:self toDate:anotherDate options:0];
    return components.day;
}

#pragma mark Decomposing Dates

- (NSInteger)nearestHour
{
    NSTimeInterval aTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + ch_MINUTE * 30;
    NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:aTimeInterval];
    NSDateComponents *components = [ch_CURRENT_CALENDAR components:NSHourCalendarUnit fromDate:newDate];
    return components.hour;
}

- (NSInteger)hour
{
    NSDateComponents *components = [ch_CURRENT_CALENDAR components:ch_DATE_COMPONENTS fromDate:self];
    return components.hour;
}

- (NSInteger)minute
{
    NSDateComponents *components = [ch_CURRENT_CALENDAR components:ch_DATE_COMPONENTS fromDate:self];
    return components.minute;
}

- (NSInteger)seconds
{
    NSDateComponents *components = [ch_CURRENT_CALENDAR components:ch_DATE_COMPONENTS fromDate:self];
    return components.second;
}

- (NSInteger)day
{
    NSDateComponents *components = [ch_CURRENT_CALENDAR components:ch_DATE_COMPONENTS fromDate:self];
    return components.day;
}

- (NSInteger)month
{
    NSDateComponents *components = [ch_CURRENT_CALENDAR components:ch_DATE_COMPONENTS fromDate:self];
    return components.month;
}

- (NSInteger)week
{
    NSDateComponents *components = [ch_CURRENT_CALENDAR components:ch_DATE_COMPONENTS fromDate:self];
    return components.week;
}

- (NSInteger)weekday
{
    NSDateComponents *components = [ch_CURRENT_CALENDAR components:ch_DATE_COMPONENTS fromDate:self];
    return components.weekday;
}

- (NSInteger)nthWeekday // e.g. 2nd Tuesday of the month is 2
{
    NSDateComponents *components = [ch_CURRENT_CALENDAR components:ch_DATE_COMPONENTS fromDate:self];
    return components.weekdayOrdinal;
}

- (NSInteger)year
{
    NSDateComponents *components = [ch_CURRENT_CALENDAR components:ch_DATE_COMPONENTS fromDate:self];
    return components.year;
}

@end
