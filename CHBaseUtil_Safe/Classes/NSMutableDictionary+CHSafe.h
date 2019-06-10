//
//  CHBaseUtil
//
//  Created by lichanghong on 13/02/2018.
//  Copyright © 2018 lichanghong. All rights reserved.

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSMutableDictionary<KeyType, ObjectType> (CHSafe)

- (void)ch_safeSetObject:(id)anObject forKey:(id<NSCopying>)aKey;

- (void)ch_safeSetObject:(id)object forKeyedSubscript:(id<NSCopying>)aKey;

- (void)ch_safeRemoveObjectForKey:(id)aKey;

- (void)ch_safeRemoveObjectsForKeys:(NSArray<KeyType> *)keyArray;

- (void)ch_safeFilterNullValue;

@end


@interface NSMutableDictionary (CGStructs)

- (void)ch_setPoint:(CGPoint)value forKey:(NSString *)key;
- (void)ch_setSize:(CGSize)value forKey:(NSString *)key;
- (void)ch_setRect:(CGRect)value forKey:(NSString *)key;
- (void)ch_setAffineTransform:(CGAffineTransform )value forKey:(NSString *)key;

@end
