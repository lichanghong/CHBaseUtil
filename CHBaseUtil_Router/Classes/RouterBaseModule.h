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


/*
 usage:
 自定义的module都继承自RouterBaseModule，用法如下：
 
 - (NSArray *)routerURLs
 {
 return @[homeURL];
 }
 
 - (CHRouterResponse *)handleURL:(NSString *)url handleInfo:(CHRouterHandleInfo *)handleInfo
 {
 CHRouterResponse *content = [[CHRouterResponse alloc] init];
 UIViewController *targetViewController = nil;
 NSDictionary *parameters = handleInfo.parameters; // 入参
 CHRouterVCTransitionType transitionType = CHRouterVCTransitionTypePush; // 转场类型
 if ([url isEqualToString:homeURL]) {
 SecondViewController *controller = [[SecondViewController alloc] init];
 //回调方法用block，或者delegate
 controller.secondAction = ^{
 [self handleCallbackWithURL:url identifier:@"run" responseParams:nil];
 };
 //可选
 if (handleInfo.delegate) {
 [self handleCallbackWithURL:url identifier:@"run" responseParams:nil];
 }
 
 targetViewController = controller;
 }
 [self transitionViewController:targetViewController WithHandleInfo:handleInfo animated:YES];
 content.returnCode = CHRouterResultTypeSuccess;
 content.returnMessage = @"处理成功";
 return content;
 }
 
 
 
 */
