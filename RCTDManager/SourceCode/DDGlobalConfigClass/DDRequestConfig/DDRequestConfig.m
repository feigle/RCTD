//
//  DDRequestConfig.m
//  DoorDuOEM
//
//  Created by matt on 2018/3/21.
//  Copyright © 2018年 广州人创天地有限公司 All rights reserved.
//

#import "DDRequestConfig.h"

@interface DDRequestConfig ()

/** 接口环境 */
@property (nonatomic,assign) DDRequestGlobleMode  requestGlobleMode;

/** 服务器HOST */
@property (nonatomic,strong) NSString * httpUrlString;


@end


@implementation DDRequestConfig

static DDRequestConfig *theInstance = nil;
/** 获取单列对象 */
+ (instancetype)sharedInstance
{
    if (theInstance == nil) {
        static dispatch_once_t oncePredicate;
        dispatch_once(&oncePredicate, ^{
            theInstance = [[DDRequestConfig alloc] init];
        });
    }
    return theInstance;
}

- (id)init
{
    self = [super init];
    if (self) {
        //默认设置发布模式
        [self __setDDRequestMode:DDRequestDistributeMode];
    }
    return self;
}

/**
 设置开发模式
 @param mode 开发模式
 */
+ (void)setDDRequestMode:(DDRequestGlobleMode)mode
{
    [[self sharedInstance] __setDDRequestMode:mode];
}

- (void)__setDDRequestMode:(DDRequestGlobleMode)mode
{
    _requestGlobleMode = mode;
    switch (mode) {
        case DDRequestTestMode:
            [self __textMode];
            break;
        case DDRequestPreDistributeMode:
            [self __preDistributeMode];
            break;
        case DDRequestDistributeMode:
            [self __distributeMode];
            break;
        default:
            [self __distributeMode];
            break;
    }
}

/*测试环境*/
- (void)__textMode
{
    _httpUrlString = @"https://10.0.0.243:8017";
}

/*预发布环境*/
- (void)__preDistributeMode
{
    _httpUrlString = @"https://ssl.beta.doordu.com:8017";
}

/*发布环境*/
- (void)__distributeMode
{
    _httpUrlString = @"https://sdk.oem.doordu.com:8017";
}

/**  获取接口环境 */
+ (DDRequestGlobleMode)getDDRequestGlobleMode
{
    return [[self sharedInstance] requestGlobleMode];
}

/** 获取服务器HOST */
+ (NSString *)getHostHttpUrlString
{
    return [[self sharedInstance] httpUrlString];
}


@end
