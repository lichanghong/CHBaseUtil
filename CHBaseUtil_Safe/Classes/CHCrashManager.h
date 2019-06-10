//
//  lichanghong
//
//  Created by lichanghong on 2017/12/19.
//  Copyright © 2017年 lichanghong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CHCrashManager : NSObject

@property (nonatomic,copy) NSString *claseName;

@property (nonatomic,copy) NSString *methodName;

+ (void)showCrashMessage:(NSString *)cName crashMethod:(NSString *)mName;

- (void)replaceMethod;

@end
