//
//  NSObject.m
//  ProjectDemo
//
//  Created by lichanghong on 5/4/18.
//  Copyright © 2018 lichanghong. All rights reserved.
//

#import "NSObject+CHRouter.h"

@implementation NSObject (CHRouter)
- (CHRouterResponse *)ch_openURL:(NSString *)url
{
    return [self ch_openURL:url sourceViewController:nil];
}
- (CHRouterResponse *)ch_openURL:(NSString *)url sourceViewController:(UIViewController *)sourceViewController{
    return [self ch_openURL:url routerParameters:nil sourceViewController:sourceViewController];
}
- (CHRouterResponse *)ch_openURL:(NSString *)url routerParameters:(NSDictionary *)routerParameters sourceViewController:(UIViewController *)sourceViewController{
    return [self ch_openURL:url routerParameters:routerParameters sourveViewController:sourceViewController responseCallBack:nil];
}
- (CHRouterResponse *)ch_openURL:(NSString *)url
                routerParameters:(NSDictionary *)routerParameters
            sourveViewController:(UIViewController *)sourceViewController
                responseCallBack:(RouterResponseCallBack)responseCallBack{
    CHRouterRequest *request = [[CHRouterRequest alloc] init];
    request.url = url;
    request.parameters = routerParameters;
    request.sourceViewController = sourceViewController;
    return [[CHRouter sharedInstance] openWithRequest:request responseCallBack:responseCallBack];
}

+ (CHRouterResponse *)ch_openURL:(NSString *)url
{
   return [self ch_openURL:url];
}

+ (CHRouterResponse *)ch_openURL:(NSString *)url sourceViewController:(UIViewController *)sourceViewController{
    return [self ch_openURL:url routerParameters:nil sourceViewController:sourceViewController];
}
+ (CHRouterResponse *)ch_openURL:(NSString *)url routerParameters:(NSDictionary *)routerParameters sourceViewController:(UIViewController *)sourceViewController{
    return [self ch_openURL:url routerParameters:routerParameters sourveViewController:sourceViewController responseCallBack:nil];
}
+ (CHRouterResponse *)ch_openURL:(NSString *)url
                routerParameters:(NSDictionary *)routerParameters
            sourveViewController:(UIViewController *)sourceViewController
                responseCallBack:(RouterResponseCallBack)responseCallBack{
    CHRouterRequest *request = [[CHRouterRequest alloc] init];
    request.url = url;
    request.parameters = routerParameters;
    request.sourceViewController = sourceViewController;
    return [[CHRouter sharedInstance] openWithRequest:request responseCallBack:responseCallBack];
}

@end
