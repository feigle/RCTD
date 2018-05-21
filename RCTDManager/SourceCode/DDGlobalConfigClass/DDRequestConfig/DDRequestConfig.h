//
//  DDRequestConfig.h
//  DoorDuOEM
//
//  Created by matt on 2018/3/21.
//  Copyright © 2018年 广州人创天地有限公司 All rights reserved.
//

#import <Foundation/Foundation.h>

/** 接口请求环境 */
typedef NS_ENUM(NSUInteger, DDRequestGlobleMode)
{
    DDRequestTestMode          = 0,    /* 测试环境 */
    DDRequestPreDistributeMode = 1,    /* 预发布环境 */
    DDRequestDistributeMode    = 2     /* 发布环境 */
};

/** 配置接口环境 默认 DDRequestDistributeMode(发布环境) */
@interface DDRequestConfig : NSObject

/** 设置开发模式 ，默认 DDRequestDistributeMode(发布环境)*/
+ (void)setDDRequestMode:(DDRequestGlobleMode)mode;

/**  获取接口环境 */
+ (DDRequestGlobleMode)getDDRequestGlobleMode;

/** 获取服务器HOST */
+ (NSString *)getHostHttpUrlString;

@end
