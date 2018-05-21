//
//  DDCurrentUserDataModel.h
//  DoorDuOEM
//
//  Created by matt on 2018/4/10.
//  Copyright © 2018年 广州人创天地有限公司 All rights reserved.
//

#import <Foundation/Foundation.h>

/** 登录类型 */
typedef NS_ENUM(NSInteger,DDLoginIdentityType) {
    DDLoginIdentityNoLoginType = 0,//没有登录
    DDLoginIdentityPhoneSuccesType = 1,//手机号登录成功
    
};

#define currentUserModel (DDCurrentUserDataModel *)[DDCurrentUserDataModel currentUser]

/** 当前用户信息 */
@interface DDCurrentUserDataModel : NSObject <NSCoding, NSCopying>

/** 当前用户状态 */
@property (nonatomic, assign) DDLoginIdentityType loginIdentityType;

/** 用户唯一标识符 */
@property (nonatomic, strong) NSString * openId;

/** 手机号 */
@property (nonatomic, strong) NSString * mobileNo;

#pragma mark - 方法
/**获取当前用户*/
+ (instancetype)currentUser;

/** 获取缓存的手机号 */
+ (NSString *)getMobileNo;

/** 保存当前用户 */
+ (void)saveMySelf;

/** 判断用户是否已经登录成功 */
+ (BOOL)isLoginSucces;

/** 清除当前用户数据 */
+ (void)clearMyself;

/** 刷新用户信息数据 */
+ (void)refreshUserInfoData:(NSDictionary *)dict;

/** 发送登录成功通知 */
+ (void)postNotificationLoginSucces;

/** 发送退出登录通知 */
+ (void)postNotificationQuitLogin;

/** 发送小区数据改变了 */
+ (void)postNotificationCommunityValueChanged;

/** 小区数据改变，添加观察*/
+ (void)addCommunityValueChangedObserver:(id)obj selector:(SEL)sel;


@end
