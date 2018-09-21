//
//  CHRouter.h
//  Masonry
//
//  Created by lichanghong on 5/2/18.
//  Copyright © 2018 lichanghong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "CHRouterResponseProtocol.h"

//通知没注册的路由，如http: 跳转h5等,参数是 SYRouterHandleInfo
CG_EXTERN NSString *CHRouterUndefinedURLHTTPNotificationName;

//枚举返回类型
typedef NS_ENUM(NSInteger, CHRouterResultType) {
    CHRouterResultTypeUnknown,             // 未知错误
    CHRouterResultTypeSuccess,             // 处理成功
    CHRouterResultTypeURLNotExisted,       // URL不存在
    CHRouterResultTypeURLHTTP,             // webURL
    CHRouterResultTypeNONavi,              // 没有navigation
};

@interface CHRouterRequest : NSObject

@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSDictionary *parameters;
@property (nonatomic, weak) UIViewController *sourceViewController;

@end

@interface CHRouterResponse : NSObject
@property (nonatomic, assign) CHRouterResultType returnCode;
@property (nonatomic, copy) NSString *returnMessage;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, strong) id responseParams;

@end

//路由回调
typedef void(^RouterResponseCallBack)(CHRouterResponse *routerResponse);


@interface CHRouterHandleInfo : NSObject

@property (nonatomic, copy) NSDictionary *parameters;
@property (nonatomic, weak) UIViewController *sourceViewController;
@property (nonatomic, weak) UINavigationController *sourveNavigationController;
@property (nonatomic, copy) RouterResponseCallBack responseCallBack;
@property (nonatomic, weak) id<CHRouterResponseProtocol> delegate;

@end


//路由回调，注册用
typedef CHRouterResponse *(^CHURLHandler)(CHRouterHandleInfo *handleInfo);

@interface CHRouter : NSObject

@property (nonatomic, copy, readonly) NSArray *allURLPatterns;

//nativeURLSchemes 本地路由的前缀schemes，需要在使用路由之前赋值
@property (nonatomic, copy) NSArray *nativeURLSchemes;

- (void)registerURL:(NSString *)url withURLHandler:(CHURLHandler)urlHandler;

- (CHRouterResponse *)openURL:(NSString *)url sourceViewController:(UIViewController *)sourceViewController;

- (CHRouterResponse *)openURL:(NSString *)url
             routerParameters:(NSDictionary *)routerParameters
         sourceViewController:(UIViewController *)sourceViewController;

- (CHRouterResponse *)openURL:(NSString *)url
             routerParameters:(NSDictionary *)routerParameters
         sourceViewController:(UIViewController *)sourceViewController
               responseCallBack:(RouterResponseCallBack)responseCallBack;
- (CHRouterResponse *)openURL:(NSString *)url
             routerParameters:(NSDictionary *)routerParameters
         sourceViewController:(UIViewController *)sourceViewController
                     delegate:(id<CHRouterResponseProtocol>)delegate;

- (CHRouterResponse *)openWithRequest:(CHRouterRequest *)urlRequest
                     responseCallBack:(RouterResponseCallBack)responseCallBack;
- (CHRouterResponse *)openWithRequest:(CHRouterRequest *)urlRequest
                             delegate:(id<CHRouterResponseProtocol>)delegate;


//注册所有模块的路由
+ (instancetype)sharedInstance;
+ (void)registerAllModules;


@end






