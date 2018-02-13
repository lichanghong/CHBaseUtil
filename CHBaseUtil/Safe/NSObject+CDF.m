//  CHBaseUtil
//
//  Created by lichanghong on 13/02/2018.
//  Copyright © 2018 lichanghong. All rights reserved.

#import "NSObject+CDF.h"

@implementation NSObject (CDF)

- (void)cdf_safePerformSelector:(NSString *)selectorName
{
    [self cdf_safePerformSelector:selectorName withObject:nil];
}

- (void)cdf_safePerformSelector:(NSString *)selectorName withObject:(id)object
{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    if (selectorName) {
        SEL action = NSSelectorFromString(selectorName);
        if (action && [self respondsToSelector:action]) {
            [self performSelector:action withObject:object];
        }
    }
#pragma clang diagnostic pop
}

- (id)cdf_objectByPerformingSelectorWithArguments:(SEL)selector, ...
{
    id result;
    va_list arglist;
    va_start(arglist, selector);
    [self performSelector:selector withReturnValue:&result andArguments:arglist];
    va_end(arglist);
    
    CFShow((__bridge CFTypeRef)(result));
    return result;
}

- (BOOL)performSelector: (SEL)selector withReturnValue: (void *)result andArguments: (va_list)arglist
{
    NSInvocation *inv = [self invocationWithSelector:selector andArguments:arglist];
    if (!inv)return NO;
    [inv invoke];
    if (result)[inv getReturnValue:result];
    return YES;
}

- (NSInvocation *)invocationWithSelector: (SEL)selector andArguments:(va_list)arguments
{
    if (![self respondsToSelector:selector])return NULL;
    
    NSMethodSignature *ms = [self methodSignatureForSelector:selector];
    if (!ms)return NULL;
    
    NSInvocation *inv = [NSInvocation invocationWithMethodSignature:ms];
    if (!inv)return NULL;
    
    [inv setTarget:self];
    [inv setSelector:selector];
    
    NSUInteger argcount = 2;
    NSUInteger totalArgs = [ms numberOfArguments];
    
    while (argcount < totalArgs)
    {
        char *argtype = (char *)[ms getArgumentTypeAtIndex:argcount];
        if (strcmp(argtype, @encode(id))== 0)
        {
            id argument = va_arg(arguments, id);
            [inv setArgument:&argument atIndex:argcount++];
        }
        else if (
                 (strcmp(argtype, @encode(char))== 0)||
                 (strcmp(argtype, @encode(unsigned char))== 0)||
                 (strcmp(argtype, @encode(short))== 0)||
                 (strcmp(argtype, @encode(unsigned short))== 0)|
                 (strcmp(argtype, @encode(int))== 0)||
                 (strcmp(argtype, @encode(unsigned int))== 0)
                 )
        {
            int i = va_arg(arguments, int);
            [inv setArgument:&i atIndex:argcount++];
        }
        else if (
                 (strcmp(argtype, @encode(long))== 0)||
                 (strcmp(argtype, @encode(unsigned long))== 0)
                 )
        {
            long l = va_arg(arguments, long);
            [inv setArgument:&l atIndex:argcount++];
        }
        else if (
                 (strcmp(argtype, @encode(long long))== 0)||
                 (strcmp(argtype, @encode(unsigned long long))== 0)
                 )
        {
            long long l = va_arg(arguments, long long);
            [inv setArgument:&l atIndex:argcount++];
        }
        else if (
                 (strcmp(argtype, @encode(float))== 0)||
                 (strcmp(argtype, @encode(double))== 0)
                 )
        {
            double d = va_arg(arguments, double);
            [inv setArgument:&d atIndex:argcount++];
        }
        else if (strcmp(argtype, @encode(Class))== 0)
        {
            Class c = va_arg(arguments, Class);
            [inv setArgument:&c atIndex:argcount++];
        }
        else if (strcmp(argtype, @encode(SEL))== 0)
        {
            SEL s = va_arg(arguments, SEL);
            [inv setArgument:&s atIndex:argcount++];
        }
        else if (strcmp(argtype, @encode(char *))== 0)
        {
            char *s = va_arg(arguments, char *);
            [inv setArgument:s atIndex:argcount++];
        }
        else
        {
            NSString *type = [NSString stringWithCString:argtype encoding:NSUTF8StringEncoding];
            if ([type isEqualToString:@"{CGRect={CGPoint=ff}{CGSize=ff}}"])
            {
                CGRect arect = va_arg(arguments, CGRect);
                [inv setArgument:&arect atIndex:argcount++];
            }
            else if ([type isEqualToString:@"{CGPoint=ff}"])
            {
                CGPoint apoint = va_arg(arguments, CGPoint);
                [inv setArgument:&apoint atIndex:argcount++];
            }
            else if ([type isEqualToString:@"{CGSize=ff}"])
            {
                CGSize asize = va_arg(arguments, CGSize);
                [inv setArgument:&asize atIndex:argcount++];
            }
            else
            {
                void *ptr = va_arg(arguments, void *);
                [inv setArgument:ptr atIndex:argcount++];
            }
        }
    }
    
    if (argcount != totalArgs)
    {
        NSLog(@"参数不匹配,期望:%lu, 输入:%lu \n", (unsigned long)[ms numberOfArguments], (unsigned long)argcount);
        return NULL;
    }
    
    return inv;
}


@end
