//  CHBaseUtil
//
//  Created by lichanghong on 13/02/2018.
//  Copyright © 2018 lichanghong. All rights reserved.

#import "NSObject+CHSafe.h"

@implementation NSObject (CHSafe)

- (void)safePerformSelector:(NSString *)selectorName
{
    [self safePerformSelector:selectorName withObject:nil];
}

- (void)safePerformSelector:(NSString *)selectorName withObject:(id)object
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    if (selectorName) {
        SEL action = NSSelectorFromString(selectorName);
        if (action && [self respondsToSelector:action]) {
            [self performSelector:action withObject:object];
        }
    }
#pragma clang diagnostic pop
}


@end
