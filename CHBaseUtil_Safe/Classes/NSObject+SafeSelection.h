//  CHBaseUtil
//
//  Created by lichanghong on 13/02/2018.
//  Copyright © 2018 lichanghong. All rights reserved.

#import <objc/runtime.h>
#import <Foundation/Foundation.h>
#import "CHCrashManager.h"

#import "NSDictionary+Resolve.h"
#import "NSDictionary+SafeAccess.h"

#import "NSArray+SafeAccess.h"

#import "NSString+Resolve.h"
#import "NSString+SafeAccess.h"

@interface NSObject (SafeSelection)

+ (void)classImplementationAction;

+ (void)classReplaceMethod:(SEL)currentMethod hookMethod:(SEL)hookMethod;

@end
