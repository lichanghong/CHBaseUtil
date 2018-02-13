//  CHBaseUtil
//
//  Created by lichanghong on 13/02/2018.
//  Copyright © 2018 lichanghong. All rights reserved.

#import "NSString+CDFURL.h"

#define CDFLegalString(str) (str && [str isKindOfClass:[NSString class]])

@implementation NSString (CDFURL)

#pragma mark - URL

- (NSString *)cdf_urlScheme
{
    return [self cdf_urlSchemeSupportChinese:YES];
}

- (NSString *)cdf_urlSchemeSupportChinese:(BOOL)support
{
    NSString *formatURL = self;
    if (support) {
        formatURL = [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    }
    if ([self cdf_isValidURLSupportChinese:support]) {
        NSURL *url = [NSURL URLWithString:formatURL];
        return url.scheme;
    }
    return nil;
}

- (NSString *)cdf_urlHost
{
    return [self cdf_urlHostSupportChinese:YES];
}

- (NSString *)cdf_urlHostSupportChinese:(BOOL)support
{
    NSString *formatURL = self;
    if (support) {
        formatURL = [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    }
    if ([self cdf_isValidURLSupportChinese:support]) {
        NSURL *url = [NSURL URLWithString:formatURL];
        return url.host;
    }
    return nil;
}

- (NSString *)cdf_urlPath
{
    return [self cdf_urlPathSupportChinese:YES];
}

- (NSString *)cdf_urlPathSupportChinese:(BOOL)support
{
    NSString *formatURL = self;
    if (support) {
        formatURL = [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    }
    if ([self cdf_isValidURLSupportChinese:support]) {
        NSURL *url = [NSURL URLWithString:formatURL];
        return url.path;
    }
    return nil;
}

- (NSString *)cdf_urlQuery
{
    return [self cdf_urlQuerySupportChinese:YES];
}

- (NSString *)cdf_urlQuerySupportChinese:(BOOL)support
{
    NSString *formatURL = self;
    if (support) {
        formatURL = [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    }
    if ([self cdf_isValidURLSupportChinese:support]) {
        NSURL *url = [NSURL URLWithString:formatURL];
        return url.query;
    }
    return nil;
}

- (NSString *)cdf_urlFragment
{
    return [self cdf_urlFragmentSupportChinese:YES];
}

- (NSString *)cdf_urlFragmentSupportChinese:(BOOL)support
{
    NSString *formatURL = self;
    if (support) {
        formatURL = [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    }
    if ([self cdf_isValidURLSupportChinese:support]) {
        NSURL *url = [NSURL URLWithString:formatURL];
        return url.fragment;
    }
    return nil;
}

- (NSDictionary *)cdf_urlQueryDictionary
{
    // 先判断是否是url
    NSString *queryStr = nil;
    if (self.cdf_isValidURL) {
        queryStr = self.cdf_urlQuery;
    }else {
        queryStr = self;
    }
    
    NSMutableDictionary *queryDict = [NSMutableDictionary dictionary];
    NSArray *components = [queryStr componentsSeparatedByString:@"&"];
    
    __block NSArray *tempArr = nil;
    __block NSString *key = nil;
    __block NSString *value = nil;
    [components enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *temp = (NSString *)obj;
        NSRange range = [temp rangeOfString:@"="];
        
        if (range.location != NSNotFound) {
            key = [temp substringToIndex:range.location];
            value = [temp substringFromIndex:range.location+1];
            
            value = [value stringByRemovingPercentEncoding];
            value = [value stringByRemovingPercentEncoding];//两次 防止转一次不够   多转不会受影响
            [queryDict setObject:value ? value : @"" forKey:key];
        }
    }];
    
    return queryDict;
}

- (NSString *)cdf_urlWithoutQuery
{
    NSURL *URL = [NSURL URLWithString:self];
    NSString *query = URL.query;
    if (query && [query length]>0) {
        NSString *url = URL.absoluteString;
        NSRange range = [url rangeOfString:query];
        if (range.length>0) {
            NSString *pureURL = [url substringToIndex:range.location-1];
            return pureURL;
        }else{
            return self;
        }
    }else{
        if (!URL) {
            // 可能url中有中文，做特殊处理
            return [[self componentsSeparatedByString:@"?"] firstObject];
        }
        return self;
    }
}

- (BOOL)cdf_isValidURL
{
    return [self cdf_isValidURLSupportChinese:YES];
}

- (BOOL)cdf_isValidURLSupportChinese:(BOOL)support
{
    if (self == nil || self.length == 0) {
        return NO;
    }
    
    NSString *formatURL = self;
    if (support) {
        formatURL = [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    }
    NSURL *candidateURL = [NSURL URLWithString:formatURL];
    // WARNING > "test" is an URL according to RFCs, being just a path
    // so you still should check scheme and all other NSURL attributes you need
    if (candidateURL && candidateURL.scheme.length && candidateURL.host) {
        // candidate is a well-formed url with:
        //  - a scheme (like http://)
        //  - a host (like stackoverflow.com)
        return YES;
    }else {
        return NO;
    }
}

- (NSString *)cdf_urlQueryAppendKey:(NSString *)key andValue:(NSString *)value
{
    if(!CDFLegalString(key) || !CDFLegalString(value) || !key.length || !value.length) {
        return self;
    }
    
    value = [value stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    if (self.cdf_isValidURL) {
        if (self.cdf_urlQuery.length>0) {
            return [NSString stringWithFormat:@"%@&%@=%@", self, key, value];
        }else {
            return [NSString stringWithFormat:@"%@?%@=%@", self, key, value];
        }
    }else {
        return [NSString stringWithFormat:@"%@&%@=%@", self, key, value];
    }
}

@end

