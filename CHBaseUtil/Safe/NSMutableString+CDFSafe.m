//  CHBaseUtil
//
//  Created by lichanghong on 13/02/2018.
//  Copyright © 2018 lichanghong. All rights reserved.

#import "NSMutableString+CDFSafe.h"

@implementation NSMutableString (CDFSafe)

- (void)cdf_safeAppendString:(NSString *)str
{
    if (str.length) {
        [self appendString:str];
    }
}

@end
