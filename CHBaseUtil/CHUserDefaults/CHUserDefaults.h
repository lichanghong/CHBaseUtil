//
//  CHUserDefaults.h
//  CHUserDefaults
//
//  Created by lichanghong on 18-12-18.
//  Copyright (c) 2018 lichanghong. All rights reserved.
//

/**
 *  自定义的userdefaults 为了防止系统的NSUserDefaults内容过于繁杂
 *  用法是直接用单利，然后存取的key和value，直接用property设置即可
 
 
 *  [[NSUserDefaults standardUserDefaults] setObject:@"AAA" forKey:@"username"];
    [[NSUserDefaults standardUserDefaults] synchronize];  --> 系统用法
 
 *  [CHUserDefaults standardUserDefaults].username = @"AAA"; --> 当前用法
 
 * NSString * username = [[NSUserDefaults standardUserDefaults] objectForKey:@"username"] --> 系统用法
 
 * NSString * username = [CHUserDefaults standardUserDefaults].username; -->当前用法
 
 * 需要的key直接在CHUserDefaults+Properties添加property即可
 *
 */


#import <Foundation/Foundation.h>

@interface CHUserDefaults : NSObject

+ (instancetype)standardUserDefaults;

@end
