//
//  Created by lichanghong on 13/02/2018.
//  Copyright © 2018 lichanghong. All rights reserved.
//

#import <UIKit/UIKit.h>

//判断字符串是否为空或者为空字符串
#define StringIsNullOrEmpty(str) (str==nil || [(str) isEqual:[NSNull null]] ||[str isEqualToString:@""])

//判断字符串不为空并且不为空字符串
#define StringNotNullAndEmpty(str) (str!=nil && ![(str) isEqual:[NSNull null]] &&![str isEqualToString:@""])
//快速格式化一个字符串
#define Format_Str(str,...) [NSString stringWithFormat:str,##__VA_ARGS__]


/// originalStr如果为空，则替换为defaultStr
FOUNDATION_EXPORT NSString *unEmptyStringByString(NSString *originalStr, NSString *defaultStr);

/// originalStr如果为空，则替换为@""
FOUNDATION_EXPORT NSString *unEmptyStringByDefault(NSString *originalStr);

 
 
@interface NSString (CHSelf)

- (unichar)safeCharacterAtIndex:(NSUInteger)index;

- (NSString *)safeSubstringToIndex:(NSUInteger)index;

- (NSString *)safeSubstringFromIndex:(NSUInteger)index;

- (NSString *)safeSubstringWithRange:(NSRange)range;

- (BOOL)safeContainsString:(NSString *)string;

- (NSComparisonResult)safeLocalizedCompare:(NSString *)string;


@end
