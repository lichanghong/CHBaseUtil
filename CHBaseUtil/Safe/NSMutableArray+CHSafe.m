//  CHBaseUtil
//
//  Created by lichanghong on 13/02/2018.
//  Copyright © 2018 lichanghong. All rights reserved.

#import "NSMutableArray+CHSafe.h"

@implementation NSMutableArray (CHSafe)

- (void)safeAddObject:(id)obj
{
    if (obj) {
        [self addObject:obj];
    }
}

- (void)safeAddObjectsFromArray:(NSArray *)otherArray
{
    if (otherArray) {
        [self addObjectsFromArray:otherArray];
    }
}

- (void)safeInsertObject:(id)obj atIndex:(NSUInteger)index
{
    if (obj) {
        if (index < self.count) {
            [self insertObject:obj atIndex:index];
        } else {
            [self addObject:obj];
        }
    }
}

- (void)safeInsertObjects:(NSArray *)objects atIndexes:(NSIndexSet *)indexes
{
    if (objects && indexes) {
        [self insertObjects:objects atIndexes:indexes];
    }
}

- (void)safeReplaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject
{
    if (index < self.count && anObject) {
        [self replaceObjectAtIndex:index withObject:anObject];
    }
}

- (void)safeReplaceObjectsAtIndexes:(NSIndexSet *)indexes withObjects:(NSArray *)objects
{
    if (indexes && objects && indexes.count == objects.count) {
        [self replaceObjectsAtIndexes:indexes withObjects:objects];
    }
}

- (void)safeRemoveObject:(id)anObject
{
    if (anObject && [self containsObject:anObject]) {
        [self removeObject:anObject];
    }
}

- (void)safeRemoveLastObject
{
    if (self.count > 0) {
        [self removeLastObject];
    }
}

- (void)safeRemoveObjectAtIndex:(NSUInteger)index
{
    if (index < self.count) {
        [self removeObjectAtIndex:index];
    }
}

- (void)safeRemoveObjectsAtIndexes:(NSIndexSet *)indexes
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

- (void)safeRemoveObject:(id)anObject inRange:(NSRange)aRange
{
    if (anObject && (aRange.location + aRange.length) <= self.count) {
        [self removeObject:anObject inRange:aRange];
    }
}

- (void)safeRemoveObjectIdenticalTo:(id)anObject inRange:(NSRange)aRange
{
    if (anObject && (aRange.length + aRange.location) <= self.count) {
        [self removeObjectIdenticalTo:anObject inRange:aRange];
    }
}

- (void)safeSetObject:(id)anObject atIndexedSubscript:(NSUInteger)index
{
    if (anObject && index < self.count) {
        [self setObject:anObject atIndexedSubscript:index];
    }
}

@end
