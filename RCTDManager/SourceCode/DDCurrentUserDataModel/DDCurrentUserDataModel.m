//
//  DDCurrentUserDataModel.m
//  DoorDuOEM
//
//  Created by matt on 2018/4/10.
//  Copyright © 2018年 广州人创天地有限公司 All rights reserved.
//

#import "DDCurrentUserDataModel.h"
#import "YYModel.h"
#import "YYCache.h"

#define KCurrentUserDataModeKey @"KCurrentUserDataModeKeyNow"

#define KCurrentUserDataModeKeyCacheWithName @"KCurrentUserDataModeKeyCacheWithName"

@interface DDCurrentUserDataModel ()

@end

@implementation DDCurrentUserDataModel

// 直接添加以下代码即可自动完成
- (void)encodeWithCoder:(NSCoder *)aCoder { [self yy_modelEncodeWithCoder:aCoder]; }
- (id)initWithCoder:(NSCoder *)aDecoder { self = [super init]; return [self yy_modelInitWithCoder:aDecoder]; }
- (id)copyWithZone:(NSZone *)zone { return [self yy_modelCopy]; }
- (NSUInteger)hash { return [self yy_modelHash]; }
- (BOOL)isEqual:(id)object { return [self yy_modelIsEqual:object]; }
- (NSString *)description { return [self yy_modelDescription]; }

+ (instancetype)currentUser
{
    static DDCurrentUserDataModel * user = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        DDCurrentUserDataModel * restoreUser = [self __restoreMyself];
        if (restoreUser) {
            user = restoreUser;
        } else {
            user = [[self alloc] init];
        }
    });
    return user;
}

/** 获取缓存的手机号 */
+ (NSString *)getMobileNo
{
    DDCurrentUserDataModel * userModel = currentUserModel;
    if (userModel.mobileNo && userModel.mobileNo.length) {
        return userModel.mobileNo;
    }
    return nil;
}

/**保存当前用户*/
+ (void)saveMySelf
{
    YYCache * cache = [self _currentYYCache];
    DDCurrentUserDataModel * userModel = currentUserModel;
//    NSDictionary * userDictionary = [userModel yy_modelToJSONObject];
    [cache setObject:userModel forKey:KCurrentUserDataModeKey];
}
/**恢复当前用户*/
+ (id)__restoreMyself
{
    YYCache * cache = [self _currentYYCache];
    DDCurrentUserDataModel * userModel = (DDCurrentUserDataModel *)[cache objectForKey:KCurrentUserDataModeKey];
    return userModel;
}
/**判断用户是否存在*/
+ (BOOL)isLoginSucces
{
    DDCurrentUserDataModel * userModel = currentUserModel;
    if (userModel.loginIdentityType == DDLoginIdentityPhoneSuccesType) {
        return YES;
    }
    return NO;
}
/**清除当前用户数据*/
+ (void)clearMyself
{
    DDCurrentUserDataModel * userModel = currentUserModel;
    userModel.loginIdentityType = DDLoginIdentityNoLoginType;
    userModel.openId = nil;
    [DDCurrentUserDataModel saveMySelf];
}

/** 当前模型的 YYCache */
+ (YYCache *)_currentYYCache
{
    static YYCache * cahce = nil;
    if (!cahce) {
        cahce = [YYCache cacheWithPath:[self myselfSaveFillPath]];
    }
    return cahce;
}

//获取当前的归档后保存的路径
+ (NSString * )myselfSaveFillPath
{
    return [NSHomeDirectory() stringByAppendingString:@"/Documents/DDCurrentUserDataModel"];
}

/** 刷新用户信息数据 */
+ (void)refreshUserInfoData:(NSDictionary *)dict
{
    DDCurrentUserDataModel * userModel = currentUserModel;
    if (dict[@"open_id"]) {
        userModel.openId = [dict[@"open_id"] toString];
    }
}

/** 发送登录成功通知 */
+ (void)postNotificationLoginSucces
{
    DDCurrentUserDataModel * userModel = currentUserModel;
    userModel.loginIdentityType = DDLoginIdentityPhoneSuccesType;
    [DDCurrentUserDataModel saveMySelf];
    [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@(DDLoginIdentityPhoneSuccesType)];
}

/** 发送退出登录通知 */
+ (void)postNotificationQuitLogin
{
    DDCurrentUserDataModel * userModel = currentUserModel;
    userModel.loginIdentityType = DDLoginIdentityNoLoginType;
    [DDCurrentUserDataModel saveMySelf];
    [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@(DDLoginIdentityNoLoginType)];
}

@end
