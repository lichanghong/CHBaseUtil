//
//  lichanghong
//
//  Created by lichanghong on 2017/12/19.
//  Copyright © 2017年 lichanghong. All rights reserved.
//

#import "CHCrashManager.h"
#import <UIKit/UIKit.h>

@implementation CHCrashManager

- (void)replaceMethod {
    
    NSString *message = [NSString stringWithFormat:@"%@ 异常调用",self.methodName];
    
    [CHCrashManager showMessage:self.claseName crashMessage:message];
}

+ (void)showCrashMessage:(NSString *)cName crashMethod:(NSString *)mName {
    
    [CHCrashManager showMessage:cName crashMessage:mName];
}

+ (void)showMessage:(NSString *)className crashMessage:(NSString *)message {
    
    NSArray *callArray = [NSThread callStackSymbols];
    NSArray *stackArray = [NSThread callStackReturnAddresses];
    dispatch_async(dispatch_get_main_queue(),^{
        [[[UIAlertView alloc] initWithTitle:className message:message
                                   delegate:nil
                          cancelButtonTitle:@"确定"
                          otherButtonTitles:nil,nil] show];
    });
    NSLog(@"callStackSymbols:%@\ncallStackReturnAddresses=%@\n,className=%@ , message=%@",callArray,stackArray,className,message);

}

- (void)dealloc {
    
    _claseName = nil;
    
    _methodName = nil;
}

@end
