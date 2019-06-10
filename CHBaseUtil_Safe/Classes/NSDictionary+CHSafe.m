//  CHBaseUtil
//
//  Created by lichanghong on 13/02/2018.
//  Copyright © 2018 lichanghong. All rights reserved.

#import "NSDictionary+CHSafe.h"
#import "NSString+CHSafe.h"

@implementation NSDictionary (CHSafe)

- (NSString *)safeJsonEncodedKeyValueString
{
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:NSJSONWritingPrettyPrinted
                                                         error:&error];
    if (error) {
        NSLog(@"JSON Parsing Error: %@", error);
        return nil;
    }
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

- (NSUInteger)safeUnsignedIntegerForKey:(NSString *)key
{
    id obj = [self valueForKey:key];
    return [obj unsignedIntegerValue];
}

- (NSInteger)safeIntegerForKey:(NSString *)key
{
    id obj = [self valueForKey:key];
    return [obj integerValue];
}
- (CGFloat)safeFloatForKey:(NSString *)key
{
    id obj = [self valueForKey:key];
    return [obj doubleValue];
}

- (CGPoint)safePointForKey:(NSString *)key
{
    id obj = [self valueForKey:key];
    if (obj && [obj isKindOfClass:[NSValue class]]) {
        return [(NSValue *) obj CGPointValue];
    }
    return CGPointZero;
}

- (CGSize)safeSizeForKey:(NSString *)key
{
    id obj = [self valueForKey:key];
    if (obj && [obj isKindOfClass:[NSValue class]]) {
        return [(NSValue *) obj CGSizeValue];
    }
    return CGSizeZero;
}

- (CGRect)safeRectForKey:(NSString *)key
{
    id obj = [self valueForKey:key];
    if (obj && [obj isKindOfClass:[NSValue class]]) {
        return [(NSValue *) obj CGRectValue];
    }
    return CGRectZero;
}

- (CGAffineTransform)safeAffineTransformForKey:(NSString *)key
{
    id obj = [self valueForKey:key];
    if (obj && [obj isKindOfClass:[NSValue class]]) {
        return [(NSValue *) obj CGAffineTransformValue];
    }
    return CGAffineTransformIdentity;
    
}

- (NSString *)safeStringForKey:(id)key
{
    id obj = [self objectForKey:key];
    if ([obj isKindOfClass:[NSString class]]) {
        return obj;
    } else if ([obj isKindOfClass:[NSNumber class]]) {
        return [(NSNumber *) obj stringValue];
    }
    return nil;
}

- (NSNumber *)safeNumberForKey:(id)key
{
    id obj = [self objectForKey:key];
    if ([obj isKindOfClass:[NSString class]]) {
        return @([obj doubleValue]);
    } else if ([obj isKindOfClass:[NSNumber class]]) {
        return obj;
    }
    return nil;
}

- (NSURL *)safeUrlForKey:(id)key
{
    id obj = [self objectForKey:key];
    if ([obj isKindOfClass:[NSURL class]]) {
        return obj;
    }
    else if ([obj isKindOfClass:[NSString class]]){
        return [NSURL URLWithString:obj];
    }
    return nil;
}

- (NSArray *)safeArrayForKey:(id)key
{
    NSArray *array = [self objectForKey:key];
    if ([array isKindOfClass:[NSArray class]]) {
        return array;
    }
    return nil;
}

- (NSDictionary *)safeDictionaryForKey:(id)key
{
    id obj = [self objectForKey:key];
    if ([obj isKindOfClass:[NSDictionary class]]) {
        return obj;
    }
    return nil;
}

- (NSString *)safeHttpRequestBody
{
    NSMutableString *requestBody = [NSMutableString string];
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [requestBody appendFormat:@"&%@=%@", key, obj];
    }];
    
    NSString *body = nil;
    if (requestBody.length > 1) {
        body = [requestBody safeSubstringFromIndex:1];
    }
    
    return body;
}

@end
