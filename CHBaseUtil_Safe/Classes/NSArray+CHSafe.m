//  CHBaseUtil
//
//  Created by lichanghong on 13/02/2018.
//  Copyright © 2018 lichanghong. All rights reserved.

#import "NSArray+CHSafe.h"

@implementation NSArray (CHSafe)

- (id)safeObjectAtIndex:(NSUInteger)index
{
    if (index < self.count) {
        return [self objectAtIndex:index];
    }
    return nil;
}

- (id)safeSubarrayWithRange:(NSRange)range
{
    if (range.location + range.length <= self.count) {
        return [self subarrayWithRange:range];
    }
    return nil;
}

@end
