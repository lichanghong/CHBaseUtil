//
//  CHSingletonManager.h
//
//  Created by lichanghong on 2017/4/21.
//  Copyright © 2017年 lichanghong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CHSingletonManager : NSObject

+ (instancetype)sharedInstance;

- (id)sharedInstanceForClass:(Class)aClass;
- (id)sharedInstanceForClass:(Class)aClass category:(NSString *)key;

- (void)destoryInstanceForClass:(Class)aClass;
- (void)destoryInstanceForClass:(Class)aClass category:(NSString *)key;

@end
