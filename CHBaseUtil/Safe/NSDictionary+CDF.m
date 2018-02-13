//  CHBaseUtil
//
//  Created by lichanghong on 13/02/2018.
//  Copyright © 2018 lichanghong. All rights reserved.

#import "NSDictionary+CDF.h"
#import "NSString+CDFSafe.h"

@implementation NSDictionary (CDF)

- (NSString *)cdf_jsonEncodedKeyValueString
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

@end

@implementation NSDictionary (CGStructs)

- (NSUInteger)cdf_unsignedIntegerForKey:(NSString *)key
{
    id obj = [self valueForKey:key];
    return [obj unsignedIntegerValue];
}

- (NSInteger)cdf_integerForKey:(NSString *)key
{
    id obj = [self valueForKey:key];
    return [obj integerValue];
}

- (CGFloat)cdf_cgfloatForKey:(NSString *)key
{
    id obj = [self valueForKey:key];
    return [obj doubleValue];
}

- (CGPoint)cdf_pointForKey:(NSString *)key
{
    id obj = [self valueForKey:key];
    if (obj && [obj isKindOfClass:[NSValue class]]) {
        return [(NSValue *) obj CGPointValue];
    }
    return CGPointZero;
}

- (CGSize)cdf_sizeForKey:(NSString *)key
{
    id obj = [self valueForKey:key];
    if (obj && [obj isKindOfClass:[NSValue class]]) {
        return [(NSValue *) obj CGSizeValue];
    }
    return CGSizeZero;
}

- (CGRect)cdf_rectForKey:(NSString *)key
{
    id obj = [self valueForKey:key];
    if (obj && [obj isKindOfClass:[NSValue class]]) {
        return [(NSValue *) obj CGRectValue];
    }
    return CGRectZero;
}

- (CGAffineTransform)cdf_affineTransformForKey:(NSString *)key
{
    id obj = [self valueForKey:key];
    if (obj && [obj isKindOfClass:[NSValue class]]) {
        return [(NSValue *) obj CGAffineTransformValue];
    }
    return CGAffineTransformIdentity;
    
}

- (NSString *)cdf_stringForKey:(id)key
{
    id obj = [self objectForKey:key];
    if ([obj isKindOfClass:[NSString class]]) {
        return obj;
    } else if ([obj isKindOfClass:[NSNumber class]]) {
        return [(NSNumber *) obj stringValue];
    }
    return nil;
}

- (NSNumber *)cdf_numberForKey:(id)key
{
    id obj = [self objectForKey:key];
    if ([obj isKindOfClass:[NSString class]]) {
        return @([obj doubleValue]);
    } else if ([obj isKindOfClass:[NSNumber class]]) {
        return obj;
    }
    return nil;
}

- (NSURL *)cdf_urlForKey:(id)key
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

- (NSArray *)cdf_arrayForKey:(id)key
{
    NSArray *array = [self objectForKey:key];
    if ([array isKindOfClass:[NSArray class]]) {
        return array;
    }
    return nil;
}

- (NSDictionary *)cdf_dictionaryForKey:(id)key
{
    id obj = [self objectForKey:key];
    if ([obj isKindOfClass:[NSDictionary class]]) {
        return obj;
    }
    return nil;
}

- (NSString *)cdf_httpRequestBody
{
    NSMutableString *requestBody = [NSMutableString string];
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [requestBody appendFormat:@"&%@=%@", key, obj];
    }];
    
    NSString *body = nil;
    if (requestBody.length > 1) {
        body = [requestBody cdf_safeSubstringFromIndex:1];
    }
    
    return body;
}

@end
