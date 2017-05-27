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

// In this header, you should import all the public headers of your framework using statements like #import <CHDefinesLib/PublicHeader.h>

#import "UIColor+Hex.h"

#define CONVERT_TIME(DATE) [MSDateUtils timeStrTotimeStamp:[[NSNumber alloc] initWithInt:[DATE timeIntervalSince1970]]]

#define RGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define RandomColor(r,g,b)  [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];

//获取一个字符串转换为URL
#define URL(str) [NSURL URLWithString:[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]]
//取得指定名称的图片
#define IMG(name) [UIImage imageNamed:name]
#define FONT(size)         ([UIFont systemFontOfSize:size])

//判断字符串是否为空或者为空字符串
#define StringIsNullOrEmpty(str) (str==nil || [(str) isEqual:[NSNull null]] ||[str isEqualToString:@""])

//判断字符串不为空并且不为空字符串
#define StringNotNullAndEmpty(str) (str!=nil && ![(str) isEqual:[NSNull null]] &&![str isEqualToString:@""])
//快速格式化一个字符串
#define Format_Str(str,...) [NSString stringWithFormat:str,##__VA_ARGS__]
/**
 申明一个 wself 的指针，指向自身，以用于在block中使用
 */
#define WSELF() __weak typeof(self) wself=self;

#define IS_PORTRAIT         UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation)
#define STATUS_BAR_HEIGHT   (IS_PORTRAIT ? [UIApplication sharedApplication].statusBarFrame.size.height : [UIApplication sharedApplication].statusBarFrame.size.width)

//角度转换
#define degreesToRadinas(x) (M_PI * (x)/180.0)


#define APP_OBJ                 [UIApplication sharedApplication]
#define APP_DELEGATE            ((AppDelegate *)[APP_OBJ delegate])
#define AppWindow               (((AppDelegate *)[UIApplication sharedApplication].delegate).window)

#define _IMAGE(n)               [UIImage imageNamed:(n)]
#define _IMAGE_(i)              [UIImage imageNamed:@#i]
#define _FONT(n)                [UIFont systemFontOfSize:(n)]
#define _FONT_B(n)              [UIFont boldSystemFontOfSize:(n)]

#define _LS(n)                  NSLocalizedStringFromTable(n, @"living", nil)
#define _LS_(n)                 _LS(@#n)

#define _COLOR_HEX(c)           [UIColor colorForHex:@#c]
#define _COLOR(c)               [UIColor c ## Color]
#define _COLOR_RGBA(r,g,b,a)    [UIColor colorWithRed:r green:g blue:b alpha:a]
#define _COLOR_WHITEA(w,a)      [UIColor colorWithWhite:w alpha:a]
#define _STRING(a)              @#a

#define KScreenWidth            [[UIScreen mainScreen] bounds].size.width
#define KScreenHeight           [[UIScreen mainScreen] bounds].size.height
#define KScreenRect             [[UIScreen mainScreen] bounds]
#define KStatusHeight           (IosVersion>=7.0?20.0:0.0)
#define IosVersion              floorf([[[UIDevice currentDevice] systemVersion] floatValue])


#define Is414x736hScreen()       (ABS((double)[[UIScreen mainScreen] bounds].size.height - 736.f) < DBL_EPSILON)  //iphone6+
#define Is375x667hScreen()       (ABS((double)[[UIScreen mainScreen] bounds].size.height - 667.f) < DBL_EPSILON)
#define Is320x568hScreen()       (ABS((double)[[UIScreen mainScreen] bounds].size.height - 568.f) < DBL_EPSILON)  //iphone5s
#define Is320x480hScreen()       (ABS((double)[[UIScreen mainScreen] bounds].size.height - 480.f) < DBL_EPSILON)  //iphone4
//
/* ****************************************************************************************************************** */
#define ViewX(v)                    (v).frame.origin.x
#define ViewY(v)                    (v).frame.origin.y
#define ViewW(v)                    (v).frame.size.width
#define ViewH(v)                    (v).frame.size.height

#define MinX(v)                 CGRectGetMinX((v).frame)
#define MinY(v)                 CGRectGetMinY((v).frame)

#define MidX(v)                 CGRectGetMidX((v).frame)
#define MidY(v)                 CGRectGetMidY((v).frame)

#define MaxX(v)                 CGRectGetMaxX((v).frame)
#define MaxY(v)                 CGRectGetMaxY((v).frame)


#define setX(v,x)          CGRectMake(x, Y(v), WIDTH(v), HEIGHT(v))
#define setY(v,y)          CGRectMake(X(v), y, WIDTH(v), HEIGHT(v))
#define setXY(v,x,y)    CGRectMake(x, y, WIDTH(v), HEIGHT(v))
#define setW(v,w)      CGRectMake(X(v), Y(v), w, HEIGHT(v))
#define setH(v,h)     CGRectMake(X(v), Y(v), WIDTH(v), h)
#define setWH(v,w,h)     CGRectMake(X(v), Y(v), w, h)


/* ****************************************************************************************************************** */

#define RedColor [UIColor redColor]
#define ClearColor [UIColor clearColor]
#define VersionColor [UIColor darkGrayColor]

