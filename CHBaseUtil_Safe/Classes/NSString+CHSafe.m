//  CHBaseUtil
//
//  Created by lichanghong on 13/02/2018.
//  Copyright © 2018 lichanghong. All rights reserved.
//

#import "NSString+CHSafe.h"

NSString *unEmptyStringByString(NSString *originalStr, NSString *defaultStr)
{
    if ([originalStr isKindOfClass:[NSString class]] &&
        originalStr.length) {
        return originalStr;
    } else if ([defaultStr isKindOfClass:[NSString class]] &&
               defaultStr) {
        return defaultStr;
    } else {
        return @"";
    }
}

NSString *unEmptyStringByDefault(NSString *originalStr)
{
    return unEmptyStringByString(originalStr, @"");
}


@implementation  NSString (CHSafe)

- (unichar)safeCharacterAtIndex:(NSUInteger)index
{
    if (index >= self.length) {
        return '\0';
    }
    return [self characterAtIndex:index];
}

- (NSString *)safeSubstringToIndex:(NSUInteger)index
{
    if(index > self.length) {
        return nil;
    }
    return [self substringToIndex:index];
}

- (NSString *)safeSubstringFromIndex:(NSUInteger)index
{
    if(index > self.length) {
        return nil;
    }
    return [self substringFromIndex:index];
}

- (NSString *)safeSubstringWithRange:(NSRange)range
{
    if(range.location == NSNotFound) {
        return nil;
    }
    return [self substringWithRange:range];
}

- (BOOL)safeContainsString:(NSString *)string
{
    if(string) {
        if ([self respondsToSelector:@selector(containsString:)]) {
            return ([self containsString:string]);
        } else if ([self respondsToSelector:@selector(rangeOfString:)]) {
            return ([self rangeOfString:string].location != NSNotFound);
        }
    }
    return NO;
}

- (NSComparisonResult)safeLocalizedCompare:(NSString *)string;
{
    if (!self) {
        return NSOrderedAscending; // 如果本身是nil的话，就认为是小于
    }
    
    if (!string) {
        return NSOrderedDescending; // 如果string是nil的话，就认为是大于
    }
    
    return [self localizedCompare:string];
}

@end
