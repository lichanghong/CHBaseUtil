//
//  CHRouterResponseProtocol.h
//
//  Created by lichanghong on 2018/3/7.
//  Copyright © 2018年 lichanghong. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CHRouterResponse;

@protocol CHRouterResponseProtocol <NSObject>

@optional

- (void)handleRouterResponse:(CHRouterResponse *)routerResponse;

@end
