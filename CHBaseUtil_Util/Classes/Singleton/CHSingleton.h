//
//  CHSingleton.h
//
//  Created by lichanghong on 2017/4/21.
//  Copyright © 2017年 lichanghong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CHSingleton : NSObject

+ (instancetype)sharedInstance;
+ (void)destoryInstance;

@end
