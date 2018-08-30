//
//  MyModule.m
//  Masonry
//
//  Created by lichanghong on 5/3/18.
//  Copyright © 2018 lichanghong. All rights reserved.
//

#import "MyModule.h"
#import "CHRouter.h"

static NSString *const SYRouterBaikeHomeURLPattern = @"app.soyoung://baike/home";


@implementation MyModule

- (NSArray *)routerURLs
{
    return @[SYRouterBaikeHomeURLPattern];
}

- (CHRouterResponse *)handleURL:(NSString *)url handleInfo:(CHRouterHandleInfo *)handleInfo
{
    CHRouterResponse *response = [[CHRouterResponse alloc] init];
    NSDictionary *parameters = handleInfo.parameters; // 入参
//    id obj = [parameters objectForKey:key];
//    if ([obj isKindOfClass:[NSString class]]) {
//        return @([obj doubleValue]);
//    } else if ([obj isKindOfClass:[NSNumber class]]) {
//        return obj;
//    }
//    SYRouterViewControllerTransitionType transitionType = [parameters transitionType]; // 转场类型
////
//    UIViewController *targetViewController = nil;
//    if ([url isEqualToString:SYRouterBaikeHomeURLPattern]) {
//        targetViewController = [[SYBaikeHomeViewController alloc] init];
//    }
//
//    [self transitionViewController:targetViewController
//                          fromNavi:handleInfo.sourveNavigationController
//                          animated:YES
//                    transitionType:transitionType];
    response.returnMessage = @"处理成功";
    
    //success block responseCallBack
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(10 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self handleCallbackWithURL:url responseActionName:@"editedCalendarInfo" responseActionParams:parameters];
    });
    return response;
}


@end
