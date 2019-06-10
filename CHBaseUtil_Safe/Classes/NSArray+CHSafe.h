//  CHBaseUtil
//
//  Created by lichanghong on 13/02/2018.
//  Copyright © 2018 lichanghong. All rights reserved.

#import <Foundation/Foundation.h>

@interface NSArray (CHSafe)

- (id)safeObjectAtIndex:(NSUInteger)index;
- (id)safeSubarrayWithRange:(NSRange)range;

@end
