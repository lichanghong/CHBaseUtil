//  CHBaseUtil
//
//  Created by lichanghong on 13/02/2018.
//  Copyright © 2018 lichanghong. All rights reserved.

#import "NSDateFormatter+CDFCommon.h"

NSString *const CDFDateFormat = @"yyyy-MM-dd HH:mm:ss";

@implementation NSDateFormatter (CFCommon)

+ (NSDate *)cdf_dateFromString:(NSString *)dateString
                   dateFormat:(NSString *)dateFormat
{
    return [[self cdf_dateFormatterWithDateFormat:dateFormat] dateFromString:dateString];
}

+ (NSDate *)cdf_dateFromString:(NSString *)dateString
{
    return [self cdf_dateFromString:dateString dateFormat:CDFDateFormat];
}

+ (NSString *)cdf_stringFromDate:(NSDate *)date dateFormat:(NSString *)dateFormat
{
    return [[self cdf_dateFormatterWithDateFormat:dateFormat] stringFromDate:date];
}

+ (NSString *)cdf_stringFromDate:(NSDate *)date
{
    return [self cdf_stringFromDate:date dateFormat:CDFDateFormat];
}

+ (NSDateFormatter *)cdf_dateFormatterWithDateFormat:(NSString *)dateFormat
{
    NSDateFormatter * df = [[NSDateFormatter alloc] init];
    df.dateFormat = dateFormat;
    return df;
}

+ (NSDateFormatter *)cdf_defaultDateFormatter
{
    return [self cdf_dateFormatterWithDateFormat:CDFDateFormat];
}

@end
