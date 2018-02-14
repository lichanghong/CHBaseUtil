//  CHBaseUtil
//
//  Created by lichanghong on 13/02/2018.
//  Copyright © 2018 lichanghong. All rights reserved.

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
 

@interface NSDictionary (CHSafe)

- (NSUInteger)safeUnsignedIntegerForKey:(NSString *)key;
- (NSInteger)safeIntegerForKey:(NSString *)key;
- (CGFloat)safeFloatForKey:(NSString *)key;
- (CGPoint)safePointForKey:(NSString *)key;
- (CGSize)safeSizeForKey:(NSString *)key;
- (CGRect)safeRectForKey:(NSString *)key;
- (CGAffineTransform)safeAffineTransformForKey:(NSString *)key;
- (NSString *)safeStringForKey:(id)key;
- (NSNumber *)safEnumberForKey:(id)key;
- (NSURL *)safeUrlForKey:(id)key;
- (NSArray *)safeArrayForKey:(id)key;
- (NSDictionary *)safeDictionaryForKey:(id)key;

// 返回http request (如 {user_id:123456,user_name:jdb} 转成 user_id=123456&user_name=jdb)
- (NSString *)safeHttpRequestBody;

- (NSString *)safeJsonEncodedKeyValueString;


@end
