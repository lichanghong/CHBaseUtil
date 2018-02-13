//  CHBaseUtil
//
//  Created by lichanghong on 13/02/2018.
//  Copyright © 2018 lichanghong. All rights reserved.

#import <Foundation/Foundation.h>

@interface NSMutableArray (CDFSafe)

- (void)cdf_safeAddObject:(nonnull id)obj;
- (void)cdf_safeAddObjectsFromArray:(nonnull NSArray *)otherArray;
- (void)cdf_safeInsertObject:(nonnull id)obj atIndex:(NSUInteger)index;
- (void)cdf_safeInsertObjects:(nonnull NSArray *)objects atIndexes:(nonnull NSIndexSet *)indexes;
- (void)cdf_safeRemoveLastObject;
- (void)cdf_safeRemoveObject:(nonnull id)anObject inRange:(NSRange)aRange;
- (void)cdf_safeRemoveObjectAtIndex:(NSUInteger)index;
- (void)cdf_safeRemoveObjectIdenticalTo:(nonnull id)anObject inRange:(NSRange)aRange;
- (void)cdf_safeRemoveObjectsAtIndexes:(nonnull NSIndexSet *)indexes;
- (void)cdf_safeReplaceObjectAtIndex:(NSUInteger)index withObject:(nonnull id)anObject;
- (void)cdf_safeReplaceObjectsAtIndexes:(nonnull NSIndexSet *)indexes withObjects:(nonnull NSArray *)objects;
- (void)cdf_safeSetObject:(nonnull id)anObject atIndexedSubscript:(NSUInteger)index;
- (void)cdf_safeRemoveObject:(nonnull id)anObject;

@end
