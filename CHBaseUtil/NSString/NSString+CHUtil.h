//  CHBaseUtil
//
//  Created by lichanghong on 13/02/2018.
//  Copyright © 2018 lichanghong. All rights reserved.

#import <Foundation/Foundation.h>


@interface NSString (CHUtil)

- (id)jsonValue;

/// json 转换的dic
- (NSDictionary *)dictionary;

/// 去除首尾空格或换行符
- (NSString *)trimingWhitespaceOrNewlineCharacter;

/// 去除所有的空格
- (NSString *)trimingAllWhitespaces;

/// 判断是否为整形：
- (BOOL)isInt;

/// 判断是否为浮点形：@“”、nil的情况都返回NO
- (BOOL)isFloat;

/// 返回格式化后的手机号 (若不是11位 直接返回)
- (NSString *)phoneNumberWithWhiteSpace;

- (NSString *)phoneNumberWithLine;

/// 返回格式化的身份证号码
- (NSString *)formatIdentification;

/// 返回格式化的银行卡
- (NSString *)formatBankCardNumber;

// 检查银行卡号是否合法
- (BOOL)checkBankCardNumber;

/// 身份证号
- (BOOL)isValidateIdentityCard;

/// 是否是全数字
- (BOOL)isNumbers;

/// 判断是否为有效的url
- (BOOL)validateUrl;

@end
