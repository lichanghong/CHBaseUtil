//
//  RouterBaseModule.m
//  Masonry
//
//  Created by lichanghong on 5/2/18.
//  Copyright © 2018 lichanghong. All rights reserved.
//

#import "RouterBaseModule.h"
#import "CHRouter.h"
#import "NSDictionary+CHRouter.h"

@interface RouterBaseModule()

@property (nonatomic, strong) NSMapTable *routerResponsesCallBacks;

@end

@implementation RouterBaseModule

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self registerURLs];
    }
    return self;
}

- (void)registerURLs
{
    for (NSString *url in [self routerURLs]) {
        [[CHRouter sharedInstance] registerURL:url
                                withURLHandler:^CHRouterResponse *(CHRouterHandleInfo *handleInfo)
         {
             if (handleInfo.responseCallBack) {
                 if (url.length && handleInfo.responseCallBack) {
                     [self.routerResponsesCallBacks setObject:handleInfo.responseCallBack forKey:url];
                 }
             }
             return [self handleURL:[url lowercaseString] handleInfo:handleInfo];
         }];
    }
}

- (CHRouterResponse *)handleURL:(NSString *)url handleInfo:(CHRouterHandleInfo *)handleInfo
{
    return nil;
}

- (NSArray *)routerURLs
{
    NSAssert(NO, @"子类必须重写该方法，指定该module需要处理的url");
    return nil;
}

- (void)handleCallbackWithURL:(NSString *)url responseActionName:(NSString *)responseActionName responseActionParams:(id)params
{
    RouterResponseCallBack responseCallBack = [self.routerResponsesCallBacks objectForKey:url];
    if (responseCallBack) {
        CHRouterResponse *routerResponse = [[CHRouterResponse alloc] init];
        routerResponse.url = url;
        routerResponse.responseActionName   = responseActionName;
        routerResponse.responseActionParams = params;
        responseCallBack(routerResponse);
    }
}

- (void)transitionViewController:(UIViewController *)viewController WithHandleInfo:(CHRouterHandleInfo *)handleInfo animated:(BOOL)animated
{
    if (!viewController) {
        return;
    }
    if ([handleInfo.parameters transitionType] == CHRouterVCTransitionTypePresent) {
        UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:viewController];
        [handleInfo.sourveNavigationController presentViewController:navi animated:animated completion:nil];
    } else {
        [handleInfo.sourveNavigationController pushViewController:viewController animated:animated];
    }
}


- (NSMapTable *)routerResponsesCallBacks
{
    if (!_routerResponsesCallBacks) {
        _routerResponsesCallBacks = [NSMapTable strongToWeakObjectsMapTable];
    }
    return _routerResponsesCallBacks;
}




@end
