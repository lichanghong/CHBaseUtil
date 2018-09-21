//
//  NSDictionary+CHRouter.m
//  ProjectDemo
//
//  Created by lichanghong on 5/4/18.
//  Copyright © 2018 lichanghong. All rights reserved.
//

#import "NSDictionary+CHRouter.h"

NSString *const CHRouterTransitionTypeKey = @"CHRouterTransitionTypeKey";
NSString *const CBRouterTransitionAnimatedKey = @"CBRouterTransitionAnimatedKey";

@implementation NSDictionary (CHRouter)

- (CHRouterVCTransitionType)transitionType
{
    return [self mnumberForKey:CHRouterTransitionTypeKey].integerValue;
}

- (NSNumber *)mnumberForKey:(id)key
{
    id obj = [self objectForKey:key];
    if ([obj isKindOfClass:[NSString class]]) {
        return @([obj doubleValue]);
    } else if ([obj isKindOfClass:[NSNumber class]]) {
        return obj;
    }
    return nil;
}



@end
