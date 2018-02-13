//
//  CHBaseUtil
//
//  Created by lichanghong on 13/02/2018.
//  Copyright © 2018 lichanghong. All rights reserved.

#import <Foundation/Foundation.h>

/// 默认的dateformat yyyy-MM-dd HH:mm:ss
extern NSString *const CDFDateFormat;

@interface NSDateFormatter (CDFCommon)

/// 根据date获取对应的dateString dateFormat为SYDateFormat
+ (NSString *)cdf_stringFromDate:(NSDate *)date;

/// 根据date获取对应dateFormat的dateString
+ (NSString *)cdf_stringFromDate:(NSDate *)date dateFormat:(NSString *)dateFormat;

/// 根据dateString获取对应的date dateFormat为SYDateFormat
+ (NSDate *)cdf_dateFromString:(NSString *)dateString;

/// 根据dateString获取对应dateFormat的date
+ (NSDate *)cdf_dateFromString:(NSString *)dateString dateFormat:(NSString *)dateFormat;

/// 根据dateFormat获取dateFormatter
+ (NSDateFormatter *)cdf_dateFormatterWithDateFormat:(NSString *)dateFormat;

/// 获取默认的DateFormatter yyyy-MM-dd HH:mm:ss
+ (NSDateFormatter *)cdf_defaultDateFormatter;

@end
