//
//  NSDictionary+CHRouter.m
//  ProjectDemo
//
//  Created by lichanghong on 5/4/18.
//  Copyright © 2018 lichanghong. All rights reserved.
//

#import "NSDictionary+CHRouter.h"


NSString *const RouterTransitionTypeKey = @"transitionType";
//NSString *const RouterWebContainerModeKey = @"webContainerMode";
//NSString *const RouterWebPageTypeKey = @"webPageType";


@implementation NSDictionary (CHRouter)

- (CHRouterVCTransitionType)transitionType
{
    
    return [self numberForKey:RouterTransitionTypeKey].integerValue;
}

- (NSNumber *)numberForKey:(id)key
{
    id obj = [self objectForKey:key];
    if ([obj isKindOfClass:[NSString class]]) {
        return @([obj doubleValue]);
    } else if ([obj isKindOfClass:[NSNumber class]]) {
        return obj;
    }
    return nil;
}

//- (SYWebContainerMode)webContainerMode
//{
//    return [self cdf_numberForKey:SYRouterWebContainerModeKey].integerValue;
//}
//
//- (SYWebPageType)webPageType
//{
//    return [self cdf_numberForKey:SYRouterWebPageTypeKey].integerValue;
//}


@end
