//
//  DDAppStartupConfig.m
//  DoorDuOEM
//
//  Created by matt on 2018/3/21.
//  Copyright © 2018年 广州人创天地有限公司 All rights reserved.
//

#import "DDAppStartupConfig.h"
#import "DDAppStartupConfig+MonitorLoginStatus.h"
#import "DDAppStartupConfig+VersionCheck.h"

@implementation DDAppStartupConfig

#pragma mark (创建单例)
static DDAppStartupConfig *theInstance = nil;
+ (instancetype)sharedInstance {
    if (theInstance == nil) {
        static dispatch_once_t oncePredicate;
        dispatch_once(&oncePredicate, ^{
            theInstance = [[DDAppStartupConfig alloc] init];
        });
    }
    return theInstance;
}

/** 启动配置 */
+ (void)Application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    /** 开启网络监听 */
    [DDMonitorNetworkStatus startMonitorNetwork];
    
    /** 监听登录状态 */
    [[self sharedInstance] monitorLoginStatusApplication:application didFinishLaunchingWithOptions:launchOptions];
    
    /** 检测版本更新 */
    [[self sharedInstance] versionCheckApplication:application didFinishLaunchingWithOptions:launchOptions];
    
    /** 第三方配置 */
    [self _thirdLibraryConfig];
    
}

#pragma mark - 第三方配置
+ (void)_thirdLibraryConfig
{
//    [Bugly startWithAppId:@"87af8972e4"];
}

@end
