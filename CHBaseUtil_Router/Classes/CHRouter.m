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

@implementation CHRouterRequest

@end

@implementation CHRouterResponse
- (instancetype)init
{
    self = [super init];
    if (self) {
        _returnCode = CHRouterResultTypeSuccess;
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
        [self.urlHandlers setObject:urlHandler forKey:url];
    }
}

- (CHRouterResponse *)openURL:(NSString *)url sourceViewController:(UIViewController *)sourceViewController
{
    return [self openURL:url routerParameters:nil sourceViewController:sourceViewController];
}

- (CHRouterResponse *)openURL:(NSString *)url routerParameters:(NSDictionary *)routerParameters sourceViewController:(UIViewController *)sourceViewController
{
    return [self openURL:url routerParameters:routerParameters sourceViewController:sourceViewController responseCallBack:nil];
}

- (CHRouterResponse *)openURL:(NSString *)url routerParameters:(NSDictionary *)routerParameters sourceViewController:(UIViewController *)sourceViewController responseCallBack:(RouterResponseCallBack)responseCallBack
{
    CHRouterRequest *request = [[CHRouterRequest alloc] init];
    request.url = url;
    request.parameters = [self removingPercentEncodingStringParams:routerParameters];
    request.sourceViewController = sourceViewController;
    
    CHRouterResponse *response = [self openWithRequest:request responseCallBack:responseCallBack];
    return response;
}

- (CHRouterResponse *)openWithRequest:(CHRouterRequest *)urlRequest responseCallBack:(RouterResponseCallBack)responseCallBack
{
    CHRouterResponse *response = [[CHRouterResponse alloc] init];
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"<a.*?href=(['\"])(.*?)['\"].*?>(.*?)</a>" options:0 error:nil];
    NSString *originalURL = [regex stringByReplacingMatchesInString:urlRequest.url options:0 range:NSMakeRange(0, [urlRequest.url length]) withTemplate:@"$2"];
    
    if (!originalURL.length) {
        response.returnCode = CHRouterResultTypeURLNotExisted;
        response.returnMessage = @"URL不存在";
        return response;
    }
    
//    NSString *urlScheme = [[self urlScheme:originalURL] lowercaseString];
    
    NSString *url = [[self urlWithoutQuery:originalURL] lowercaseString];
    
    NSDictionary *urlParameters = [self urlQueryDictionary:originalURL];
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
    if (urlRequest.sourceViewController) {
        UIViewController *sourceVC = urlRequest.sourceViewController;
        UINavigationController *sourceNavi = nil;
        if ([sourceVC isKindOfClass:[UINavigationController class]]) {
            sourceNavi = (UINavigationController *)urlRequest.sourceViewController;
        } else {
            sourceNavi = sourceVC.navigationController;
        }
        handleInfo.sourceViewController = sourceVC ? : [self currentViewController];
        handleInfo.sourveNavigationController = sourceNavi ? : [self currentViewController].navigationController;
    }
    else {
        handleInfo.sourceViewController = [self currentViewController];
        handleInfo.sourveNavigationController = handleInfo.sourceViewController.navigationController;
    }
    
    CHURLHandler handler = [self.urlHandlers objectForKey:url];
    if (handler == nil) {
        //适配url的大小写问题
        handler = [self.urlHandlers objectForKey: url];
    }
    if (handler) {
        response = handler(handleInfo);
    } else {
        //            [[SYJumpCenter shareSYJumpCenter] goToPageByPath:originalURL Controller:nil];
        response.returnMessage = [NSString stringWithFormat:@"该%@未注册对应的routerModule,应交由jumpCenter处理", url];
    }
    
    return response;
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

- (UIViewController *)currentViewController
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



- (NSString *)urlScheme:(NSString *)str
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

- (NSString *)urlWithoutQuery:(NSString *)url
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

- (NSDictionary *)urlQueryDictionary:(NSString *)url
{
    // 先判断是否是url
    NSString *queryStr = [self urlScheme:url];
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
            value = [value stringByRemovingPercentEncoding];//两次 防止转一次不够   多转不会受影响
            [queryDict setObject:value ? value : @"" forKey:key];
        }
    }];
    
    return queryDict;
}


- (NSMutableDictionary *)urlHandlers
{
    if (!_urlHandlers) {
        _urlHandlers = [NSMutableDictionary dictionary];
    }
    return _urlHandlers;
}

+(instancetype)sharedInstance{
    static CHRouter *router;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        router = [[CHRouter alloc] init];
    });
    return router;
}




@end
