//  CHBaseUtil
//
//  Created by lichanghong on 13/02/2018.
//  Copyright © 2018 lichanghong. All rights reserved.

#import "NSString+CHURL.h"

#define chLegalString(str) (str && [str isKindOfClass:[NSString class]])

@implementation NSString (CHURL)

#pragma mark - URL

- (NSString *)ch_urlScheme
{
    return [self ch_urlSchemeSupportChinese:YES];
}

- (NSString *)ch_urlSchemeSupportChinese:(BOOL)support
{
    NSString *formatURL = self;
    if (support) {
        formatURL = [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    }
    if ([self ch_isValidURLSupportChinese:support]) {
        NSURL *url = [NSURL URLWithString:formatURL];
        return url.scheme;
    }
    return nil;
}

- (NSString *)ch_urlHost
{
    return [self ch_urlHostSupportChinese:YES];
}

- (NSString *)ch_urlHostSupportChinese:(BOOL)support
{
    NSString *formatURL = self;
    if (support) {
        formatURL = [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    }
    if ([self ch_isValidURLSupportChinese:support]) {
        NSURL *url = [NSURL URLWithString:formatURL];
        return url.host;
    }
    return nil;
}

- (NSString *)ch_urlPath
{
    return [self ch_urlPathSupportChinese:YES];
}

- (NSString *)ch_urlPathSupportChinese:(BOOL)support
{
    NSString *formatURL = self;
    if (support) {
        formatURL = [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    }
    if ([self ch_isValidURLSupportChinese:support]) {
        NSURL *url = [NSURL URLWithString:formatURL];
        return url.path;
    }
    return nil;
}

- (NSString *)ch_urlQuery
{
    return [self ch_urlQuerySupportChinese:YES];
}

- (NSString *)ch_urlQuerySupportChinese:(BOOL)support
{
    NSString *formatURL = self;
    if (support) {
        formatURL = [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    }
    if ([self ch_isValidURLSupportChinese:support]) {
        NSURL *url = [NSURL URLWithString:formatURL];
        return url.query;
    }
    return nil;
}

- (NSString *)ch_urlFragment
{
    return [self ch_urlFragmentSupportChinese:YES];
}

- (NSString *)ch_urlFragmentSupportChinese:(BOOL)support
{
    NSString *formatURL = self;
    if (support) {
        formatURL = [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    }
    if ([self ch_isValidURLSupportChinese:support]) {
        NSURL *url = [NSURL URLWithString:formatURL];
        return url.fragment;
    }
    return nil;
}

- (NSDictionary *)ch_urlQueryDictionary
{
    // 先判断是否是url
    NSString *queryStr = nil;
    if (self.ch_isValidURL) {
        queryStr = self.ch_urlQuery;
    }else {
        queryStr = self;
    }
    
    NSMutableDictionary *queryDict = [NSMutableDictionary dictionary];
    NSArray *components = [queryStr componentsSeparatedByString:@"&"];
    
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

- (NSString *)ch_urlWithoutQuery
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

- (BOOL)ch_isValidURL
{
    return [self ch_isValidURLSupportChinese:YES];
}

- (BOOL)ch_isValidURLSupportChinese:(BOOL)support
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

- (NSString *)ch_urlQueryAppendKey:(NSString *)key andValue:(NSString *)value
{
    if(!chLegalString(key) || !chLegalString(value) || !key.length || !value.length) {
        return self;
    }
    
    value = [value stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    if (self.ch_isValidURL) {
        if (self.ch_urlQuery.length>0) {
            return [NSString stringWithFormat:@"%@&%@=%@", self, key, value];
        }else {
            return [NSString stringWithFormat:@"%@?%@=%@", self, key, value];
        }
    }else {
        return [NSString stringWithFormat:@"%@&%@=%@", self, key, value];
    }
}

@end

