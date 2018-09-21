//
//  RouterBaseModule.h
//  Masonry
//
//  Created by lichanghong on 5/2/18.
//  Copyright © 2018 lichanghong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class CHRouterResponse;
@class CHRouterHandleInfo;

typedef void(^CHRouterCallBack)(CHRouterResponse *routerResponse);

@interface RouterBaseModule : NSObject

- (NSArray *)routerURLs;

- (CHRouterResponse *)handleURL:(NSString *)url handleInfo:(CHRouterHandleInfo *)handleInfo;

- (void)handleCallbackWithURL:(NSString *)url
                   identifier:(NSString *)identifier
               responseParams:(id)responseParams;
 
- (void)transitionViewController:(UIViewController *)viewController
                        WithHandleInfo:(CHRouterHandleInfo *)handleInfo
                        animated:(BOOL)animated;

@end
