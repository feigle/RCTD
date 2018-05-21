//
//  DDMonitorNetworkStatus.m
//  DoorDu
//
//  Created by 刘和东 on 2017/11/15.
//  Copyright © 2017年 深圳市多度科技有限公司. All rights reserved.
//

#import "DDMonitorNetworkStatus.h"
#import "AFNetworking.h"

/** 网络变更通知 */
#define DDMonitorNetworkStatusNetworkStatusChange @"DDMonitorNetworkStatusNetworkStatusChange"

@interface DDMonitorNetworkStatus ()

/**网络是否可用*/
@property (nonatomic, assign) BOOL isReachable;
/**网络状态*/
@property (nonatomic, assign) DDNetworkReachabilityStatus networkStatus;


@end


@implementation DDMonitorNetworkStatus

+ (instancetype)sharedInstance
{
    static DDMonitorNetworkStatus *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self __setupInit];
    }
    return self;
}

- (void)__setupInit
{
    self.isReachable = YES;
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        //走这里 代表  网络状态  发送了改变
        self.networkStatus = (DDNetworkReachabilityStatus)status;
        self.isReachable = [AFNetworkReachabilityManager sharedManager].isReachable;
        [[NSNotificationCenter defaultCenter] postNotificationName:DDMonitorNetworkStatusNetworkStatusChange object:@(status)];
        if ([AFNetworkReachabilityManager sharedManager].isReachable) {//有网络的情况
            
        }else{//没有网络的时候
            
        }
        switch (status) {
                case AFNetworkReachabilityStatusReachableViaWWAN:
            {//数据流量网络环境
                
            }
                break;
                case AFNetworkReachabilityStatusReachableViaWiFi:
            {//wifi网络环境
                
            }
                break;
                case AFNetworkReachabilityStatusNotReachable:
            {//网络链接失败
                
            }
                break;
                case AFNetworkReachabilityStatusUnknown:
            {//未知网络环境
                
            }
                break;
                
            default:
                break;
        }
        
    }];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

- (void)addObserver:(id)obj selector:(SEL)sel
{
    [[NSNotificationCenter defaultCenter] addObserver:obj selector:sel name:DDMonitorNetworkStatusNetworkStatusChange object:nil];
}

/** 添加观察 */
+ (void)addObserver:(id)obj selector:(SEL)sel
{
    [[self sharedInstance] addObserver:obj selector:sel];
}

/** 获取网络状态 */
+ (DDNetworkReachabilityStatus)getNetworkStatus
{
    return [[self sharedInstance] networkStatus];
}

/** 获取网络是否可用 */
+ (BOOL)isReachable
{
    return [[self sharedInstance] isReachable];
}

/** 开启监听网络 */
+ (void)startMonitorNetwork
{
    [self sharedInstance];
}


@end
