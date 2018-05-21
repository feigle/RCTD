//
//  DDCommonMacroHeader.h
//  DoorDuOEM
//
//  Created by matt on 2018/3/21.
//  Copyright © 2018年 广州人创天地有限公司 All rights reserved.
//

#ifndef DDCommonMacroHeader_h
#define DDCommonMacroHeader_h

/** 登录状态 改变 通知 */
#define KNOTIFICATION_LOGINCHANGE @"loginStatusChangeNotify"

/** 版本号 */
#define DDDoorDuOEMVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

#define KDDoorDuSDK_APP_ID @"9zh4z527sreoxzajrt8cz34uexcfuxmm"
#define KDDoorDuSDK_secret_key @"tzw9hv4gzss0mhbmsl82auijw3clev7t"

//sdk_app_id，支持25：多度智能 13：一家亲 17：爱伴家 19：掌门通 20：宝城通 24：三丰管家
#define KDDoorDu_sdk_app_id @"25"


/** 数据请求签名秘钥 */
#define DDHttpRequestSecretKey @"HBAi797SFV4G2KzhrqbGz9qhr8vPXBTQ"


/** 弱引用、强引用 */
#define WeakSelf typeof(self) __weak weakSelf = self;
#define StrongSelf typeof(weakSelf) __strong strongSelf = weakSelf;

/**TabBar的高度*/
#define kTabBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height>20?83:49)

/** StatusBar 高度 */
#define kStatusBarHeight ([[UIApplication sharedApplication] statusBarFrame].size.height)

/**NavigationBar的高度*/
#define kNavigationBarHeight ([UINavigationBar appearance].frame.size.height==0?44:[UINavigationBar appearance].frame.size.height)

/**导航的高度（包含上面20高度）*/
#define kNavigationHeight (kStatusBarHeight + kNavigationBarHeight)


/**
 *  屏幕大小
 */
#define kScreenBounds [[UIScreen mainScreen] bounds]
#define kScreenWidth kScreenBounds.size.width
#define kScreenHeight kScreenBounds.size.height
#define kScreenScale [[UIScreen mainScreen] scale]


#define kIOSVersion [[[UIDevice currentDevice] systemVersion] floatValue]
#define kAboveIOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define kAboveIOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define kAboveIOS9 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)
#define kAboveIOS10 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0)
#define kAboveIOS11 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0)

#endif /* DDCommonMacroHeader_h */
