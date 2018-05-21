//
//  DDAppStartupConfig+MonitorLoginStatus.m
//  DoorDuOEM
//
//  Created by matt on 2018/3/21.
//  Copyright © 2018年 广州人创天地有限公司 All rights reserved.
//

#import "DDAppStartupConfig+MonitorLoginStatus.h"
#import "DDBaseNavigationController.h"

@implementation DDAppStartupConfig (MonitorLoginStatus)

- (void)monitorLoginStatusApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //注册登录状态监听
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(__loginStateChange:)
                                                 name:KNOTIFICATION_LOGINCHANGE
                                               object:nil];
    DDCurrentUserDataModel * userModel = currentUserModel;
    if (userModel.loginIdentityType == DDLoginIdentityPhoneSuccesType) {
        [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@(userModel.loginIdentityType)];
    } else {
        //没有登录
        [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@(DDLoginIdentityNoLoginType)];
    }
    
}

/**监听登录的状态改变*/
- (void)__loginStateChange:(NSNotification *)notification
{
    UIWindow * window = [UIApplication sharedApplication].delegate.window;
    DDLoginIdentityType identityType = [notification.object integerValue];
    switch (identityType) {
        case DDLoginIdentityNoLoginType:
        {//没有登录
            [DDCurrentUserDataModel clearMyself];
//            DDLoginRegisterViewController * vc = [[DDLoginRegisterViewController alloc] init];
//            DDBaseNavigationController * nav  = [[DDBaseNavigationController alloc] initWithRootViewController:vc];
//            window.rootViewController = nav;
        }
            break;
        case DDLoginIdentityPhoneSuccesType:
        {//登录成功
            /** Bugly 设置当前用户的 */
//            [Bugly setUserIdentifier:[DDCurrentUserDataModel getMobileNo] ];
//            DDMainTabBarController *tabBarVC = [[DDMainTabBarController alloc] init];
//            window.rootViewController = tabBarVC;
        }
            break;
            
        default:
            break;
    }
    [window makeKeyAndVisible];
}

@end
