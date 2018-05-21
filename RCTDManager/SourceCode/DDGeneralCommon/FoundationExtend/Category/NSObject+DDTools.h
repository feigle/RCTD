//
//  NSObject+DDTools.h
//  DoorDu
//
//  Created by 刘和东 on 2017/11/15.
//  Copyright © 2017年 深圳市多度科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (DDTools)

/**
 *  将NSDictionary或NSArray转化为JSON串
 *
 *   NSDictionary或NSArray
 *
 *  @return json字符串  JSONString
 */
- (NSString *)toJsonString;


/**
 *  为了解析数据的时候有空指针，主要用于字符的调用，例如：
 *  [self.infoDict[@"name"] toString]
 */
- (NSString *)toString;


@end
