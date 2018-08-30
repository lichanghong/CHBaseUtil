//
//  CDFSingleton.m
//
//  Created by lichanghong on 2017/4/21.
//  Copyright © 2017年 lichanghong. All rights reserved.
//

#import "CHSingleton.h"
#import "CHSingletonManager.h"

@implementation CHSingleton

+ (instancetype)sharedInstance
{
    return [[CHSingletonManager sharedInstance] sharedInstanceForClass:self];
}

+ (void)destoryInstance
{
    [[CHSingletonManager sharedInstance] destoryInstanceForClass:self];
}

@end
