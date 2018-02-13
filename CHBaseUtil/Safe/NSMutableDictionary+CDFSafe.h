//
//  CHBaseUtil
//
//  Created by lichanghong on 13/02/2018.
//  Copyright © 2018 lichanghong. All rights reserved.

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSMutableDictionary<KeyType, ObjectType> (CDFSafe)

- (void)cdf_safeSetObject:(id)anObject forKey:(id<NSCopying>)aKey;

- (void)cdf_safeSetObject:(id)object forKeyedSubscript:(id<NSCopying>)aKey;

- (void)cdf_safeRemoveObjectForKey:(id)aKey;

- (void)cdf_safeRemoveObjectsForKeys:(NSArray<KeyType> *)keyArray;

- (void)cdf_safeFilterNullValue;

@end


@interface NSMutableDictionary (CGStructs)

- (void)cdf_setPoint:(CGPoint)value forKey:(NSString *)key;
- (void)cdf_setSize:(CGSize)value forKey:(NSString *)key;
- (void)cdf_setRect:(CGRect)value forKey:(NSString *)key;
- (void)cdf_setAffineTransform:(CGAffineTransform )value forKey:(NSString *)key;

@end
