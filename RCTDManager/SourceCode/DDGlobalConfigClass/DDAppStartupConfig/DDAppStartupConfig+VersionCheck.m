//
//  DDAppStartupConfig+VersionCheck.m
//  DoorDuOEM
//
//  Created by matt on 2018/4/16.
//  Copyright © 2018年 广州人创天地有限公司 All rights reserved.
//

#import "DDAppStartupConfig+VersionCheck.h"
#import "DDVersionUpdateView.h"

@implementation DDAppStartupConfig (VersionCheck)

- (void)versionCheckApplication:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    NSLog(@"%@",DDDoorDuOEMVersion);
    NSMutableDictionary * dict = [NSMutableDictionary dictionary];
    dict[@"device_type"] = @"3";
    dict[@"sdk_app_id"] = KDDoorDu_sdk_app_id;
    
    WeakSelf
    [DDHttpRequest postWithUrlString:DDVersionCheckUrlStr parms:[DDHttpRequest handleParametersSHA1:dict] success:^(NSDictionary *requestDict, NSArray *requestArray, BOOL isFinish) {
        NSDictionary * dataDict = requestDict[@"data"];
        NSString * device_type = [dataDict[@"device_type"] toString];
        if ([device_type integerValue] != 3) {
            return;
        }
        StrongSelf
        [strongSelf _judeVersionUpdate:dataDict];
    } failure:^(DDHttpRequestCode *error) {
        
    }];
}

- (void)_judeVersionUpdate:(NSDictionary *)dict
{
    NSString * version = dict[@"version"];
    /** 版本比较 */
    NSString *currentVersion = [DDDoorDuOEMVersion stringByReplacingOccurrencesOfString:@"." withString:@""];
    NSString *newVersion = [version stringByReplacingOccurrencesOfString:@"." withString:@""];
    if (newVersion.integerValue <= currentVersion.integerValue) {
        return;
    }
    
    UIWindow * window = [UIApplication sharedApplication].delegate.window;
    
    DDVersionUpdateView * view = [[DDVersionUpdateView alloc] init];
    view.version = version;
    view.remark = dict[@"remark"];
    view.download_url = dict[@"download_url"];
    view.level = dict[@"level"];
    [view showFromView:window];

    
}

@end
