//
//  CHRouter.h
//  Masonry
//
//  Created by lichanghong on 5/2/18.
//  Copyright © 2018 lichanghong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CHRouterVCTransitionType) {
    CHRouterVCTransitionTypeUnknown,    // 未知
    CHRouterVCTransitionTypePush,       // push
    CHRouterVCTransitionTypePresent     // present
};

//枚举返回类型
typedef NS_ENUM(NSInteger, CHRouterResultType) {
    CHRouterResultTypeUnknown,             // 未知错误
    CHRouterResultTypeSuccess,             // 处理成功
    CHRouterResultTypeUnsupportedScheme,   // 不支持的scheme
    CHRouterResultTypeURLNotExisted,       // URL不存在
    CHRouterResultTypeURLHandleWait,       // URL待处理中
    CHRouterResultTypeNoLogin,             // 用户未登录
    CHRouterResultTypeOther                // 其他错误
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
@property (nonatomic, copy) NSString *responseActionName;
@property (nonatomic, strong) id responseActionParams;

@end

//路由回调
typedef void(^RouterResponseCallBack)(CHRouterResponse *response);


@interface CHRouterHandleInfo : NSObject

@property (nonatomic, copy) NSDictionary *parameters;
@property (nonatomic, weak) UIViewController *sourceViewController;
@property (nonatomic, weak) UINavigationController *sourveNavigationController;
@property (nonatomic, copy) RouterResponseCallBack responseCallBack;

@end


//路由回调，注册用
typedef CHRouterResponse *(^CHURLHandler)(CHRouterHandleInfo *handleInfo);

@interface CHRouter : NSObject

@property (nonatomic, copy, readonly) NSArray *allURLPatterns;

- (void)registerURL:(NSString *)url withURLHandler:(CHURLHandler)urlHandler;



- (CHRouterResponse *)openURL:(NSString *)url sourceViewController:(UIViewController *)sourceViewController;

- (CHRouterResponse *)openURL:(NSString *)url
             routerParameters:(NSDictionary *)routerParameters
         sourceViewController:(UIViewController *)sourceViewController;

- (CHRouterResponse *)openURL:(NSString *)url
             routerParameters:(NSDictionary *)routerParameters
         sourceViewController:(UIViewController *)sourceViewController
               responseCallBack:(RouterResponseCallBack)responseCallBack;

- (CHRouterResponse *)openWithRequest:(CHRouterRequest *)urlRequest
                     responseCallBack:(RouterResponseCallBack)responseCallBack;


//注册所有模块的路由
+ (instancetype)sharedInstance;
- (void)registerAllModules;


@end






