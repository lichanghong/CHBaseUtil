//  CHBaseUtil
//
//  Created by lichanghong on 13/02/2018.
//  Copyright © 2018 lichanghong. All rights reserved.

#import "NSMutableArray+CDFSafe.h"

@implementation NSMutableArray (CDFSafe)

- (void)cdf_safeAddObject:(id)obj
{
    if (obj) {
        [self addObject:obj];
    }
}

- (void)cdf_safeAddObjectsFromArray:(NSArray *)otherArray
{
    if (otherArray) {
        [self addObjectsFromArray:otherArray];
    }
}

- (void)cdf_safeInsertObject:(id)obj atIndex:(NSUInteger)index
{
    if (obj) {
        if (index < self.count) {
            [self insertObject:obj atIndex:index];
        } else {
            [self addObject:obj];
        }
    }
}

- (void)cdf_safeInsertObjects:(NSArray *)objects atIndexes:(NSIndexSet *)indexes
{
    if (objects && indexes) {
        [self insertObjects:objects atIndexes:indexes];
    }
}

- (void)cdf_safeReplaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject
{
    if (index < self.count && anObject) {
        [self replaceObjectAtIndex:index withObject:anObject];
    }
}

- (void)cdf_safeReplaceObjectsAtIndexes:(NSIndexSet *)indexes withObjects:(NSArray *)objects
{
    if (indexes && objects && indexes.count == objects.count) {
        [self replaceObjectsAtIndexes:indexes withObjects:objects];
    }
}

- (void)cdf_safeRemoveObject:(id)anObject
{
    if (anObject && [self containsObject:anObject]) {
        [self removeObject:anObject];
    }
}

- (void)cdf_safeRemoveLastObject
{
    if (self.count > 0) {
        [self removeLastObject];
    }
}

- (void)cdf_safeRemoveObjectAtIndex:(NSUInteger)index
{
    if (index < self.count) {
        [self removeObjectAtIndex:index];
    }
}

- (void)cdf_safeRemoveObjectsAtIndexes:(NSIndexSet *)indexes
{
    __block BOOL outOfRange = NO;
    [indexes enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
        if (idx > self.count - 1) {
            outOfRange = YES;
            *stop = YES;
        }
    }];
    if (indexes && !outOfRange) {
        [self removeObjectsAtIndexes:indexes];
    }
}

- (void)cdf_safeRemoveObject:(id)anObject inRange:(NSRange)aRange
{
    if (anObject && (aRange.location + aRange.length) <= self.count) {
        [self removeObject:anObject inRange:aRange];
    }
}

- (void)cdf_safeRemoveObjectIdenticalTo:(id)anObject inRange:(NSRange)aRange
{
    if (anObject && (aRange.length + aRange.location) <= self.count) {
        [self removeObjectIdenticalTo:anObject inRange:aRange];
    }
}

- (void)cdf_safeSetObject:(id)anObject atIndexedSubscript:(NSUInteger)index
{
    if (anObject && index < self.count) {
        [self setObject:anObject atIndexedSubscript:index];
    }
}

@end
