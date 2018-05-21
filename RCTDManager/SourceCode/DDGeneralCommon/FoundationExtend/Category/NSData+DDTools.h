//
//  NSData+DDTools.h
//  DoorDu
//
//  Created by 刘和东 on 2017/11/15.
//  Copyright © 2017年 深圳市多度科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (DDTools)

/** 返回 base64 编码字符串. */
- (nullable NSString *)base64EncodedString;

/** base64字符串 返回NSData */
+ (nullable NSData *)dataWithBase64EncodedString:(NSString *)base64EncodedString;



@end

NS_ASSUME_NONNULL_END
