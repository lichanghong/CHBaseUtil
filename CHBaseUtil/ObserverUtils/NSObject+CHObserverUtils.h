//
//  NSObject+CHObserverUtils.h
//
//  Created by lizenan on 2017/4/19.
//  Copyright © 2017年 lizenan. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CHObserverUtils;

@interface NSObject (CHObserverUtils)

// 为每一个NSObject增加一个懒加载的observerUtils对象，用来管理object内部实现的KVO，使用时直接调用self.observerUtils即可
/*
 [self.observerUtils addTarget:self.view keyPath:@"frame" options:NSKeyValueObservingOptionNew observerCallback:^(NSString * _Nonnull keyPath, id  _Nullable oldValue, id  _Nullable newValue) {
 [weakSelf handleViewFrame];
 }];
*/
@property (nonatomic, strong) CHObserverUtils *observerUtils;

@end
