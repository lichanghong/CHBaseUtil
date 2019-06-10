//  CHBaseUtil
//
//  Created by lichanghong on 13/02/2018.
//  Copyright © 2018 lichanghong. All rights reserved.

#import "NSObject+SafeSelection.h"

void CTSwizzledAction(Class class,SEL currentMethod,SEL hookMethod) {
    
    if (class && currentMethod && hookMethod)
    {
        Method oneMethod = class_getInstanceMethod(class,currentMethod);
        
        Method twoMethod = class_getInstanceMethod(class,hookMethod);
        
        if (class_addMethod(class,currentMethod,method_getImplementation(twoMethod),method_getTypeEncoding(twoMethod)))
        {
            class_replaceMethod(class,hookMethod,method_getImplementation(oneMethod),method_getTypeEncoding(oneMethod));
        }
        else
        {
            method_exchangeImplementations(oneMethod,twoMethod);
        }
    }
}

@implementation NSObject (SafeSelection)

+ (void)classReplaceMethod:(SEL)currentMethod hookMethod:(SEL)hookMethod {
    
    Class class = [self class];
    
    CTSwizzledAction(class,currentMethod,hookMethod);
}

+ (void)classImplementationAction {
    
    Class class = [self class];
    
    CTSwizzledAction(class,@selector(methodSignatureForSelector:),@selector(hook_methodSignatureForSelector:));
    
    CTSwizzledAction(class,@selector(forwardInvocation:),@selector(hook_forwardInvocation:));
}

#pragma mark -
#pragma mark Hook Methods

+ (void)load {

#if DEBUG
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken,^{
        
        [self classImplementationAction];
    });
    
#endif

}

- (NSMethodSignature *)hook_methodSignatureForSelector:(SEL)aSelector {
    
    if ([self isKindOfClass:NSClassFromString(@"_UIWebViewScrollViewDelegateForwarder")])
    {
        return [self hook_methodSignatureForSelector:aSelector];
    }
    
    if ([self isKindOfClass:NSClassFromString(@"UITextInputController")])
    {
        return [self hook_methodSignatureForSelector:aSelector];
    }

    if ([NSStringFromClass([self class]) hasPrefix:@"UIKeyboard"])
    {
        return [self hook_methodSignatureForSelector:aSelector];
    }
    
    /************************************/
    /************************************/
    /************************************/
    
    NSMethodSignature *methodSignture = [self hook_methodSignatureForSelector:aSelector];

    if (methodSignture)
    {
        return methodSignture;
    }
    else
    {
        [self setHookForwardInvocation:YES];
        
        CHCrashManager *crashMethod = [[CHCrashManager alloc] init];
        
        return [crashMethod methodSignatureForSelector:@selector(replaceMethod)];
    }
}

- (void)hook_forwardInvocation:(NSInvocation *)invocation {
    
    BOOL checkForward = [self checkHookForwardInvocation];
    
    [self clearHookForwardInvocation];
    
    if (checkForward)
    {
        CHCrashManager *invokeTarget = [[CHCrashManager alloc] init];
        invokeTarget.claseName = NSStringFromClass([self class]);
        invokeTarget.methodName = NSStringFromSelector(invocation.selector);
        
        invocation.selector = @selector(replaceMethod);
        [invocation invokeWithTarget:invokeTarget];
    }
    else
    {
        [self hook_forwardInvocation:invocation];
    }
}

#pragma mark -
#pragma mark Associated Methods

- (BOOL)checkHookForwardInvocation {
    
    NSNumber *number = objc_getAssociatedObject(self,_cmd);
    
    return (number && number.boolValue);
}

- (void)setHookForwardInvocation:(BOOL)check {
    
    NSNumber *number = [NSNumber numberWithBool:check];
    
    objc_setAssociatedObject(self,@selector(checkHookForwardInvocation),number,OBJC_ASSOCIATION_RETAIN);
}

- (void)clearHookForwardInvocation {
    
    objc_setAssociatedObject(self,@selector(checkHookForwardInvocation),nil,OBJC_ASSOCIATION_RETAIN);
}

@end
