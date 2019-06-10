//
//  UIViewController+CHUtils.m
//  CHUtils
//
//  Created by lichanghong on 2017/4/19.
//  Copyright © 2017年 lichanghong. All rights reserved.
//

#import "UIViewController+CHUtils.h"

@implementation UIViewController (CHUtils)

+ (UIViewController *)currentViewController
{
    UIViewController *rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    return [self findTopmostViewController:rootViewController];
}

+ (UINavigationController *)currentNavigationController
{
    return [self currentViewController].navigationController;
}

+(UIViewController *)currentKeyWindowViewController
{
    UIViewController* viewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    return [UIViewController findTopmostViewController:viewController];
}

+ (UIViewController *)findTopmostViewController:(UIViewController *)rootViewController
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


@end
