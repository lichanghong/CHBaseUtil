//
//  CHRouter.m
//  Masonry
//
//  Created by lichanghong on 5/2/18.
//  Copyright © 2018 lichanghong. All rights reserved.
//

#import "CHRouter.h"
#import <dlfcn.h>
#import <mach-o/ldsyms.h>
#import <objc/runtime.h>
#import "RouterBaseModule.h"

NSString *CHRouterUndefinedURLHTTPNotificationName = @"CHRouterUndefinedURLHTTPNotificationName";


@implementation CHRouterRequest

@end

@implementation CHRouterResponse
- (instancetype)init
{
    self = [super init];
    if (self) {
        _returnCode = CHRouterResultTypeUnknown;
    }
    return self;
}
@end


@implementation CHRouterHandleInfo

@end

@interface CHRouter()
@property (nonatomic, strong) NSMutableArray<__kindof RouterBaseModule *> *allModules;
@property (nonatomic, strong) NSMutableDictionary<NSString *,CHURLHandler> *urlHandlers;

@end

@implementation CHRouter

+(instancetype)sharedInstance{
    static CHRouter *router;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        router = [[self alloc] init];
    });
    return router;
}

#pragma mark -  注册模块

+ (void)registerAllModules
{
    [[CHRouter sharedInstance] registerAllModules];
}

- (void)registerAllModules
{
    unsigned int count = 0;
    const char **classes = nil;
    Dl_info info;
    dladdr(&_mh_execute_header, &info);
    classes = objc_copyClassNamesForImage(info.dli_fname, &count);
    
    for (int index = 0; index < count; ++index) {
        NSString *className = [NSString stringWithCString:classes[index] encoding:NSUTF8StringEncoding];
        Class class = NSClassFromString(className);
        if ([class isSubclassOfClass:[RouterBaseModule class]] && ![className isEqualToString:@"RouterBaseModule"]) {
            [self.allModules addObject:[[class alloc] init]];
        }
    }
}

- (void)registerURL:(NSString *)url withURLHandler:(CHURLHandler)urlHandler
{
    if (![[self.urlHandlers allKeys] containsObject:url] && urlHandler) {
        if (!urlHandler || !url) {
            return ;
        }
        [self.urlHandlers setObject:urlHandler forKey:url];
    }
}

#pragma mark -  handle url

- (CHRouterResponse *)openURL:(NSString *)url sourceViewController:(UIViewController *)sourceViewController
{
    return [self openURL:url routerParameters:nil sourceViewController:sourceViewController];
}

- (CHRouterResponse *)openURL:(NSString *)url routerParameters:(NSDictionary *)routerParameters sourceViewController:(UIViewController *)sourceViewController
{
    return [self openURL:url routerParameters:routerParameters sourceViewController:sourceViewController responseCallBack:nil];
}

- (CHRouterResponse *)openURL:(NSString *)url routerParameters:(NSDictionary *)routerParameters sourceViewController:(UIViewController *)sourceViewController delegate:(id<CHRouterResponseProtocol>)delegate
{
    return [self openURL:url routerParameters:routerParameters sourceViewController:sourceViewController delegate:delegate responseCallBack:nil];
}
- (CHRouterResponse *)openURL:(NSString *)url routerParameters:(NSDictionary *)routerParameters sourceViewController:(UIViewController *)sourceViewController responseCallBack:(RouterResponseCallBack)responseCallBack
{
    return [self openURL:url routerParameters:routerParameters sourceViewController:sourceViewController delegate:nil responseCallBack:responseCallBack];
}

- (CHRouterResponse *)openURL:(NSString *)url routerParameters:(NSDictionary *)routerParameters sourceViewController:(UIViewController *)sourceViewController delegate:(id<CHRouterResponseProtocol>)delegate responseCallBack:(RouterResponseCallBack)responseCallBack
{
    CHRouterRequest *request = [[CHRouterRequest alloc] init];
    request.url = url;
    request.parameters = [self removingPercentEncodingStringParams:routerParameters];
    request.sourceViewController = sourceViewController;
    
    CHRouterResponse *response = nil;
    if (responseCallBack) {
        response = [self openWithRequest:request responseCallBack:responseCallBack];
    }
    else if (delegate)
    {
        response = [self openWithRequest:request delegate:delegate];
    }
    return response;
}

- (CHRouterResponse *)openWithRequest:(CHRouterRequest *)urlRequest delegate:(id<CHRouterResponseProtocol>)delegate callBack:(RouterResponseCallBack)responseCallBack
{
    CHRouterResponse *response = [[CHRouterResponse alloc] init];
    response.returnCode = CHRouterResultTypeUnknown;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"<a.*?href=(['\"])(.*?)['\"].*?>(.*?)</a>" options:0 error:nil];
    NSString *originalURL = [regex stringByReplacingMatchesInString:urlRequest.url options:0 range:NSMakeRange(0, [urlRequest.url length]) withTemplate:@"$2"];
    
    if (!originalURL.length) {
        response.returnCode = CHRouterResultTypeURLNotExisted;
        response.returnMessage = @"URL不存在";
        return response;
    }
    
    NSString *url = [self router_urlWithoutQuery:originalURL];
    NSString *urlScheme = [self chRouterUrlSchemeWithStr:url];
    NSDictionary *urlParameters = [self routerUrlQueryDictionary:originalURL];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    if (urlParameters) {
        [parameters addEntriesFromDictionary:urlParameters];
    }
    if (urlRequest.parameters) {
        [parameters addEntriesFromDictionary:urlRequest.parameters];
    }
    
    CHRouterHandleInfo *handleInfo = [[CHRouterHandleInfo alloc] init];
    handleInfo.parameters = [parameters copy];
    handleInfo.responseCallBack=responseCallBack;
    handleInfo.delegate = delegate;
    
    if (urlRequest.sourceViewController) {
        UIViewController *sourceVC = urlRequest.sourceViewController;
        UINavigationController *sourceNavi = nil;
        if ([sourceVC isKindOfClass:[UINavigationController class]]) {
            sourceNavi = (UINavigationController *)urlRequest.sourceViewController;
        } else {
            sourceNavi = sourceVC.navigationController;
        }
        handleInfo.sourceViewController = sourceVC ? : [self router_m_currentViewController];
        handleInfo.sourveNavigationController = sourceNavi ? : [self router_m_currentViewController].navigationController;
    }
    else {
        handleInfo.sourceViewController = [self router_m_currentViewController];
        handleInfo.sourveNavigationController = handleInfo.sourceViewController.navigationController;
    }
    
    if (!handleInfo.sourveNavigationController) {
        response.returnCode = CHRouterResultTypeNONavi;
        response.returnMessage = @"导航控制器跑哪去了";
        return response;
    }
    if ([[self nativeURLSchemes] containsObject:urlScheme]) {
        CHURLHandler handler = [self.urlHandlers objectForKey:url];
        if (handler) {
            response = handler(handleInfo);
        } else {
            response.returnCode = CHRouterResultTypeURLNotExisted;
            response.returnMessage = [NSString stringWithFormat:@"该%@未注册对应的routerModule", url];
        }
    }
    else
    {
        response.returnCode = CHRouterResultTypeURLHTTP;
        response.returnMessage = @"h5页面需要加载webView";
        [[NSNotificationCenter defaultCenter] postNotificationName:CHRouterUndefinedURLHTTPNotificationName object:handleInfo];;
    }
    return response;
}

#pragma mark - url methods

- (NSArray *)nativeURLSchemes
{
    if (!_nativeURLSchemes) {
        _nativeURLSchemes = [NSArray arrayWithObjects:@"aaaa.xxx", @"app.so",@"app.jump", nil];
    }
    return _nativeURLSchemes;
}

- (CHRouterResponse *)openWithRequest:(CHRouterRequest *)urlRequest responseCallBack:(RouterResponseCallBack)responseCallBack
{
    return [self openWithRequest:urlRequest delegate:nil callBack:responseCallBack];
}
            
- (CHRouterResponse *)openWithRequest:(CHRouterRequest *)urlRequest delegate:(id<CHRouterResponseProtocol>)delegate
{
    return [self openWithRequest:urlRequest delegate:delegate callBack:nil];
}

- (UIViewController *)findTopmostViewController:(UIViewController *)rootViewController
{
    if (rootViewController.presentedViewController) {
        return [self findTopmostViewController:rootViewController.presentedViewController];
    } else if ([rootViewController isKindOfClass:[UISplitViewController class]]) {
        UISplitViewController *svc = (UISplitViewController *)rootViewController;
        if (svc.viewControllers.count) {
            return [self findTopmostViewController:svc.viewControllers.lastObject];
        } else {
            return rootViewController;
        }
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController *navi = (UINavigationController *)rootViewController;
        if (navi.viewControllers.count) {
            return [self findTopmostViewController:[navi.viewControllers lastObject]];
        } else {
            return rootViewController;
        }
    } else if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarController = (UITabBarController *)rootViewController;
        if (tabBarController.viewControllers.count) {
            return [self findTopmostViewController:tabBarController.selectedViewController];
        } else {
            return rootViewController;
        }
    } else {
        return rootViewController;
    }
}

- (UIViewController *)router_m_currentViewController
{
    UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    return [self findTopmostViewController:rootViewController];
}

- (NSMutableDictionary *)removingPercentEncodingStringParams:(NSDictionary *)params
{
    NSMutableDictionary *copyParam = [NSMutableDictionary dictionary];
    [params enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[NSString class]]) {
            NSString *str = [(NSString *)obj stringByRemovingPercentEncoding];
            [copyParam setObject:str forKey:key];
        } else {
            [copyParam setObject:obj forKey:key];
        }
    }];
    return copyParam;
}

- (NSString *)router_urlWithoutQuery:(NSString *)url
{
    NSURL *URL = [NSURL URLWithString:url];
    NSString *query = URL.query;
    if (query && [query length]>0) {
        NSString *url = URL.absoluteString;
        NSRange range = [url rangeOfString:query];
        if (range.length>0) {
            NSString *pureURL = [url substringToIndex:range.location-1];
            return pureURL;
        }else{
            return url;
        }
    }else{
        if (!URL) {
            // 可能url中有中文，做特殊处理
            return [[url componentsSeparatedByString:@"?"] firstObject];
        }
        return url;
    }
}

- (NSDictionary *)routerUrlQueryDictionary:(NSString *)url
{
    // 先判断是否是url
    NSString *queryStr = [self chRouterUrlSchemeWithStr:url];
    if (!queryStr) {
        queryStr = url;
    }
    NSMutableDictionary *queryDict = [NSMutableDictionary dictionary];
    NSArray *components = [queryStr componentsSeparatedByString:@"&"];
    
    __block NSString *key = nil;
    __block NSString *value = nil;
    [components enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *temp = (NSString *)obj;
        NSRange range = [temp rangeOfString:@"="];
        
        if (range.location != NSNotFound) {
            key = [temp substringToIndex:range.location];
            value = [temp substringFromIndex:range.location+1];
            
            value = [value stringByRemovingPercentEncoding];
            value = [value stringByRemovingPercentEncoding];
            [queryDict setObject:value ? value : @"" forKey:key];
        }
    }];
    
    return queryDict;
}

- (NSString *)chRouterUrlSchemeWithStr:(NSString *)str
{
    if (str == nil || str.length == 0) {
        return nil;
    }
    NSString *formatURL = [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL *candidateURL = [NSURL URLWithString:formatURL];
    if (candidateURL && candidateURL.scheme.length && candidateURL.host) {
        NSURL *url = [NSURL URLWithString:formatURL];
        return url.scheme;
    }
    return nil;
}

- (NSMutableDictionary *)urlHandlers
{
    if (!_urlHandlers) {
        _urlHandlers = [NSMutableDictionary dictionary];
    }
    return _urlHandlers;
}




@end
