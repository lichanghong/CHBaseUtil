//  CHBaseUtil
//
//  Created by lichanghong on 13/02/2018.
//  Copyright © 2018 lichanghong. All rights reserved.

#import <UIKit/UIKit.h>

@interface UIColor (Util)

/*
 * Convert a string of format #4172AC into a UIColor instance. Nil is return if the specified string
 * isn't in the correct format.
 */
+ (UIColor *)colorForHex:(NSString *)hexColor;
+ (UIColor *)colorForHex:(NSString *)hexColor alpha:(CGFloat)alpha;
FOUNDATION_EXTERN UIColor *RedColor(void);
FOUNDATION_EXTERN UIColor *ClearColor(void);
FOUNDATION_EXTERN UIColor *RandomColor(void);
FOUNDATION_EXTERN UIColor *RGB(CGFloat r,CGFloat g,CGFloat b);


@end
