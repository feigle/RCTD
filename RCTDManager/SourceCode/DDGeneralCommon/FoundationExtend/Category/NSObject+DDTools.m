//
//  NSObject+DDTools.m
//  DoorDu
//
//  Created by 刘和东 on 2017/11/15.
//  Copyright © 2017年 深圳市多度科技有限公司. All rights reserved.
//

#import "NSObject+DDTools.h"

@implementation NSObject (DDTools)

- (NSString *)toJsonString
{
    if ([NSJSONSerialization isValidJSONObject:self]) {
        NSError * error = nil;
        NSData * jsonData = [NSJSONSerialization dataWithJSONObject:self options:NSJSONWritingPrettyPrinted error:&error];
        if ([jsonData length] > 0 && error == nil) {
            NSString *jsonString = [[NSString alloc] initWithData:jsonData
                                                         encoding:NSUTF8StringEncoding];
            return jsonString;
        } else {
            return nil;
        }
    } else {
        return nil;
    }
}

- (NSString *)toString
{
    //检测对象类型
    //不是NSString类型，转换成NSString
    if ([self isKindOfClass:[NSString class]]) {
        NSString * ss = (NSString *)self;
        if ([ss isEqualToString:@"NULL"]) {
            return @"";
        }
        if ([ss isEqualToString:@"nil"]) {
            return @"";
        }
        return (NSString *)self;
    } else if ([self isKindOfClass:[NSNumber class]]) {
        return [NSString stringWithFormat:@"%@", self];
    } else if ([self isKindOfClass:[NSNull class]]) {
        return @"";
    } else if (self == nil ) {
        return @"";
    } else if (self == NULL ) {
        return @"";
    }else {
        return @"";
    }
}


@end
