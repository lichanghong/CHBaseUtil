//  CHBaseUtil
//
//  Created by lichanghong on 13/02/2018.
//  Copyright © 2018 lichanghong. All rights reserved.

#import "NSString+CHUtil.h"
//#import "NSString+CHSafe.h"

@implementation NSString (CHUtil)

- (id)jsonValue
{
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    
    if ([data length] > 0) {
        NSError *serializationError = nil;
        id jsonValue = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&serializationError];
        return serializationError ? nil : jsonValue;
    } else {
        return nil;
    }
}

- (NSDictionary *)dictionary
{
    id jsonValue = [self jsonValue];
    if ([jsonValue isKindOfClass:[NSDictionary class]]) {
        return jsonValue;
    } else {
        return nil;
    }
}

- (NSString *)trimingWhitespaceOrNewlineCharacter
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (NSString *)trimingAllWhitespaces
{
    return [self stringByReplacingOccurrencesOfString:@" " withString:@""];
}

- (BOOL)isInt
{
    NSScanner *scan = [NSScanner scannerWithString:self];
    scan.charactersToBeSkipped = nil;
    int val;
    return ([scan scanInt:&val] && [scan isAtEnd]);
}

- (BOOL)isFloat
{
    NSScanner *scan = [NSScanner scannerWithString:self];
    scan.charactersToBeSkipped = nil;
    float val;
    return ([scan scanFloat:&val] && [scan isAtEnd]);
}

- (NSString *)phoneNumberWithWhiteSpace
{
    if (self.length != 11) {
        return self;
    }
    
    NSMutableString *format = [NSMutableString string];
    [format appendString:[self substringWithRange:NSMakeRange(0, 3)]];
    [format appendString:@" "];
    [format appendString:[self substringWithRange:NSMakeRange(3, 4)]];
    [format appendString:@" "];
    [format appendString:[self substringWithRange:NSMakeRange(7, 4)]];
    return [NSString stringWithString:format];
}

- (NSString *)phoneNumberWithLine
{
    if (self.length < 6) {
        return self;
    }
    
    NSMutableString *format = [NSMutableString string];
    [format appendString:[self substringWithRange:NSMakeRange(0, 3)]];
    [format appendString:@"-"];
    [format appendString:[self substringWithRange:NSMakeRange(3, 3)]];
    [format appendString:@"-"];
    [format appendString:[self substringWithRange:NSMakeRange(6, self.length - 6)]];
    return [NSString stringWithString:format];
}

- (NSString *)formatIdentification
{
    NSMutableString *format = [NSMutableString string];
    for (NSUInteger i = 0; i < self.length; i++) {
        [format appendString:[self substringWithRange:NSMakeRange(i, 1)]];
        if (i == 2 || i == 5 || i == 9 || i == 13) {
            [format appendString:@" "];
        }
    }
    return [NSString stringWithString:format];
}

- (NSString *)formatBankCardNumber
{
    NSMutableString *format = [NSMutableString string];
    for (NSUInteger i = 0; i < self.length; i += 4) {
        if ((i + 4) < self.length) {
            [format appendString:[self substringWithRange:NSMakeRange(i, 4)]];
            [format appendString:@" "];
        } else {
            [format appendString:[self substringWithRange:NSMakeRange(i, self.length - i)]];
        }
    }
    return [NSString stringWithString:format];
}

// 检查银行卡号是否合法
- (BOOL)checkBankCardNumber
{
    int oddSum = 0;     // 奇数和
    int evenSum = 0;    // 偶数和
    int allSum = 0;     // 总和
    
    // 循环加和
    for (NSInteger i = 1; i <= self.length; i++)
    {
        NSString *theNumber = [self substringWithRange:NSMakeRange(self.length-i, 1)];
        int lastNumber = [theNumber intValue];
        if (i%2 == 0)
        {
            // 偶数位
            lastNumber *= 2;
            if (lastNumber > 9)
            {
                lastNumber -=9;
            }
            evenSum += lastNumber;
        }
        else
        {
            // 奇数位
            oddSum += lastNumber;
        }
    }
    allSum = oddSum + evenSum;
    // 是否合法
    if (allSum%10 == 0)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

//身份证号
- (BOOL)isValidateIdentityCard
{
    BOOL flag = NO;
    if (self.length <= 0) {
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:self];
}

 

- (BOOL)isNumbers
{
    for (NSUInteger i = 0; i < self.length; i++) {
        if (!isnumber([self msafeCharacterAtIndex:i])) {
            return NO;
        }
    }
    return YES;
}

- (unichar)msafeCharacterAtIndex:(NSUInteger)index
{
    if (index >= self.length) {
        return '\0';
    }
    return [self characterAtIndex:index];
}

- (BOOL)validateUrl
{
    NSString *urlRegEx = @"(http|https)://((\\w)*|[0-9]*|[-|_])+((\\.|/)(((\\w)*|[0-9]*)|[-|_])+)+";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegEx];
    return [urlTest evaluateWithObject:self];
}

 

@end
