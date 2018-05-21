//
//  DDAppStartupConfig+MonitorLoginStatus.h
//  DoorDuOEM
//
//  Created by matt on 2018/3/21.
//  Copyright © 2018年 广州人创天地有限公司 All rights reserved.
//

#import "DDAppStartupConfig.h"



/** 用于监听登录状态 */
@interface DDAppStartupConfig (MonitorLoginStatus)

- (void)monitorLoginStatusApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;


@end
