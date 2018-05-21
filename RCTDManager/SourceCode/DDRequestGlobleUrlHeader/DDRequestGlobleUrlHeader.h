//
//  DDRequestGlobleUrlHeader.h
//  DoorDuOEM
//
//  Created by matt on 2018/3/21.
//  Copyright © 2018年 广州人创天地有限公司 All rights reserved.
//

#ifndef DDRequestGlobleUrlHeader_h
#define DDRequestGlobleUrlHeader_h
#import "DDRequestConfig.h"


/** HOST 地址*/
#define DDRequestGlobleBaseUrlString  [DDRequestConfig getHostHttpUrlString]


/** 登录 */
#define DDOemUsersLoginUrlStr [NSString stringWithFormat:@"%@%@",DDRequestGlobleBaseUrlString,@"/oem/v2/user/login"]

/** 注册 */
#define DDOemUsersRegisterUrlStr [NSString stringWithFormat:@"%@%@",DDRequestGlobleBaseUrlString,@"/oem/v2/user/register"]

/** 忘记密码 */
#define DDOemUsersForget_passwordUrlStr [NSString stringWithFormat:@"%@%@",DDRequestGlobleBaseUrlString,@"/oem/v2/user/forget_password"]

/** 重置密码 */
#define DDOemUsersReset_passwordUrlStr [NSString stringWithFormat:@"%@%@",DDRequestGlobleBaseUrlString,@"/oem/v2/user/reset_password"]

/** 修改密码 */
#define DDOemUsersChange_passwordUrlStr [NSString stringWithFormat:@"%@%@",DDRequestGlobleBaseUrlString,@"/oem/v2/user/change_password"]

/** 城市天气查询接口 */
#define DDOemWeatherCityUrlStr [NSString stringWithFormat:@"%@%@",DDRequestGlobleBaseUrlString,@"/oem/v1/weather/city"]

/** 获取短信验证码 */
#define DDOemCaptchaSmsUrlStr [NSString stringWithFormat:@"%@%@",DDRequestGlobleBaseUrlString,@"/oem/v1/captcha/sms"]

/** 获取图形验证码接口 */
#define DDOemCaptchaGraphUrlStr [NSString stringWithFormat:@"%@%@",DDRequestGlobleBaseUrlString,@"/oem/v1/captcha/graph"]

/** 版本升级接口 */
#define DDVersionCheckUrlStr [NSString stringWithFormat:@"%@%@",DDRequestGlobleBaseUrlString,@"/oem/v1/version/check"]

/** 验证短信验证码接口 */
#define DDCaptchaSms_verifyUrlStr [NSString stringWithFormat:@"%@%@",DDRequestGlobleBaseUrlString,@"/oem/v1/captcha/sms_verify"]


#endif /* DDRequestGlobleUrlHeader_h */
