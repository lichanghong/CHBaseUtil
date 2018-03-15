//
//  CHObserverUtils.h
//
//  Created by lichanghong on 2017/4/19.
//  Copyright © 2017年 lichanghong. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^CHObserverCallbackBlock)(NSString * __nonnull keyPath, __nullable id oldValue, __nullable id newValue);

@interface CHObserverUtils : NSObject

+ (nullable instancetype)observerUtils;

/*
 * @desc  在当前类中为某一个对象增加观察者
 *
 * @param target 目标对象
 * @param keyPath 对应的keyPath
 * @param options 观察模式
 * @param callbackBlock keyPath值改变后的回调
 */
- (void)addTarget:(nonnull id)target
          keyPath:(NSString * __nonnull)keyPath
          options:(NSKeyValueObservingOptions)options
 observerCallback:(nullable CHObserverCallbackBlock)callbackBlock;

/*
 * @desc  移除当前类对目标对象的观察，调用该方法，会移除当前类中对某个target观察的所有keyPath
 *
 * @param target 目标对象
 */
- (void)removeObserverForTarget:(nonnull id)target;

/*
 * @desc  移除当前类对目标对象指定的keyPath的观察，若keyPath为空，则该方法会移除target的所有keyPath
 *
 * @param keyPath 对应target的keyPath
 * @param target 目标对象
 */
- (void)removeObserverWithKeyPath:(NSString * __nullable)keyPath forTarget:(nullable id)target;

@end
