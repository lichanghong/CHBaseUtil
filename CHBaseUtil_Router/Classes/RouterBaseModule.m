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

@property (nonatomic, strong) NSMapTable *routerResponses;
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
             if (handleInfo.delegate) {
                 [self configRouterResponse:handleInfo.delegate forURL:url];
             }
             if (handleInfo.responseCallBack) {
                 [self configRouterCallback:handleInfo.responseCallBack forURL:url];
             }
             return [self handleURL:[url lowercaseString] handleInfo:handleInfo];
         }];
    }
}

- (void)configRouterCallback:(CHRouterCallBack)callBack forURL:(NSString *)url
{
    if (url.length && callBack) {
        [self.routerResponsesCallBacks setObject:callBack forKey:url];
    }
}

- (void)configRouterResponse:(id<CHRouterResponseProtocol>)routerResponse forURL:(NSString *)url
{
    if (url.length && [routerResponse conformsToProtocol:@protocol(CHRouterResponseProtocol)]) {
        [self.routerResponses setObject:routerResponse forKey:url];
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

- (void)handleCallbackWithURL:(NSString *)url identifier:(NSString *)identifier responseParams:(id)responseParams
{
    CHRouterResponse *routerResponse = [[CHRouterResponse alloc] init];
    routerResponse.url = url;
    routerResponse.identifier   = identifier;
    routerResponse.responseParams = responseParams;
    
    id<CHRouterResponseProtocol> response = [self.routerResponses objectForKey:url];
    if ([response respondsToSelector:@selector(handleRouterResponse:)]) {
        [response handleRouterResponse:routerResponse];
    }
    CHRouterCallBack callBack = [self.routerResponsesCallBacks objectForKey:url];
    if (callBack) {
        routerResponse.returnCode = CHRouterResultTypeSuccess;
        callBack(routerResponse);
    }
}

- (void)transitionViewController:(UIViewController *)viewController
                  WithHandleInfo:(CHRouterHandleInfo *)handleInfo
                        animated:(BOOL)animated
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

- (NSMapTable *)routerResponses
{
    if (!_routerResponses) {
        _routerResponses = [NSMapTable strongToWeakObjectsMapTable];
    }
    return _routerResponses;
}
- (NSMapTable *)routerResponsesCallBacks
{
    if (!_routerResponsesCallBacks) {
        _routerResponsesCallBacks = [NSMapTable strongToWeakObjectsMapTable];
    }
    return _routerResponsesCallBacks;
}




@end
