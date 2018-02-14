//  CHBaseUtil
//
//  Created by lichanghong on 13/02/2018.
//  Copyright © 2018 lichanghong. All rights reserved.

#import <Foundation/Foundation.h>

@interface NSString (CHURL)

- (NSString *)ch_urlScheme;      // http
- (NSString *)ch_urlHost;       //host
- (NSString *)ch_urlPath;      //path
- (NSString *)ch_urlQuery;    // a=b&c=d
- (NSString *)ch_urlFragment; // #

- (BOOL)ch_isValidURL;
- (NSDictionary *)ch_urlQueryDictionary; //dic of query
- (NSString *)ch_urlWithoutQuery;  // path without query

- (NSString *)ch_urlQueryAppendKey:(NSString *)key andValue:(NSString *)value;

@end
