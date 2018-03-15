//
//  NSString+MD5.h
//  trover
//
//  Created by skye on 8/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (MD5Extensions)

- (NSString *)md5;
- (NSString *)md5UsingEncoding:(NSStringEncoding)encoding;

@end
