//
//  CHSingletonManager.m
//
//
//  Created by lichanghong on 2017/4/21.
//  Copyright © 2017年 lichanghong. All rights reserved.
//

#import "CHSingletonManager.h"

@interface NSMutableDictionary (CDFSafe)
@end
@implementation NSMutableDictionary (CDFSafe)

- (void)chb_safeSetObject:(id)anObject forKey:(id<NSCopying>)aKey
{
    if (!anObject || !aKey) {
        return ;
    }
    [self setObject:anObject forKey:aKey];
}

- (void)chb_safeRemoveObjectForKey:(id)aKey
{
    if(!aKey) {
        return;
    }
    [self removeObjectForKey:aKey];
}


@end



static CHSingletonManager *manager = nil;

@interface CHSingletonManager()

@property (nonatomic, strong) NSMutableDictionary *singletons;
@property (nonatomic, strong) NSRecursiveLock *recursiveLock;

@end

@implementation CHSingletonManager

+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _singletons = [NSMutableDictionary dictionary];
        _recursiveLock = [[NSRecursiveLock alloc] init];
    }
    return self;
}

- (id)sharedInstanceForClass:(Class)aClass
{
    NSString *key = NSStringFromClass(aClass);
    
    [self.recursiveLock lock];
    id obj = nil;
    if (key) {
        obj = [self.singletons objectForKey:key];
        if (!obj) {
            obj = [[aClass alloc] init];
            [self.singletons chb_safeSetObject:obj forKey:key];
        }
    }
    [self.recursiveLock unlock];
    
    return obj;
}

- (id)sharedInstanceForClass:(Class)aClass category:(NSString *)key
{
    NSString *className = NSStringFromClass(aClass);
    NSString *classKey = [NSString stringWithFormat:@"%@-%@", className, key];
    
    [self.recursiveLock lock];
    id obj = nil;
    if (classKey) {
        obj = [self.singletons objectForKey:classKey];
        if (!obj) {
            obj = [[aClass alloc] init];
            [self.singletons chb_safeSetObject:obj forKey:classKey];
        }
    }
    [self.recursiveLock unlock];
    
    return obj;
}

- (void)destoryInstanceForClass:(Class)aClass
{
    NSString *key = NSStringFromClass(aClass);
    [self.recursiveLock lock];
    [self.singletons chb_safeRemoveObjectForKey:key];
    [self.recursiveLock unlock];
}

- (void)destoryInstanceForClass:(Class)aClass category:(NSString *)key
{
    NSString *className = NSStringFromClass(aClass);
    NSString *classKey = [NSString stringWithFormat:@"%@-%@", className, key];
    
    [self.recursiveLock lock];
    [self.singletons chb_safeRemoveObjectForKey:classKey];
    [self.recursiveLock unlock];
}

@end
