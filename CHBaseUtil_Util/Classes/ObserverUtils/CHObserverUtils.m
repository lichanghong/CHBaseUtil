//
//  CHObserverUtils.m
//
//  Created by lichanghong on 2017/4/19.
//  Copyright © 2017年 lizenan. All rights reserved.
//

#import "CHObserverUtils.h"

@interface CHObserverInfo : NSObject

@property (nonatomic, copy) NSString *keyPath;
@property (nonatomic, copy) CHObserverCallbackBlock callbackBlock;

+ (instancetype)observerInfoWithKeyPath:(NSString *)keyPath
                          callbackBlock:(CHObserverCallbackBlock)callbackBlock;

@end

@implementation CHObserverInfo

+ (instancetype)observerInfoWithKeyPath:(NSString *)keyPath
                          callbackBlock:(CHObserverCallbackBlock)callbackBlock
{
    CHObserverInfo *observerInfo = [[self alloc] init];
    observerInfo.keyPath = keyPath;
    observerInfo.callbackBlock = callbackBlock;
    return observerInfo;
}

@end


@interface CHObserverUtils()

@property (nonatomic, strong) NSRecursiveLock *recursiveLock;
@property (nonatomic, strong) NSMapTable *observersTable;
@property (nonatomic, strong) NSMapTable *targetsTable;

@end

@implementation CHObserverUtils
- (void)dealloc
{
    // utils对象销毁时，移除当前对象中添加的所有observer
    NSDictionary *targets = [_targetsTable dictionaryRepresentation];
    for (id target in targets.allValues) {
        [self removeObserverForTarget:target];
    }
    [_observersTable removeAllObjects];
    [_targetsTable removeAllObjects];
}

+ (instancetype)observerUtils
{
    return [[self alloc] init];
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _observersTable = [NSMapTable strongToStrongObjectsMapTable];
        _targetsTable = [NSMapTable strongToWeakObjectsMapTable];
        _recursiveLock = [[NSRecursiveLock alloc] init];
    }
    return self;
}

- (void)addTarget:(id)target
          keyPath:(NSString *)keyPath
          options:(NSKeyValueObservingOptions)options
 observerCallback:(CHObserverCallbackBlock)callbackBlock
{
    BOOL condition = target && keyPath.length;
    NSAssert(condition, @"target或keyPath为空");
    
    // 线程安全
    [self taskExecutingSafety:^{
        NSString *targetKey = [self keyForTarget:target];
        NSHashTable *table = (NSHashTable *)[self.observersTable objectForKey:targetKey];
        if (!table) {
            table = [NSHashTable hashTableWithOptions:NSPointerFunctionsStrongMemory];
            [self.observersTable setObject:table forKey:targetKey];
            [self.targetsTable setObject:target forKey:targetKey];
        }
        
        CHObserverInfo *observerInfo = [self observerInfoForKeyPath:keyPath inHashTable:table];
        if (!observerInfo) {
            observerInfo = [CHObserverInfo observerInfoWithKeyPath:keyPath
                                                     callbackBlock:callbackBlock];
            [target addObserver:self forKeyPath:keyPath options:options context:nil];
        }
        observerInfo.callbackBlock = callbackBlock;
        [table addObject:observerInfo];
    }];
}

- (void)removeObserverForTarget:(id)target
{
    [self removeObserverWithKeyPath:nil forTarget:target];
}

- (void)removeObserverWithKeyPath:(NSString *)keyPath forTarget:(id)target
{
    NSAssert(target, @"target不能为空");
    
    // 线程安全
    [self taskExecutingSafety:^{
        NSString *targetKey = [self keyForTarget:target];
        NSHashTable *table = [self.observersTable objectForKey:targetKey];
        if (!table) {
            NSLog(@"%@没有添加observer", target);
            return;
        }
        
        if (!keyPath.length) {
            for (CHObserverInfo *observerInfo in table.allObjects) {
                [target removeObserver:self forKeyPath:observerInfo.keyPath];
            }
            [self.observersTable removeObjectForKey:targetKey];
            [self.targetsTable removeObjectForKey:targetKey];
            return;
        }
        
        CHObserverInfo *observerInfo = [self observerInfoForKeyPath:keyPath inHashTable:table];
        if (!observerInfo) {
            NSLog(@"%@的%@属性没有添加对应的观察者", target, keyPath);
            return;
        }
        
        [target removeObserver:self forKeyPath:keyPath];
        [table removeObject:observerInfo];
    }];
}

#pragma mark - enumerate method

- (CHObserverInfo *)observerInfoForKeyPath:(NSString *)keyPath inHashTable:(NSHashTable *)table
{
    CHObserverInfo *observerInfo = nil;
    for (CHObserverInfo *obj in table.allObjects) {
        if ([obj.keyPath isEqualToString:keyPath]) {
            observerInfo = obj;
            break;
        }
    }
    
    return observerInfo;
}

#pragma mark - observer delegate

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    BOOL condition = object && keyPath.length;
    NSAssert(condition, @"target或者keyPath不存在");
    
    NSString *targetKey = [self keyForTarget:object];
    NSHashTable *table = [self.observersTable objectForKey:targetKey];
    if (!table) {
        NSLog(@"%@没有observer", object);
        return;
    }
    
    CHObserverInfo *observerInfo = [self observerInfoForKeyPath:keyPath inHashTable:table];
    if (observerInfo && observerInfo.callbackBlock) {
        id oldValue = [change objectForKey:NSKeyValueChangeOldKey];
        id newValue = [change objectForKey:NSKeyValueChangeNewKey];
        
        observerInfo.callbackBlock(keyPath, oldValue, newValue);
    }
}

#pragma mark - utils

- (NSString *)keyForTarget:(id)target
{
    return [NSString stringWithFormat:@"%p", target];
}

- (void)taskExecutingSafety:(dispatch_block_t)task
{
    [self.recursiveLock lock];
    if (task) {
        task();
    }
    [self.recursiveLock unlock];
}

@end
