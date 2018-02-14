//  CHBaseUtil
//
//  Created by lichanghong on 13/02/2018.
//  Copyright © 2018 lichanghong. All rights reserved.

#import <Foundation/Foundation.h>

@interface NSMutableArray (CHSafe)

- (void)safeAddObject:(nonnull id)obj;
- (void)safeAddObjectsFromArray:(nonnull NSArray *)otherArray;
- (void)safeInsertObject:(nonnull id)obj atIndex:(NSUInteger)index;
- (void)safeInsertObjects:(nonnull NSArray *)objects atIndexes:(nonnull NSIndexSet *)indexes;
- (void)safeRemoveLastObject;
- (void)safeRemoveObject:(nonnull id)anObject inRange:(NSRange)aRange;
- (void)safeRemoveObjectAtIndex:(NSUInteger)index;
- (void)safeRemoveObjectIdenticalTo:(nonnull id)anObject inRange:(NSRange)aRange;
- (void)safeRemoveObjectsAtIndexes:(nonnull NSIndexSet *)indexes;
- (void)safeReplaceObjectAtIndex:(NSUInteger)index withObject:(nonnull id)anObject;
- (void)safeReplaceObjectsAtIndexes:(nonnull NSIndexSet *)indexes withObjects:(nonnull NSArray *)objects;
- (void)safeSetObject:(nonnull id)anObject atIndexedSubscript:(NSUInteger)index;
- (void)safeRemoveObject:(nonnull id)anObject;

@end
