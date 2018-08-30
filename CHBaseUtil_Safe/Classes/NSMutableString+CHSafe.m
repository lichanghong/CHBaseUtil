//  CHBaseUtil
//
//  Created by lichanghong on 13/02/2018.
//  Copyright © 2018 lichanghong. All rights reserved.

#import "NSMutableString+CHSafe.h"

@implementation NSMutableString (CHSafe)

- (void)safeAppendString:(NSString *)str
{
    if (str.length) {
        [self appendString:str];
    }
}

@end
