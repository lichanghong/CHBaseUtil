//
//  NSObject+CHObserverUtils.m
//
//  Created by lichanghong on 2017/4/19.
//  Copyright © 2017年 lichanghong. All rights reserved.
//

#import "NSObject+CHObserverUtils.h"
#import <objc/runtime.h>
#import "CHObserverUtils.h"

static NSString *const CHObserverUtilsKey = @"CHObserverUtilsKey";

@implementation NSObject (CHObserverUtils)

- (void)setObserverUtils:(CHObserverUtils *)observerUtils
{
    objc_setAssociatedObject(self, &CHObserverUtilsKey, observerUtils, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CHObserverUtils *)observerUtils
{
    CHObserverUtils *observerUtils = nil;
    @synchronized (self) {
        observerUtils = objc_getAssociatedObject(self, &CHObserverUtilsKey);
        if (!observerUtils) {
            observerUtils = [CHObserverUtils observerUtils];
            [self setObserverUtils:observerUtils];
        }
    }
    return observerUtils;
}


- (void)setChTag:(NSString *)chTag {
    objc_setAssociatedObject(self, _cmd, chTag, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (NSString *)chTag {
    return objc_getAssociatedObject(self, @selector(setChTag:));
}


@end
