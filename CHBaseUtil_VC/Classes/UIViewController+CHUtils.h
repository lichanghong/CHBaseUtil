//
//  UIViewController+CHUtils.h
//
//  Created by lichanghong on 2017/4/19.
//  Copyright © 2017年 lichanghong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (CHUtils)

/**
 * AppDelegate.window
 */
+ (UIViewController *)currentViewController;
/**
 * AppDelegate.window
 */
+ (UINavigationController *)currentNavigationController;

/**
 [UIApplication sharedApplication].keyWindow
 */
+(UIViewController *)currentKeyWindowViewController;

@end
