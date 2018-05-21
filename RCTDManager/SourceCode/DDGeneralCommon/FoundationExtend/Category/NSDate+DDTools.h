//
//  NSDate+DDTools.h
//  DoorDu
//
//  Created by 刘和东 on 2017/11/16.
//  Copyright © 2017年 深圳市多度科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (DDTools)

/**返回  number 天后的时间*/
- (NSDate *)returnAfterAFewDayDateWithNumber:(NSInteger)number;

/**返回  number 月后的时间*/
- (NSDate *)returnAfterAFewMonthDateWithNumber:(NSInteger)number;

/**返回  number 年后的时间*/
- (NSDate *)returnAfterAFewYearsDateWithNumber:(NSInteger)number;

/**
 *   根据 dateFormat 返回时间字符串
 *   yyyy.MM.dd
 *   yyyy-MM-dd
 *   yyyy-MM-dd HH:mm:ss
 */
- (NSString *)returnDateStringWithDateFormat:(NSString *)dateFormat;


@end
