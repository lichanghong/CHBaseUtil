//  CHBaseUtil
//
//  Created by lichanghong on 13/02/2018.
//  Copyright © 2018 lichanghong. All rights reserved.

#import <Foundation/Foundation.h>

@interface NSString (CDFURL)

- (NSString *)cdf_urlScheme;
- (NSString *)cdf_urlSchemeSupportChinese:(BOOL)support;
- (NSString *)cdf_urlHost;
- (NSString *)cdf_urlHostSupportChinese:(BOOL)support;
- (NSString *)cdf_urlPath;
- (NSString *)cdf_urlPathSupportChinese:(BOOL)support;
- (NSString *)cdf_urlQuery;
- (NSString *)cdf_urlQuerySupportChinese:(BOOL)support;
- (NSString *)cdf_urlFragment;
- (NSString *)cdf_urlFragmentSupportChinese:(BOOL)support;

- (BOOL)cdf_isValidURL;
- (BOOL)cdf_isValidURLSupportChinese:(BOOL)support;

- (NSDictionary *)cdf_urlQueryDictionary;
- (NSString *)cdf_urlWithoutQuery;

- (NSString *)cdf_urlQueryAppendKey:(NSString *)key andValue:(NSString *)value;

@end
