//
//  DDMonitorNetworkStatus.h
//  DoorDu
//
//  Created by 刘和东 on 2017/11/15.
//  Copyright © 2017年 深圳市多度科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, DDNetworkReachabilityStatus) {
    DDNetworkReachabilityStatusUnknown          = -1,
    DDNetworkReachabilityStatusNotReachable     = 0,
    DDNetworkReachabilityStatusReachableViaWWAN = 1,
    DDNetworkReachabilityStatusReachableViaWiFi = 2,
};

/** 监听网络状态 */
@interface DDMonitorNetworkStatus : NSObject

/** 添加观察 ，带参数 DDNetworkReachabilityStatus*/
+ (void)addObserver:(id)obj selector:(SEL)sel;

/** 获取网络状态 */
+ (DDNetworkReachabilityStatus)getNetworkStatus;

/** 获取网络是否可用 */
+ (BOOL)isReachable;

/** 开启监听网络 */
+ (void)startMonitorNetwork;

@end

/**
 使用方法
 [DDMonitorNetworkStatus addObserver:self selector:@selector(__monitorNetworkStatusChange:)];
 // 监听网络状态变化
- (void)__monitorNetworkStatusChange:(NSNotification *)notification
{
    DDNetworkReachabilityStatus networkStatus = [notification.object integerValue];
}
 */
