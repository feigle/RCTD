//
//  DDAppStartupConfig.h
//  DoorDuOEM
//
//  Created by matt on 2018/3/21.
//  Copyright © 2018年 广州人创天地有限公司 All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/** 程序启动时的配置 ，对于大功能需要增加类别*/
@interface DDAppStartupConfig : NSObject

/** 启动配置 */
+ (void)Application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;

@end
