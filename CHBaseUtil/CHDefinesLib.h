//
//  CHDefinesLib.h
//  CHDefinesLib
//
//  Created by lichanghong on 5/26/17.
//  Copyright © 2017 lichanghong. All rights reserved.
//

#import <UIKit/UIKit.h>

//! Project version number for CHDefinesLib.
FOUNDATION_EXPORT double CHDefinesLibVersionNumber;

//! Project version string for CHDefinesLib.
FOUNDATION_EXPORT const unsigned char CHDefinesLibVersionString[];

//获取一个字符串转换为URL
#define URL(str) [NSURL URLWithString:[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]]

/**
 申明一个 wself 的指针，指向自身，以用于在block中使用
 */
#define WSELF() __weak typeof(self) wself=self;

//角度转换
#define degreesToRadinas(x) (M_PI * (x)/180.0)

#define APP_OBJ                 [UIApplication sharedApplication]
#define APP_DELEGATE            ((AppDelegate *)[APP_OBJ delegate])
#define AppWindow               (((AppDelegate *)[UIApplication sharedApplication].delegate).window)

#define IosVersion              floorf([[[UIDevice currentDevice] systemVersion] floatValue])


//


/* ****************************************************************************************************************** */


