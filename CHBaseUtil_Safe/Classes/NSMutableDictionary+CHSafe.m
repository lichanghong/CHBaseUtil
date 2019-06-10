//  CHBaseUtil
//
//  Created by lichanghong on 13/02/2018.
//  Copyright © 2018 lichanghong. All rights reserved.

#import "NSMutableDictionary+CHSafe.h"

@implementation NSMutableDictionary (CDFSafe)

- (void)ch_safeSetObject:(id)anObject forKey:(id<NSCopying>)aKey
{
    if (!anObject || !aKey) {
        return ;
    }
    [self setObject:anObject forKey:aKey];
}

- (void)ch_safeSetObject:(id)object forKeyedSubscript:(id<NSCopying>)aKey
{
    if (!object || !aKey) {
        return ;
    }
    [self setObject:object forKeyedSubscript:aKey];
}

- (void)ch_safeRemoveObjectForKey:(id)aKey
{
    if(!aKey) {
        return;
    }
    [self removeObjectForKey:aKey];
}

- (void)ch_safeRemoveObjectsForKeys:(NSArray *)keyArray
{
    if(!keyArray) {
        return;
    }
    [self removeObjectsForKeys:keyArray];
}

- (void)ch_safeFilterNullValue {
    NSMutableArray *keysOfNullValue = [NSMutableArray array];
    
    [self enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if (!obj || [obj isKindOfClass:[NSNull class]] || ([obj isKindOfClass:[NSString class]] && [(NSString *)obj length]<1)) {
            [keysOfNullValue addObject:key];
        }
    }];
    [keysOfNullValue enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self removeObjectsForKeys:keysOfNullValue];
    }];
//    NSLog(@"key:%@'s value is null",keysOfNullValue);
}

@end


@implementation NSMutableDictionary (CGStructs)

- (void)ch_setPoint:(CGPoint)value forKey:(NSString *)key
{
    NSValue *pointValue = [NSValue valueWithCGPoint:value];
    [self setValue:pointValue forKey:key];
}

- (void)ch_setSize:(CGSize)value forKey:(NSString *)key
{
    NSValue *sizeValue = [NSValue valueWithCGSize:value];
    [self setValue:sizeValue forKey:key];
}

- (void)ch_setRect:(CGRect)value forKey:(NSString *)key
{
    NSValue *rectValue = [NSValue valueWithCGRect:value];
    [self setValue:rectValue forKey:key];
}

- (void)ch_setAffineTransform:(CGAffineTransform)value forKey:(NSString *)key
{
    NSValue *affineValue = [NSValue valueWithCGAffineTransform:value];
    [self setValue:affineValue forKey:key];
}

@end
