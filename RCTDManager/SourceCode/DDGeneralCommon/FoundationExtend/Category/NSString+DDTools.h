//
//  NSString+DDTools.h
//  DoorDu
//
//  Created by 刘和东 on 2017/11/15.
//  Copyright © 2017年 深圳市多度科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (DDTools)

/**转成utf8String*/
- (NSString *)utf8EncodingString;

/**过滤表情*/
-(NSString *)filterEmoji;

/**是否含有表情*/
-(BOOL)isContainsEmoji;

/**是否包含空格*/
- (BOOL)isContainsSpace;

/**去除多余的换行*/
- (NSString *)removeContinueLinefeed;
/**去除空格*/
- (NSString *)removeBlank;
/** 去除换行 */
- (NSString *)removeLinefeed;

#pragma mark - 正则表达

/** 判断 是否 全是中文 */
- (BOOL)verifyIsChinese;

/** 判断 是否 全是数字 */
- (BOOL)verifyIsNumber;

/** 判断 是否 全是字母 */
- (BOOL)verifyIsLetter;

/** 判断 是否 是字母或数字 */
- (BOOL)verifyIsLetterOrNumber;

/**
 密码输入格式为6到13位的数字加字母组合。
 
 @return 返回YES，代表 是
 */
- (BOOL)verifyNumbersAndLettersCombinationPasswordSixToThirteen;


/**获取 一串文字的 首字母（中文、英文、中英混合等等）*/
- (NSString *)firstCharacterWithString;

/**
 *  32位MD5加密
 *
 *  @return 32位MD5加密结果
 */
- (NSString *)MD5;

/**
 *  SHA1加密
 *
 *  @return SHA1加密结果
 */
- (NSString *)SHA1;


/**
 *   根据 format 返回 NSDate,把当前时间字符串
 *   yyyy.MM.dd
 *   yyyy-MM-dd
 *   yyyy-MM-dd HH:mm:ss
 */
- (NSDate *)returnDateWithFormat:(NSString *)format;

/**
 根据时间转为为特定格式时间字符串
 
 @param string 需要转换的时间字符串
 @return 特定格式时间字符串
 */
+ (NSString *)format:(NSString *)string;

/**
    返回base64编码字符串
 */
- (nullable NSString *)base64EncodedString;


/**
 @param  base64EncodedString base64编码字符串
 返回解码后的字符串
 */
+ (nullable NSString *)stringWithBase64EncodedString:(NSString *)base64EncodedString;


@end

NS_ASSUME_NONNULL_END
