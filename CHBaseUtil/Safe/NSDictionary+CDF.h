//  CHBaseUtil
//
//  Created by lichanghong on 13/02/2018.
//  Copyright © 2018 lichanghong. All rights reserved.

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSDictionary (CDF)

- (NSString *)cdf_jsonEncodedKeyValueString;

@end


@interface NSDictionary (CGStructs)

- (NSUInteger)cdf_unsignedIntegerForKey:(NSString *)key;
- (NSInteger)cdf_integerForKey:(NSString *)key;
- (CGFloat)cdf_cgfloatForKey:(NSString *)key;
- (CGPoint)cdf_pointForKey:(NSString *)key;
- (CGSize)cdf_sizeForKey:(NSString *)key;
- (CGRect)cdf_rectForKey:(NSString *)key;
- (CGAffineTransform)cdf_affineTransformForKey:(NSString *)key;
- (NSString *)cdf_stringForKey:(id)key;
- (NSNumber *)cdf_numberForKey:(id)key;
- (NSURL *)cdf_urlForKey:(id)key;
- (NSArray *)cdf_arrayForKey:(id)key;
- (NSDictionary *)cdf_dictionaryForKey:(id)key;
// 返回http request (如 {user_id:123456,user_name:jdb} 转成 user_id=123456&user_name=jdb)
- (NSString *)cdf_httpRequestBody;

@end
