//
//  CHBaseUtil_Router.h
//  CHBaseUtil_Proj
//
//  Created by lichanghong on 9/9/18.
//  Copyright © 2018 lichanghong. All rights reserved.
//

#ifndef CHBaseUtil_Router_h
#define CHBaseUtil_Router_h
#import "CHRouter.h"
#import "NSDictionary+CHRouter.h"
#import "NSObject+CHRouter.h"
#import "RouterBaseModule.h"
#import "CHRouterResponseProtocol.h"

#endif /* CHBaseUtil_Router_h */

// 所有模块都继承自CHBaseModule，内建URL跳转地址，如果是h5等地址，需要自主创建一个类监听通知CHRouterResultUndefinedURLHTTP，收到的参数是 CHRouterHandleInfo
//
//- (IBAction)handleAction:(id)sender {
//    //    [[CHRouter sharedInstance]openURL:@"app.xxx://xx/home" sourceViewController:nil];
//    [[CHRouter sharedInstance]openURL:@"app.xxx://xx/home" routerParameters:nil sourceViewController:nil responseCallBack:^(CHRouterResponse *response) {
//        NSLog(@"%@",response);
//    }];
//}
//#import "RouterBaseModule.h"
////使用实例
//@interface MyModule : RouterBaseModule
//
//@end


//-------------------------------------------------------------
//#import "MyModule.h"
//#import "CHRouter.h"
//
//static NSString *const SYRouterBaikeHomeURLPattern = @"app.xxx://baike/home";
//
//
//@implementation MyModule
//
//- (NSArray *)routerURLs
//{
//    return @[SYRouterBaikeHomeURLPattern];
//}
//
//- (CHRouterResponse *)handleURL:(NSString *)url handleInfo:(CHRouterHandleInfo *)handleInfo
//{
//    CHRouterResponse *response = [[CHRouterResponse alloc] init];
//    NSDictionary *parameters = handleInfo.parameters; // 入参
//        id obj = [parameters objectForKey:key];
//        if ([obj isKindOfClass:[NSString class]]) {
//            return @([obj doubleValue]);
//        } else if ([obj isKindOfClass:[NSNumber class]]) {
//            return obj;
//        }
//        SYRouterViewControllerTransitionType transitionType = [parameters transitionType]; // 转场类型
//    //
//        UIViewController *targetViewController = nil;
//        if ([url isEqualToString:SYRouterBaikeHomeURLPattern]) {
//            targetViewController = [[SYBaikeHomeViewController alloc] init];
//        }
//
//        [self transitionViewController:targetViewController
//                              fromNavi:handleInfo.sourveNavigationController
//                              animated:YES
//                        transitionType:transitionType];
//    response.returnMessage = @"处理成功";
//
//    //success block responseCallBack
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self handleCallbackWithURL:url responseActionName:@"editedCalendarInfo" responseActionParams:parameters];
//    });
//    return response;
//}

