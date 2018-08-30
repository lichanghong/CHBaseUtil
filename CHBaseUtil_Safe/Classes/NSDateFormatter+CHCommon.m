//  CHBaseUtil
//
//  Created by lichanghong on 13/02/2018.
//  Copyright © 2018 lichanghong. All rights reserved.

#import "NSDateFormatter+CHCommon.h"

NSString *const CHDateFormat = @"yyyy-MM-dd HH:mm:ss";

@implementation NSDateFormatter (CFCommon)

+ (NSDate *)ch_dateFromString:(NSString *)dateString
                   dateFormat:(NSString *)dateFormat
{
    return [[self ch_dateFormatterWithDateFormat:dateFormat] dateFromString:dateString];
}

+ (NSDate *)ch_dateFromString:(NSString *)dateString
{
    return [self ch_dateFromString:dateString dateFormat:CHDateFormat];
}

+ (NSString *)ch_stringFromDate:(NSDate *)date dateFormat:(NSString *)dateFormat
{
    return [[self ch_dateFormatterWithDateFormat:dateFormat] stringFromDate:date];
}

+ (NSString *)ch_stringFromDate:(NSDate *)date
{
    return [self ch_stringFromDate:date dateFormat:CHDateFormat];
}

+ (NSDateFormatter *)ch_dateFormatterWithDateFormat:(NSString *)dateFormat
{
    NSDateFormatter * df = [[NSDateFormatter alloc] init];
    df.dateFormat = dateFormat;
    return df;
}

+ (NSDateFormatter *)ch_defaultDateFormatter
{
    return [self ch_dateFormatterWithDateFormat:CHDateFormat];
}

@end
