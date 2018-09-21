//
//  NSObject.h
//  ProjectDemo
//
//  Created by lichanghong on 5/4/18.
//  Copyright © 2018 lichanghong. All rights reserved.
//

#import "CHRouter.h"

@interface NSObject (CHRouter)

- (CHRouterResponse *)ch_openURL:(NSString *)url;
- (CHRouterResponse *)ch_openURL:(NSString *)url
                        delegate:(id<CHRouterResponseProtocol>)delegate;
- (CHRouterResponse *)ch_openURL:(NSString *)url
                responseCallBack:(RouterResponseCallBack)responseCallBack;

- (CHRouterResponse *)ch_openURL:(NSString *)url
            sourceViewController:(UIViewController *)sourceViewController;
- (CHRouterResponse *)ch_openURL:(NSString *)url
                routerParameters:(NSDictionary *)routerParameters
            sourceViewController:(UIViewController *)sourceViewController;
- (CHRouterResponse *)ch_openURL:(NSString *)url
                     routerParameters:(NSDictionary *)routerParameters
                 sourveViewController:(UIViewController *)sourceViewController
                       responseCallBack:(RouterResponseCallBack)responseCallBack;

#pragma mark - class methods

+ (CHRouterResponse *)ch_openURL:(NSString *)url;
+ (CHRouterResponse *)ch_openURL:(NSString *)url
                        delegate:(id<CHRouterResponseProtocol>)delegate;
+ (CHRouterResponse *)ch_openURL:(NSString *)url
                responseCallBack:(RouterResponseCallBack)responseCallBack;

+ (CHRouterResponse *)ch_openURL:(NSString *)url sourceViewController:(UIViewController *)sourceViewController;
+ (CHRouterResponse *)ch_openURL:(NSString *)url routerParameters:(NSDictionary *)routerParameters sourceViewController:(UIViewController *)sourceViewController;
+ (CHRouterResponse *)ch_openURL:(NSString *)url
                     routerParameters:(NSDictionary *)routerParameters
                 sourveViewController:(UIViewController *)sourceViewController
                       responseCallBack:(RouterResponseCallBack)responseCallBack;

/// 加载webView时使用该方法
//+ (CHRouterResponse *)ch_openURLWithWebContainer:(NSString *)url
//                                     routerParameters:(NSDictionary *)routerParameters
//                                        containerMode:(SYWebContainerMode)containerMode
//                                    containerPageType:(SYWebPageType)pageType;
@end
