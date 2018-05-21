//
//  DDAppStartupConfig+VersionCheck.h
//  DoorDuOEM
//
//  Created by matt on 2018/4/16.
//  Copyright © 2018年 广州人创天地有限公司 All rights reserved.
//

#import "DDAppStartupConfig.h"

/** 检测版本更新 */
@interface DDAppStartupConfig (VersionCheck)

- (void)versionCheckApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;


@end
