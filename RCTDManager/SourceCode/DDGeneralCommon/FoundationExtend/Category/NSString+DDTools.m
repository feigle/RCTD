//
//  NSString+DDTools.m
//  DoorDu
//
//  Created by 刘和东 on 2017/11/15.
//  Copyright © 2017年 深圳市多度科技有限公司. All rights reserved.
//

#import "NSString+DDTools.h"
#import <CommonCrypto/CommonDigest.h>
#import "NSData+DDTools.h"

@implementation NSString (DDTools)

/**转成utf8String*/
- (NSString *)utf8EncodingString
{
    if (!self.length) {
        return nil;
    }
    NSString * encodedString = [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    return encodedString;
}

/**过滤表情*/
-(NSString *)filterEmoji
{
    NSUInteger len = [self lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    const char *utf8 = [self UTF8String];
    char *newUTF8 = malloc( sizeof(char) * len );
    int j = 0;
    
    //0xF0(4) 0xE2(3) 0xE3(3) 0xC2(2) 0x30---0x39(4)
    for ( int i = 0; i < len; i++ ) {
        unsigned int c = (unsigned int )utf8;
        BOOL isControlChar = NO;
        if ( c == 4294967280 ||
            c == 4294967089 ||
            c == 4294967090 ||
            c == 4294967091 ||
            c == 4294967092 ||
            c == 4294967093 ||
            c == 4294967094 ||
            c == 4294967095 ||
            c == 4294967096 ||
            c == 4294967097 ||
            c == 4294967088 ) {
            i = i + 3;
            isControlChar = YES;
        }
        if ( c == 4294967266 || c == 4294967267 ) {
            i = i + 2;
            isControlChar = YES;
        }
        if ( c == 4294967234 ) {
            i = i + 1;
            isControlChar = YES;
        }
        if ( !isControlChar ) {
            newUTF8[j] = (unsigned int )utf8;
            j++;
        }
    }
    newUTF8[j] = '\0';
    NSString *encrypted = [NSString stringWithCString:(const char*)newUTF8
                                             encoding:NSUTF8StringEncoding];
    free( newUTF8 );
    return encrypted;
}

/**是否含有表情*/
-(BOOL)isContainsEmoji
{
    __block BOOL returnValue = NO;
    [self enumerateSubstringsInRange:NSMakeRange(0, [self length])
                             options:NSStringEnumerationByComposedCharacterSequences
                          usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                              const unichar hs = [substring characterAtIndex:0];
                              if (0xd800 <= hs && hs <= 0xdbff) {
                                  if (substring.length > 1) {
                                      const unichar ls = [substring characterAtIndex:1];
                                      const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                      if (0x1d000 <= uc && uc <= 0x1f77f) {
                                          returnValue = YES;
                                      }
                                  }
                              } else if (substring.length > 1) {
                                  const unichar ls = [substring characterAtIndex:1];
                                  if (ls == 0x20e3) {
                                      returnValue = YES;
                                  }
                              } else {
                                  if (0x2100 <= hs && hs <= 0x27ff) {
                                      returnValue = YES;
                                  } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                      returnValue = YES;
                                  } else if (0x2934 <= hs && hs <= 0x2935) {
                                      returnValue = YES;
                                  } else if (0x3297 <= hs && hs <= 0x3299) {
                                      returnValue = YES;
                                  } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                      returnValue = YES;
                                  }
                              }
                          }];
    
    return returnValue;
}

/**是否包含空格*/
- (BOOL)isContainsSpace
{
    NSString * str = [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (str.length != self.length) {
        return YES;
    }
    return NO;
}

/**去除多余的换行*/
- (NSString *)removeContinueLinefeed
{
    NSString *content = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSArray * contArray = [content componentsSeparatedByString:@"\n"];
    if (contArray.count == 0) {
        return content;
    }
    NSMutableArray * contMuArray = [NSMutableArray arrayWithArray:contArray];
    [contMuArray removeObject:@""];
    [contMuArray removeObject:@" "];
    if (contMuArray.count == 0) {
        return @"";
    }
    NSMutableArray * resultContMuArray = [NSMutableArray array];
    for (NSString * sss in contMuArray) {
        NSString * s = [sss stringByReplacingOccurrencesOfString:@" " withString:@""];
        if (s.length > 0) {
            [resultContMuArray addObject:[sss stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
        }
    }
    NSString * newStr = [resultContMuArray componentsJoinedByString:@"\n\n"];
    return newStr;
}
/**去除空格*/
- (NSString *)removeBlank
{
    NSString *content = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return content;
}

/** 去除换行 */
- (NSString *)removeLinefeed
{
    NSString * content = [self stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    content = [content stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return content;
}

#pragma mark - 正则表达

/** 判断 是否 是中文 */
- (BOOL)verifyIsChinese
{
    if (self.length == 0) return NO;
    NSString *regex = @"[\u4e00-\u9fa5]+";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pred evaluateWithObject:self];
}

/** 判断 是否 全是数字 */
- (BOOL)verifyIsNumber
{
    if (self.length == 0) return NO;
    NSString *regex =@"[0-9]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pred evaluateWithObject:self];
}

/** 判断 是否 全是字母 */
- (BOOL)verifyIsLetter
{
    if (self.length == 0) return NO;
    NSString *regex =@"[a-zA-Z]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pred evaluateWithObject:self];
}

/** 判断 是否 是字母或数字 */
- (BOOL)verifyIsLetterOrNumber
{
    if (self.length == 0) return NO;
    NSString *regex =@"[a-zA-Z0-9]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [pred evaluateWithObject:self];
}

/**
 密码输入格式为6到13位的数字加字母组合。
 
 @return 返回YES，代表 是
 */
- (BOOL)verifyNumbersAndLettersCombinationPasswordSixToThirteen
{
    //    ^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,13}$
    /**
     ^ 匹配一行的开头位置
     (?![0-9]+$) 预测该位置后面不全是数字
     (?![a-zA-Z]+$) 预测该位置后面不全是字母
     [0-9A-Za-z] {8,16} 由8-16位数字或这字母组成
     $ 匹配行结尾位置
     */
    NSString * strNum = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,13}$";
    NSPredicate *checktest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", strNum];
    return [checktest evaluateWithObject:self];
}


/**获取 一串文字的 首字母（中文、英文、中英混合等等）*/
- (NSString *)firstCharacterWithString
{
    if (self.length == 0)
    {
        return @"#";
    }
    NSMutableString *mutableString = [NSMutableString stringWithString:self];
    
    CFStringTransform((CFMutableStringRef)mutableString, NULL, kCFStringTransformToLatin, false);
    
    NSMutableString *pinyinString = [[mutableString stringByFoldingWithOptions:NSDiacriticInsensitiveSearch locale:[NSLocale currentLocale]] mutableCopy];
    NSString *str = [self substringToIndex:1];
    
    // 多音字处理http://blog.csdn.net/qq_29307685/article/details/51532147
    if ([str compare:@"长"] == NSOrderedSame)
    {
        [pinyinString replaceCharactersInRange:NSMakeRange(0, 5) withString:@"chang"];
    }
    if ([str compare:@"沈"] == NSOrderedSame)
    {
        [pinyinString replaceCharactersInRange:NSMakeRange(0, 4) withString:@"shen"];
    }
    if ([str compare:@"厦"] == NSOrderedSame)
    {
        [pinyinString replaceCharactersInRange:NSMakeRange(0, 3) withString:@"xia"];
    }
    if ([str compare:@"地"] == NSOrderedSame)
    {
        [pinyinString replaceCharactersInRange:NSMakeRange(0, 2) withString:@"di"];
    }
    if ([str compare:@"重"] == NSOrderedSame)
    {
        [pinyinString replaceCharactersInRange:NSMakeRange(0, 5) withString:@"chong"];
    }
    
    NSString *upperStr = [[pinyinString substringToIndex:1] uppercaseString];
    
    NSString *regex = @"^[A-Z]$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    NSString *firstCharacter = [predicate evaluateWithObject:upperStr] ? upperStr : @"#";
    
    return firstCharacter;
}

/**
 *  32位MD5加密
 *
 *  @return 32位MD5加密结果
 */
- (NSString *)MD5
{
    const char *cStr = [self UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), digest);
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02x", digest[i]];
    }
    return result;
}

/**
 *  SHA1加密
 *
 *  @return SHA1加密结果
 */
- (NSString *)SHA1
{
    const char *cStr = [self UTF8String];
    NSData *data = [NSData dataWithBytes:cStr length:self.length];
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, (CC_LONG)data.length, digest);
    NSMutableString *result = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [result appendFormat:@"%02x", digest[i]];
    }
    return result;
}


/**
 *   根据 format 返回 NSDate,把当前时间字符串
 *   yyyy.MM.dd
 *   yyyy-MM-dd
 *   yyyy-MM-dd HH:mm:ss
 */
- (NSDate *)returnDateWithFormat:(NSString *)format
{
    NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
    formatter.dateFormat = format;
    [formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    NSDate * date = [formatter dateFromString:self];
    return date;
}

/**
 根据时间转为为特定格式时间字符串
 
 @param string 需要转换的时间字符串
 @return 特定格式时间字符串
 */
+ (NSString *)format:(NSString *)string
{
    NSArray *dateComponents = [string componentsSeparatedByString:@" "];
    if (dateComponents.count == 1) {
        string = [NSString stringWithFormat:@"%@ 00:00:00", string];
    }
    
    NSDateFormatter *inputFormatter= [[NSDateFormatter alloc] init];
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"] ];
    [inputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate*inputDate = [inputFormatter dateFromString:string];
    //NSLog(@"startDate= %@", inputDate);
    
    NSDateFormatter *outputFormatter= [[NSDateFormatter alloc] init];
    [outputFormatter setLocale:[NSLocale currentLocale]];
    [outputFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    //get date str
    NSString *str= [outputFormatter stringFromDate:inputDate];
    //str to nsdate
    NSDate *strDate = [outputFormatter dateFromString:str];
    //修正8小时的差时
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: strDate];
    NSDate *endDate = [strDate  dateByAddingTimeInterval: interval];
    //NSLog(@"endDate:%@",endDate);
    NSString *lastTime = [NSString compareDate:endDate];
    NSLog(@"lastTime = %@",lastTime);
    return lastTime;
}

+(NSString *)compareDate:(NSDate *)date{
    NSTimeInterval secondsPerDay = 24 * 60 * 60;
    //修正8小时之差
    NSDate *date1 = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date1];
    NSDate *localeDate = [date1  dateByAddingTimeInterval: interval];
    //NSLog(@"nowdate=%@\nolddate = %@",localeDate,date);
    NSDate *today = localeDate;
    NSDate *yesterday,*beforeOfYesterday;
    //今年
    NSString *toYears;
    toYears = [[today description] substringToIndex:4];
    yesterday = [today dateByAddingTimeInterval: -secondsPerDay];
    beforeOfYesterday = [yesterday dateByAddingTimeInterval: -secondsPerDay];
    // 10 first characters of description is the calendar date:
    NSString *todayString = [[today description] substringToIndex:10];
    NSString *yesterdayString = [[yesterday description] substringToIndex:10];
    NSString *beforeOfYesterdayString = [[beforeOfYesterday description] substringToIndex:10];
    NSString *dateString = [[date description] substringToIndex:10];
    NSString *dateYears = [[date description] substringToIndex:4];
    NSString *dateContent;
    if ([dateYears isEqualToString:toYears]) {//同一年
        //今 昨 前天的时间
        NSString *time = [[date description] substringWithRange:(NSRange){11,5}];
        //其他时间
        NSString *time2 = [[date description] substringWithRange:(NSRange){5,11}];
        if ([dateString isEqualToString:todayString]){
            dateContent = [NSString stringWithFormat:@"今天 %@",time];
            return dateContent;
        } else if ([dateString isEqualToString:yesterdayString]){
            dateContent = [NSString stringWithFormat:@"昨天 %@",time];
            return dateContent;
        }else if ([dateString isEqualToString:beforeOfYesterdayString]){
            dateContent = [NSString stringWithFormat:@"前天 %@",time];
            return dateContent;
        }else{
            return time2;
        }
    }else{
        return dateString;
    }
}


/**
 返回base64编码字符串
 */
- (nullable NSString *)base64EncodedString
{
    return [[self dataUsingEncoding:NSUTF8StringEncoding] base64EncodedString];
}


/**
 @param  base64EncodedString base64编码字符串
 返回解码后的字符串
 */
+ (nullable NSString *)stringWithBase64EncodedString:(NSString *)base64EncodedString
{
    NSData *data = [NSData dataWithBase64EncodedString:base64EncodedString];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}



@end
